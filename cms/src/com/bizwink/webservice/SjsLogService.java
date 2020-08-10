package com.bizwink.webservice;

import com.bizwink.cms.publish.IPublishManager;
import com.bizwink.cms.publish.PublishException;
import com.bizwink.cms.publish.PublishPeer;
import com.bizwink.po.Sjslog;
import com.bizwink.publishQueue.IPublishQueueManager;
import com.bizwink.publishQueue.Jobinfo;
import com.bizwink.publishQueue.PublishQueueException;
import com.bizwink.publishQueue.PublishQueuePeer;
import com.bizwink.service.BjSjslogService;
import org.springframework.context.ApplicationContext;
import org.springframework.web.context.ContextLoaderListener;

import java.io.UnsupportedEncodingException;
import java.math.BigDecimal;
import java.net.URL;
import java.net.URLDecoder;

/**
 * Created by IntelliJ IDEA.
 * User: Administrator
 * Date: 2010-12-7
 * Time: 22:22:26
 * To change this template use File | Settings | File Templates.
 */
public class SjsLogService {
    private int requestCount = 0;

    public String getName(String name) {
        IPublishQueueManager publishQueueManager = PublishQueuePeer.getInstance();
        Jobinfo jobinfo = null;
        try {
            jobinfo = publishQueueManager.getOneJob();
        } catch (PublishQueueException exp) {

        }

        return "Hello " + name + "===您好";
    }

    public String publishBjsjsArticle(int articleID,int siteid,int sitetype,int samsiteid, String appPath, String sitename,String username,int imgflag,int option,boolean isown,int columnID) {
        IPublishManager publishMgr = PublishPeer.getInstance();
        int retcode = -1;
        System.out.println("articleID=" + articleID);
        System.out.println("siteid=" + siteid);
        System.out.println("sitetype=" + sitetype);
        System.out.println("samsiteid=" + samsiteid);
        System.out.println("appPath=" + appPath);
        System.out.println("sitename=" + sitename);
        System.out.println("username=" + username);
        System.out.println("imgflag=" + imgflag);
        System.out.println("option=" + option);
        System.out.println("columnID=" + columnID);

        try {
            if (articleID != 0) {
                //发布文章页
                retcode = publishMgr.CreateArticlePage(articleID, siteid, sitetype, samsiteid, appPath, sitename, username, imgflag, option, isown, columnID);
                //发布网站首页,8395为首页的模板ID
                int homePageTemplateID = 8395;
                retcode = publishMgr.createHomePage(siteid, sitetype, samsiteid, appPath, sitename, username, imgflag, option, homePageTemplateID);
                // 石景山动态的栏目页，8382为石景山动态栏目的模板页
                int newsPageTemplateID = 8382;
                retcode = publishMgr.CreateColPage(columnID, siteid, sitetype, samsiteid, appPath, sitename, username, imgflag, option, newsPageTemplateID);
            } else {    //石景山新闻网执行的是文章删除操作
                //发布网站首页,8395为首页的模板ID
                int homePageTemplateID = 8395;
                retcode = publishMgr.createHomePage(siteid, sitetype, samsiteid, appPath, sitename, username, imgflag, option, homePageTemplateID);
                // 石景山动态的栏目页，8382为石景山动态栏目的模板页
                int newsPageTemplateID = 8382;
                retcode = publishMgr.CreateColPage(columnID, siteid, sitetype, samsiteid, appPath, sitename, username, imgflag, option, newsPageTemplateID);
            }
        } catch (PublishException exp) {
            exp.printStackTrace();
        }
        return "Hello " + retcode + "===您好";
    }


    //siteid			number     		not null,               --站点ID
    //sitename		varchar2(50)		not null,               --站点名称
    //columnid                number,                                         --栏目ID
    //columnname              varchar2(50),                                   --栏目名称
    //articleid		number			not null,               --文章ID
    //maintitle		varchar2(600)	        not null,               --文章中文标题
    //articleurl              varchar2(300),                                  --文章URL
    //operationtype           number(1),                                      --文章操作类型    1-增加   2-修改 3-删除
    //editor                  varchar2(50),                                   --文章作者
    public int addLogInfo(int siteid,String sitename,int columnid,String columnname,int articleid,String maintitle,String articleurl,int operationtype,String editor) {
        int errcode = 0;

        Sjslog sjslog = new Sjslog();
        sjslog.setSiteid(BigDecimal.valueOf(siteid));
        sjslog.setSitename(sitename);
        sjslog.setColumnid(BigDecimal.valueOf(columnid));
        sjslog.setColumnname(columnname);
        sjslog.setArticleid(BigDecimal.valueOf(articleid));
        sjslog.setMaintitle(maintitle);
        sjslog.setArticleurl(articleurl);
        sjslog.setOperationtype((short)operationtype);
        sjslog.setEditor(editor);

        if (operationtype ==1) {
            sjslog.setCreatedate(new java.util.Date(System.currentTimeMillis()));
            sjslog.setUpdatedate(new java.util.Date(System.currentTimeMillis()));
        } else if (operationtype ==2) {
            sjslog.setUpdatedate(new java.util.Date(System.currentTimeMillis()));
        } else {
            sjslog.setDeletedate(new java.util.Date(System.currentTimeMillis()));
        }

        ApplicationContext applicationContext = ContextLoaderListener.getCurrentWebApplicationContext();
        if (applicationContext != null) {
            BjSjslogService sjslogService = applicationContext.getBean(BjSjslogService.class);
            BigDecimal mkey = sjslogService.getKey();
            sjslog.setId(mkey);
            errcode = sjslogService.insertSjsLogInfo(sjslog);
        } else {
            System.out.println("applicationContext get failed" );
        }

        return errcode;
    }

    public Float add(float a,float b) {
        //获取分类信息
        //List columnList = organizationService.getColumnList();

        requestCount++;
        String result="a=" + a + ",b=" + b;
        System.out.println("requestCount=" + requestCount);
        System.out.println("Received: " + result);

        return a + b;
    }

    private String getWebInfPath(){
        URL url = getClass().getProtectionDomain().getCodeSource().getLocation();
        String path = url.toString();
        int index = path.indexOf("WEB-INF");

        if(index == -1){
            index = path.indexOf("classes");
        }

        if(index == -1){
            index = path.indexOf("bin");
        }

        path = path.substring(0, index);

        if(path.startsWith("zip")){//当class文件在war中时，此时返回zip:D:/...这样的路径
            path = path.substring(4);
        }else if(path.startsWith("file")){//当class文件在class文件中时，此时返回file:/D:/...这样的路径
            path = path.substring(6);
        }else if(path.startsWith("jar")){//当class文件在jar文件里面时，此时返回jar:file:/D:/...这样的路径
            path = path.substring(10);
        }
        try {
            path =  URLDecoder.decode(path, "UTF-8");
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
        }

        return path;
    }

}
