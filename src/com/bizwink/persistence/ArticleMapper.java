package com.bizwink.persistence;

import com.bizwink.po.Article;
import com.bizwink.vo.MediaArticle;
import com.bizwink.vo.TurnpicArticle;
import org.apache.ibatis.annotations.Param;

import java.math.BigDecimal;
import java.util.List;
import java.util.Map;

public interface ArticleMapper {
    List<Article> getNeedIndex(int siteid);

    List<Article> getDeleteIndex();

    //将该文章所在栏目及该栏目的所有父节点的id取出来拼成逗号字符串
    String getColumnParents(int id); //其父亲栏目id以逗号分隔组成一个字符串

    String getColumnDirname(int columnid);        //获取文章所造栏目的目录路径

    void updateIdxFlagByids(@Param(value = "ids") String  ids);

    BigDecimal getMainKey();

    List<Article> getArticlesBySiteidAndColumnid(Map<String, Object> params);

    List<Article> getArticleList(Map<String, Object> params);

    List<Article> getArticlesByColumnids(Map<String, Object> params);

    List<Article> getArticlesInPageBySiteidAndColumnid(Map<String, Object> params);

    List<MediaArticle> getMultiMediaArticlesInPageByColumnid(Map<String, Object> params);

    List<TurnpicArticle> getTurnpicArticlesInPageByColumnid(Map<String, Object> params);

    Integer getArticlesCountByColumnids(Map<String, Object> params);

    List<Article> getArticlesByColumnid(BigDecimal columnid);

    List<Article> getArticlesInPageByColumnid(Map<String, Object> params);

    List<Article>  getArticleListbyCreator(Map<String, Object> param);

    List<Article>  getArticleListbyDeptid(Map<String, Object> param);

    List<Article>  searchArticleListbyDeptidAndKeyword(Map<String, Object> param);

    BigDecimal countArticlebyDeptidAndKeyword(Map<String, Object> param);

    BigDecimal  countArticlebyDeptid(Map<String, Object> param);

    List<Article> getOrderByBuyname(Map<String, Object> param);

    Integer countArticleBySiteidAndColumnid(Map<String, Object> params);

    Article selectByPrimaryKey(BigDecimal ID);

    Article getArticleByUseridAndArticleid(Map<String, Object> params);

    List<Article> getArticleByUseridAndStatus(Map<String, Object> params);

    List<Article> getRejectArticlesbyDeptid(Map<String, Object> params);

    BigDecimal countRejectArticlebyDeptid(Map<String, Object> params);

    List<Article> searchRejectArticlesbyDeptidAndKeyword(Map<String, Object> params);

    BigDecimal countSearchRejectArticlebyDeptidAndKeyword(Map<String, Object> params);

    int deleteByPrimaryKey(BigDecimal ID);

    int deleteByArticleIDS(Map<String, Object> params);

    int insert(Article record);

    int insertNoContent(Article record);

    int updateByPrimaryKey(Article record);

    int updateNoContent(Article record);

    int UpdateArticleStatus(Map<String, Object> param);
}