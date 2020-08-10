package com.bizwink.service;

import com.bizwink.cms.server.MyConstants;
import com.bizwink.persistence.ArticleExtendattrMapper;
import com.bizwink.po.ArticleExtendattr;
import com.bizwink.vo.ArticleAndExtendAttrs;
import com.bizwink.persistence.ColumnMapper;
import com.bizwink.po.Article;
import com.bizwink.persistence.ArticleMapper;
import com.bizwink.po.Column;
import com.bizwink.vo.MediaArticle;
import com.bizwink.vo.TurnpicArticle;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by Administrator on 17-4-4.
 */
@Service
public class ArticleService {
    @Autowired
    private ArticleMapper articleMapper;

    @Autowired
    private ArticleExtendattrMapper articleExtendattrMapper;

    @Autowired
    private ColumnMapper columnMapper;

    public List<ArticleAndExtendAttrs> getArticlesIncludeAttrs(List<Integer> artids) {
        List<ArticleAndExtendAttrs> articleAndExtendAttrsList = new ArrayList<ArticleAndExtendAttrs>();

        //获取文章的主数据信息
        for (int ii = 0; ii < artids.size(); ii++) {
            ArticleAndExtendAttrs articleAndExtendAttrs = new ArticleAndExtendAttrs();
            Article article = articleMapper.selectByPrimaryKey(BigDecimal.valueOf(artids.get(ii)));
            //设置主数据信息
            if (article != null) {
                articleAndExtendAttrs.setId(article.getID().intValue());
                articleAndExtendAttrs.setColumnid(article.getCOLUMNID().intValue());
                articleAndExtendAttrs.setMaintitle(article.getMAINTITLE());
                articleAndExtendAttrs.setSummary(article.getSUMMARY());
                articleAndExtendAttrs.setSource(article.getSUMMARY());
                articleAndExtendAttrs.setEditor(article.getEDITOR());
                articleAndExtendAttrs.setKeyword(article.getKEYWORD());
                articleAndExtendAttrs.setUrltype(article.getURLTYPE());
                articleAndExtendAttrs.setDefineurl(article.getDEFINEURL());
                articleAndExtendAttrs.setContent(article.getCONTENT());
                articleAndExtendAttrs.setCreatedate(article.getCREATEDATE());
                articleAndExtendAttrs.setLastupdated(article.getLASTUPDATED());
                articleAndExtendAttrs.setPublishtime(article.getPUBLISHTIME());
                articleAndExtendAttrs.setCreator(article.getCREATOR());
                articleAndExtendAttrs.setBILLNO(article.getBILLNO());
                articleAndExtendAttrs.setPK_TRANPRO(article.getPK_TRANPRO());
                articleAndExtendAttrs.setPK_TRANPROTYPE(article.getPK_TRANPROTYPE());

                //获取扩展属性信息
                List<ArticleExtendattr> extendattrs = articleExtendattrMapper.selectByArticleid(article.getID().intValue());
                /*for (int jj = 0; jj < extendattrs.size(); jj++) {
                    ArticleExtendattr extendattr = extendattrs.get(jj);
                    if (extendattr.getType() == 1) {
                        System.out.println(extendattr.getEname() + "==" + extendattr.getStringvalue());
                    } else if (extendattr.getType() == 2) {
                        System.out.println(extendattr.getEname() + "==" + extendattr.getNumericvalue());
                    } else if (extendattr.getType() == 4) {
                        System.out.println(extendattr.getEname() + "==" + extendattr.getFloatvalue());
                    }
                }*/

                //设置文章的扩展属性信息
                articleAndExtendAttrs.setArticleExtendattrs(extendattrs);
                articleAndExtendAttrsList.add(articleAndExtendAttrs);
            }
        }

        return articleAndExtendAttrsList;
    }

    public ArticleAndExtendAttrs getArticleAndEXtendAttrs(int articleid){
        ArticleAndExtendAttrs articleAndExtendAttrs = new ArticleAndExtendAttrs();

        //获取文章的主数据信息
        Article article = articleMapper.selectByPrimaryKey(BigDecimal.valueOf(articleid));

        //设置主数据信息
        if (article!=null) {
            articleAndExtendAttrs.setId(article.getID().intValue());
            articleAndExtendAttrs.setMaintitle(article.getMAINTITLE());
            articleAndExtendAttrs.setSummary(article.getSUMMARY());
            articleAndExtendAttrs.setSource(article.getSUMMARY());
            articleAndExtendAttrs.setEditor(article.getEDITOR());
            articleAndExtendAttrs.setKeyword(article.getKEYWORD());
            articleAndExtendAttrs.setUrltype(article.getURLTYPE());
            articleAndExtendAttrs.setDefineurl(article.getDEFINEURL());
            articleAndExtendAttrs.setContent(article.getCONTENT());
            articleAndExtendAttrs.setCreatedate(article.getCREATEDATE());
            articleAndExtendAttrs.setLastupdated(article.getLASTUPDATED());
            articleAndExtendAttrs.setPublishtime(article.getPUBLISHTIME());
            articleAndExtendAttrs.setCreator(article.getCREATOR());
            articleAndExtendAttrs.setBILLNO(article.getBILLNO());
            articleAndExtendAttrs.setPK_TRANPRO(article.getPK_TRANPRO());
            articleAndExtendAttrs.setPK_TRANPROTYPE(article.getPK_TRANPROTYPE());
        }

        //获取扩展属性信息
        List<ArticleExtendattr> extendattrs = articleExtendattrMapper.selectByArticleid(articleid);

        /*for(int ii=0; ii<extendattrs.size();ii++) {
            ArticleExtendattr extendattr = extendattrs.get(ii);
            if (extendattr.getType() == 1) {
                System.out.println(extendattr.getEname() + "==" + extendattr.getStringvalue());
            } else if (extendattr.getType() ==2) {
                System.out.println(extendattr.getEname() + "==" + extendattr.getNumericvalue());
            } else if (extendattr.getType() == 4) {
                System.out.println(extendattr.getEname() + "==" + extendattr.getFloatvalue());
            }
        }*/

        //设置文章的扩展属性信息
        articleAndExtendAttrs.setArticleExtendattrs(extendattrs);

        return articleAndExtendAttrs;
    }

    public Integer getArticlesCountByColumnids(BigDecimal siteid,BigDecimal rcolumnid,String keyword) {
        Map<String,Object> params = new HashMap<String,Object>();
        List<String> subnodes = MyConstants.getColumns();  //getSubnodes(rcolumnid);
        params.put("list",subnodes);
        params.put("keyword",keyword);
        return  articleMapper.getArticlesCountByColumnids(params);
    }

    public List<Article> getArticlesByColumnids(BigDecimal siteid,BigDecimal rcolumnid,String keyword,BigDecimal startnum,BigDecimal endnum) {
        Map<String,Object> params = new HashMap<String,Object>();
        List<String> subnodes = MyConstants.getColumns();  //getSubnodes(rcolumnid);
        params.put("list",subnodes);
        params.put("keyword",keyword);
        params.put("beginrow",startnum);
        params.put("endrow",endnum);
        return articleMapper.getArticlesByColumnids(params);
    }

    public List<String> getSubnodes(BigDecimal  rcolumnid) {
        List<BigDecimal> parents = new ArrayList<BigDecimal>();
        List<String> results = new ArrayList<String>();
        parents.add(rcolumnid);
        int i = 0;

        do {
            BigDecimal pid = parents.get(i);
            results.add(String.valueOf(pid.intValue()));
            parents.remove(i);
            i = i - 1;
            List<Column> items = columnMapper.getSubColumnsByParentID(pid);
            for(int j=0; j<items.size(); j++) {
                Column column = (Column)items.get(j);
                parents.add(column.getID());
                i = i + 1;
            }
        } while (parents.size() > 0);

        return results;
    }

    public List<Article> getArticleByDept(String deptid,BigDecimal siteid,BigDecimal startno,BigDecimal endno){
        Map<String,Object> params = new HashMap<String,Object>();
        params.put("deptid",deptid);
        params.put("siteid",siteid);
        params.put("BEGINROW",startno);
        params.put("ENDROW",endno);

        return articleMapper.getArticleListbyDeptid(params);
    }

    public List<Article> getArticlesByColumn(BigDecimal columnid){
        return articleMapper.getArticlesByColumnid(columnid);
    }

    public List<Article> getArticlesInPageByColumn(BigDecimal columnid,BigDecimal startrow,BigDecimal endrow){
        Map<String,Object> params = new HashMap();
        params.put("COLUMNID",columnid);
        params.put("START",startrow);
        params.put("END",endrow);
        return articleMapper.getArticlesInPageByColumnid(params);
    }

    public List<MediaArticle> getMultiMediaArticlesInPageByColumnid(BigDecimal columnid,BigDecimal startrow,BigDecimal endrow) {
        Map<String,Object> params = new HashMap();
        params.put("COLUMNID",columnid);
        params.put("START",startrow);
        params.put("END",endrow);
        return articleMapper.getMultiMediaArticlesInPageByColumnid(params);
    }

    public List<TurnpicArticle> getTurnpicArticlesInPageByColumnid(BigDecimal columnid,BigDecimal startrow,BigDecimal endrow) {
        Map<String,Object> params = new HashMap();
        params.put("COLUMNID",columnid);
        params.put("START",startrow);
        params.put("END",endrow);
        return articleMapper.getTurnpicArticlesInPageByColumnid(params);
    }

    public BigDecimal countArticleByDeptid(String deptid,BigDecimal siteid) {
        Map<String,Object> params = new HashMap<String,Object>();
        params.put("deptid",deptid);
        params.put("siteid",siteid);

        return articleMapper.countArticlebyDeptid(params);
    }

    public List<Article> searchArticleByDeptAndKeyword(String deptid,String keyword,BigDecimal status,BigDecimal pubflag,BigDecimal siteid,BigDecimal startno,BigDecimal endno){
        Map<String,Object> params = new HashMap<String,Object>();
        params.put("deptid",deptid);
        params.put("siteid",siteid);
        params.put("searchword",keyword);
        params.put("status",status);
        params.put("pubflag",pubflag);
        params.put("BEGINROW",startno);
        params.put("ENDROW",endno);

        return articleMapper.searchArticleListbyDeptidAndKeyword(params);
    }

    public BigDecimal countArticlebyDeptidAndKeyword(String deptid,String keyword,BigDecimal status,BigDecimal pubflag,BigDecimal siteid) {
        Map<String,Object> params = new HashMap<String,Object>();
        params.put("deptid",deptid);
        params.put("siteid",siteid);
        params.put("searchword",keyword);
        params.put("status",status);
        params.put("pubflag",pubflag);

        return articleMapper.countArticlebyDeptidAndKeyword(params);
    }

    public int deleteArticleByAidList(BigDecimal siteid,String artids) {
        Map<String,Object> params = new HashMap<String,Object>();
        params.put("artids",artids);
        params.put("siteid",siteid);

        return articleMapper.deleteByArticleIDS(params);
    }

    public List<Article> getRejectArticlesbyDeptid(String deptid,BigDecimal status,BigDecimal pubflag,BigDecimal auditflag,BigDecimal siteid,BigDecimal startno,BigDecimal endno) {
        Map<String,Object> params = new HashMap<String,Object>();
        params.put("deptid",deptid);
        params.put("siteid",siteid);
        params.put("status",status);
        params.put("pubflag",pubflag);
        params.put("auditflag",auditflag);
        params.put("BEGINROW",startno);
        params.put("ENDROW",endno);

        return articleMapper.getRejectArticlesbyDeptid(params);
    }

    public BigDecimal countRejectArticlebyDeptid(String deptid,BigDecimal status,BigDecimal pubflag,BigDecimal auditflag,BigDecimal siteid) {
        Map<String,Object> params = new HashMap<String,Object>();
        params.put("deptid",deptid);
        params.put("siteid",siteid);
        params.put("status",status);
        params.put("pubflag",pubflag);
        params.put("auditflag",auditflag);

        return articleMapper.countRejectArticlebyDeptid(params);
    }

    public List<Article> searchRejectArticlesbyDeptidAndKeyword(String deptid,String keyword,BigDecimal status,BigDecimal pubflag,BigDecimal auditflag,BigDecimal siteid,BigDecimal startno,BigDecimal endno) {
        Map<String,Object> params = new HashMap<String,Object>();
        params.put("deptid",deptid);
        params.put("siteid",siteid);
        params.put("searchword",keyword);
        params.put("status",status);
        params.put("pubflag",pubflag);
        params.put("auditflag",auditflag);
        params.put("BEGINROW",startno);
        params.put("ENDROW",endno);

        return articleMapper.searchRejectArticlesbyDeptidAndKeyword(params);
    }

    public BigDecimal countSearchRejectArticlebyDeptidAndKeyword(String deptid,String keyword,BigDecimal status,BigDecimal pubflag,BigDecimal auditflag,BigDecimal siteid) {
        Map<String,Object> params = new HashMap<String,Object>();
        params.put("deptid",deptid);
        params.put("siteid",siteid);
        params.put("searchword",keyword);
        params.put("status",status);
        params.put("pubflag",pubflag);
        params.put("auditflag",auditflag);

        return articleMapper.countSearchRejectArticlebyDeptidAndKeyword(params);
    }

    public Article getArticleByID(BigDecimal articleid) {
        return articleMapper.selectByPrimaryKey(articleid);
    }

    public int saveArticleNoContent(Article article) {
        return articleMapper.insertNoContent(article);
    }

    public int updateArticleNoContent(Article article) {
        return articleMapper.updateNoContent(article);
    }

    public BigDecimal getMainKey() {
        return articleMapper.getMainKey();
    }
}
