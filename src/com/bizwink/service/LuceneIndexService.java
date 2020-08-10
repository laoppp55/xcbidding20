package com.bizwink.service;

import com.bizwink.cms.server.InitServer;
import com.bizwink.indexer.DBDocument;
import com.bizwink.persistence.ArticleMapper;
import com.bizwink.persistence.ColumnMapper;
import com.bizwink.persistence.SiteinfoMapper;
import com.bizwink.po.Article;
import com.bizwink.po.Column;
import com.bizwink.po.Siteinfo;
import com.bizwink.util.StringUtil;
import org.apache.log4j.Logger;
import org.apache.lucene.analysis.Analyzer;
import org.apache.lucene.document.Document;
import org.apache.lucene.index.*;
import org.apache.lucene.store.Directory;
import org.apache.lucene.store.SimpleFSDirectory;
import org.apache.lucene.util.Version;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.quartz.QuartzJobBean;
import org.springframework.stereotype.Service;
import org.wltea.analyzer.lucene.IKAnalyzer;

import java.io.File;
import java.io.IOException;
import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;

/**
 * Created by IntelliJ IDEA.
 * User: jackzhang
 * Date: 13-10-14
 * Time: 下午7:29
 * To change this template use File | Settings | File Templates.
 */
@Service
public class LuceneIndexService extends QuartzJobBean {
    @Autowired
    private ArticleMapper articleMapper;

    @Autowired
    private ColumnMapper columnMapper;

    @Autowired
    private SiteinfoMapper siteinfoMapper;

    public static Logger logger = Logger.getLogger(LuceneIndexService.class.getName());

    public void createIndex(){
        InitServer.getInstance().init();
        String indexPath = InitServer.getProperties().getProperty("main.indexPath");
        createIndex(indexPath);
    }

    public void createIndex(String indexPath) {
        Date start = new Date();
        logger.debug("create index begin===" + indexPath);
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

        IndexWriter writer =null;
        Directory directory = null;
        List<Siteinfo> siteinfoList = siteinfoMapper.getSiteinfos();
        String s_index_path = indexPath;
        for(int ii=0;ii<siteinfoList.size();ii++) {
            Siteinfo siteinfo = siteinfoList.get(ii);
            if (indexPath.endsWith(File.separator))
                indexPath = s_index_path + StringUtil.replace(siteinfo.getSITENAME(),".","_");
            else
                indexPath = s_index_path + File.separator + StringUtil.replace(siteinfo.getSITENAME(),".","_");
            File file = new File(indexPath);
            if (!file.exists()) {
                file.mkdirs();
            }
            try {
                Analyzer analyzer = new IKAnalyzer();
                directory = new SimpleFSDirectory(new File(indexPath));
                if (IndexWriter.isLocked(directory)) IndexWriter.unlock(directory);
                writer = new IndexWriter(directory, new IndexWriterConfig(Version.LUCENE_45, analyzer));
                // 删除所有document
                //writer.deleteAll();
                indexDoc(writer, siteinfo.getSITEID().intValue());
            } catch (IOException exp) {
                exp.printStackTrace();
            } finally {
                if(writer!=null && directory!=null){
                    try {
                        writer.commit();
                        writer.close();
                        directory.close();
                    } catch (IOException e) {
                        e.printStackTrace();
                    }
                };
            }
            logger.debug(siteinfo.getSITENAME() +  "：index end");
        }
        Date end = new Date();
        logger.debug(end.getTime() - start.getTime() + " total milliseconds");
    }

    void  indexDoc(IndexWriter writer,int siteid) {
        List<Article> articleList =articleMapper.getNeedIndex(siteid);
       // List<Article> articleList =DBUtil.getNeedIndex(siteid);
        int looptime=0;
        String artcileids ="";
        while (articleList !=null &&(articleList.size()>0) ){
            artcileids = indexResult(writer,siteid,articleList);
            articleMapper.updateIdxFlagByids(artcileids);
            looptime++;
            if (looptime <4 ){
                articleList =articleMapper.getNeedIndex(siteid);
            }else{
                articleList =null;
            }
        }
    }

    String  indexResult(IndexWriter writer,int siteid,List artlist ) {
        String artcileids ="";
        try {
            if (artlist !=null && (artlist.size() > 0)) {
                Article article=null;
                Document doc =null;
                for(int i=0; i<artlist.size(); i++) {
                    article = (Article)artlist.get(i);

                    if(artcileids ==""){
                        artcileids += article.getID();
                    }else{
                        artcileids += ","+article.getID();
                    }

                    //将该文章所在栏目及该栏目的所有父节点的id取出来拼成逗号字符串
                    int columnid = article.getCOLUMNID().intValue();
                    Column column = columnMapper.selectByPrimaryKey(BigDecimal.valueOf(columnid));
                    String columnChineseName = column.getCNAME();
                    String articlePathinfo = "c" + columnid;
                    columnid = column.getPARENTID().intValue();
                    while (columnid>0) {
                        column = columnMapper.selectByPrimaryKey(BigDecimal.valueOf(columnid));
                        columnid = column.getPARENTID().intValue();
                        articlePathinfo = articlePathinfo  + columnid;
                    }
                    String dirname = articleMapper.getColumnDirname(article.getCOLUMNID().intValue());
                    if (dirname != null) {
                        article.setDIRNAME(dirname);
                        System.out.println(article.getMAINTITLE() + ":被索引");
                        doc  = DBDocument.Document(siteid,articlePathinfo,columnChineseName,article);
                        writer.addDocument(doc);
                    }
                }
            }
        }catch(IOException e){
            e.printStackTrace();
        }
        return artcileids;
    }

    private String getArticlePathInfo(String columnids) {

        return null;
    }

    @Override
    protected void executeInternal(JobExecutionContext context) throws JobExecutionException {
        Map properties = context.getJobDetail().getJobDataMap();
        String message = (String)properties.get("message");
        this.createIndex();
    }
}
