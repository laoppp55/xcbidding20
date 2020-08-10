package com.bizwink.service;

import com.bizwink.cms.server.MyConstants;
import com.bizwink.persistence.ColumnMapper;
import com.bizwink.po.Article;
import com.bizwink.persistence.ArticleMapper;
import com.bizwink.po.Column;
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
    private ColumnMapper columnMapper;

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

    public List<String> getSubnodes(BigDecimal siteid,BigDecimal  rcolumnid) {
        List<BigDecimal> parents = new ArrayList<BigDecimal>();
        List<String> results = new ArrayList<String>();
        parents.add(rcolumnid);
        int i = 0;
        Map params = null;

        do {
            BigDecimal pid = parents.get(i);
            results.add(String.valueOf(pid.intValue()));
            parents.remove(i);
            i = i - 1;
            params = new HashMap();
            params.put("SITEID",siteid);
            params.put("PARENTID",pid);
            List<Column> items = columnMapper.getSubColumnsByParentID(params);
            for(int j=0; j<items.size(); j++) {
                Column column = (Column)items.get(j);
                parents.add(column.getID());
                i = i + 1;
            }
            params = null;
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
