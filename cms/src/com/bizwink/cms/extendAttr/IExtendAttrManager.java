package com.bizwink.cms.extendAttr;

import java.util.*;

import com.bizwink.cms.audit.Audit;
import com.bizwink.images.Uploadimage;
import org.w3c.dom.*;
import com.bizwink.cms.news.*;
import com.bizwink.cms.xml.*;

public interface IExtendAttrManager {
    void create(List extendList, List attechments, Article article,List pubcolumns,List recommends, List<Uploadimage> turnlist, List auditlist,List mmfiles) throws ExtendAttrException;

    void update(List extendList, List attechments, Article article,List pubcolumns,List recommends, List turnlist,List auditlist,List mmfiles) throws ExtendAttrException;

    String PrintXML(Node node, StringBuffer content) throws ExtendAttrException;

    List getAttrForTemplate(int columnID) throws ExtendAttrException;

    List getAttrForStyle(int columnID) throws ExtendAttrException;

    List getArticleAttr(int articleID) throws ExtendAttrException;

    List getRecommendMarks(int articleid,int columnid,int siteid) throws ExtendAttrException;

    boolean querySameExtendAttr(int fromColumnID, int toColumnID) throws ExtendAttrException;

    String getXMLTemplate(int columnID);

    String getExtendAttrForArticle(String username,int columnID, int articleID) throws ExtendAttrException;

    String getExtendAttrForAudit(int columnID, int articleID) throws ExtendAttrException;

    List getArticleExtendValue(int articleID, List attrList) throws ExtendAttrException;

    List getExtendAttrForMark(int columnID, XMLProperties properties, String mark) throws ExtendAttrException;

    String getExtendAttrEName(int columnID) throws ExtendAttrException;

    List getEnglishAttrForTemplate(int columnID) throws ExtendAttrException;

    void referArticle(List articleList, int scid, int tsiteID, int useArtileType) throws ExtendAttrException;

    int addRelatedArticles(List relArticle, int articleID,int siteid);

    String getArticleTemplateExtendAttrForArticle(int columnID, int articleID,ExtendAttr ext) throws ExtendAttrException ;

    //读取审核意见
    List getArticleAudit(int articleid);
    //删除审核意见
    int deleteaudit(int id);

    int updataMoreTurnPicInfo(List tpics,int articleid);

    int insertTurnPic(Turnpic turnpic,int articleid);

    void batchDel(String articleIDs,String username) throws ExtendAttrException;
}
