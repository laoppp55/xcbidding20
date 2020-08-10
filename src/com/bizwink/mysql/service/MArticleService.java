package com.bizwink.mysql.service;

import com.bizwink.mysql.persistence.ArticleExtendattrMapper;
import com.bizwink.mysql.persistence.ArticleMapper;
import com.bizwink.mysql.po.Article;
import com.bizwink.mysql.po.ArticleExtendattr;
import com.bizwink.mysql.vo.ArticleAndExtendAttrs;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;

/**
 * Created by Administrator on 18-9-4.
 */
@Service
public class MArticleService {
    @Autowired
    private ArticleMapper articleMapper;

    @Autowired
    private ArticleExtendattrMapper articleExtendattrMapper;

    public ArticleAndExtendAttrs getArticleAndEXtendAttrs(int articleid){
        ArticleAndExtendAttrs articleAndExtendAttrs = new ArticleAndExtendAttrs();

        //获取文章的主数据信息
        Article article = articleMapper.selectByPrimaryKey(articleid);

        //设置主数据信息
        articleAndExtendAttrs.setId(article.getId());
        articleAndExtendAttrs.setMaintitle(article.getMaintitle());
        articleAndExtendAttrs.setSummary(article.getSummary());
        articleAndExtendAttrs.setSource(article.getSource());
        articleAndExtendAttrs.setEditor(article.getEditor());
        articleAndExtendAttrs.setKeyword(article.getKeyword());
        articleAndExtendAttrs.setUrltype(article.getUrltype());
        articleAndExtendAttrs.setDefineurl(article.getDefineurl());
        articleAndExtendAttrs.setContent(article.getContent());
        articleAndExtendAttrs.setCreatedate(article.getCreatedate());
        articleAndExtendAttrs.setLastupdated(article.getLastupdated());
        articleAndExtendAttrs.setPublishtime(article.getPublishtime());
        articleAndExtendAttrs.setCreator(article.getCreator());

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
}
