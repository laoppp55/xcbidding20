package com.bizwink.service;

import com.bizwink.cms.news.Article;
import com.bizwink.util.CommUtil;
import com.bizwink.util.SearchConfig;
import com.bizwink.util.SearchObject;
import org.apache.lucene.analysis.Analyzer;
import org.apache.lucene.analysis.TokenStream;
import org.apache.lucene.document.Document;
import org.apache.lucene.index.IndexReader;
import org.apache.lucene.index.MultiReader;
import org.apache.lucene.index.Term;
import org.apache.lucene.queryparser.classic.MultiFieldQueryParser;
import org.apache.lucene.queryparser.classic.QueryParser;
import org.apache.lucene.search.*;
import org.apache.lucene.search.highlight.*;
import org.apache.lucene.search.highlight.Formatter;
import org.apache.lucene.search.highlight.Scorer;
import org.apache.lucene.store.FSDirectory;
import org.apache.lucene.util.Version;
import org.wltea.analyzer.cfg.Configuration;
import org.wltea.analyzer.cfg.DefaultConfig;
import org.wltea.analyzer.core.IKSegmenter;
import org.wltea.analyzer.core.Lexeme;
import org.wltea.analyzer.lucene.IKAnalyzer;

import java.io.File;
import java.io.IOException;
import java.io.StringReader;
import java.util.*;

/**
 * Created by IntelliJ IDEA.
 * User: jackzhang
 * Date: 13-10-14
 * Time: 下午3:27
 * To change this template use File | Settings | File Templates.
 */

public class LuceneSearchService {

    private static   String[] defaultSearchField = {"maintitle","summary","keyword","content"};

    public static Map searchContent(String keyWord,int recordStart, int recordEnd){
        return searchContent(keyWord,recordStart,recordEnd,"",null);
    }

    public static Map searchContent(String keyWord, int recordStart, int recordEnd, int siteid) {
        return searchContent(keyWord, recordStart, recordEnd, "", null, siteid);
    }

    public static Map searchContentOnly(String keyWord, int recordStart, int recordEnd, String columns, String sortField, String[] scFieldAry, int siteid) {
        if (scFieldAry == null) scFieldAry = defaultSearchField;
        //sortField = "";
        if (sortField.length() == 0) {
            return searchContent(keyWord, recordStart, recordEnd, columns, scFieldAry, siteid);
        }

        try
        {
            //定义搜索内容
            String[] fields = {"content"};
            //QueryParser queryParser = new QueryParser("maintitle", analyzer);
            org.apache.lucene.queryparser.classic.MultiFieldQueryParser queryParser = new org.apache.lucene.queryparser.classic.MultiFieldQueryParser(Version.LUCENE_45,fields, new IKAnalyzer());  //lucene 2.4
            queryParser.setPhraseSlop(1);
            List<String> words = splitWord(keyWord, true); // 显示拆分结果
            String fc_keyword = "";
            if (keyWord!=null) {
                if (keyWord.length() > 4){
                    for (int ii=0; ii<words.size()-1; ii++) {
                        fc_keyword = fc_keyword + words.get(ii) + " OR ";
                    }
                    fc_keyword = fc_keyword + words.get(words.size()-1);
                } else {     //用户提供的查询语句小于4，不对用户输入的信息分词
                    fc_keyword = keyWord;
                }
            }

            Query query1 = queryParser.parse(fc_keyword);
            //Query query2 = new TermQuery(new Term("siteid", String.valueOf(siteid)));
            Query query2 = NumericRangeQuery.newIntRange("siteid", 40, 40, true,true);// 没问题

            BooleanQuery query = new BooleanQuery();
            query.add(query1, BooleanClause.Occur.MUST);
            query.add(query2, BooleanClause.Occur.MUST);

            return queryResult(recordStart, recordEnd, sortField, query,words);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public static Map searchMaintitleOnly(String keyWord, int recordStart, int recordEnd, String columns, String sortField, String[] scFieldAry, int siteid) {
        if (scFieldAry == null) scFieldAry = defaultSearchField;
        //sortField = "";
        if (sortField.length() == 0) {
            return searchContent(keyWord, recordStart, recordEnd, columns, scFieldAry, siteid);
        }

        try
        {
            //定义搜索内容
            String[] fields = {"maintitle"};
            //QueryParser queryParser = new QueryParser("maintitle", analyzer);
            org.apache.lucene.queryparser.classic.MultiFieldQueryParser queryParser = new org.apache.lucene.queryparser.classic.MultiFieldQueryParser(Version.LUCENE_45,fields, new IKAnalyzer());  //lucene 2.4
            queryParser.setPhraseSlop(1);
            List<String> words = splitWord(keyWord, true); // 显示拆分结果
            String fc_keyword = "";
            if (keyWord!=null) {
                if (keyWord.length() > 4){
                    for (int ii=0; ii<words.size()-1; ii++) {
                        fc_keyword = fc_keyword + words.get(ii) + " OR ";
                    }
                    fc_keyword = fc_keyword + words.get(words.size()-1);
                } else {     //用户提供的查询语句小于4，不对用户输入的信息分词
                    fc_keyword = keyWord;
                }
            }

            Query query1 = queryParser.parse(fc_keyword);
            //Query query2 = new TermQuery(new Term("siteid", String.valueOf(siteid)));
            Query query2 = NumericRangeQuery.newIntRange("siteid", 40, 40, true,true);// 没问题

            BooleanQuery query = new BooleanQuery();
            query.add(query1, BooleanClause.Occur.MUST);
            query.add(query2, BooleanClause.Occur.MUST);

            return queryResult(recordStart, recordEnd, sortField, query,words);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public static Map searchMaintitleAndContentOnly(String keyWord, int recordStart, int recordEnd, String columns, String sortField, String[] scFieldAry, int siteid) {
        if (scFieldAry == null) scFieldAry = defaultSearchField;
        //sortField = "";
        if (sortField.length() == 0) {
            return searchContent(keyWord, recordStart, recordEnd, columns, scFieldAry, siteid);
        }

        try
        {
            //定义搜索内容
            String[] fields = {"maintitle","content"};
            //QueryParser queryParser = new QueryParser("maintitle", analyzer);
            org.apache.lucene.queryparser.classic.MultiFieldQueryParser queryParser = new org.apache.lucene.queryparser.classic.MultiFieldQueryParser(Version.LUCENE_45,fields, new IKAnalyzer());  //lucene 2.4
            queryParser.setPhraseSlop(1);
            List<String> words = splitWord(keyWord, true); // 显示拆分结果
            String fc_keyword = "";
            if (keyWord!=null) {
                if (keyWord.length() > 4){
                    for (int ii=0; ii<words.size()-1; ii++) {
                        fc_keyword = fc_keyword + words.get(ii) + " OR ";
                    }
                    fc_keyword = fc_keyword + words.get(words.size()-1);
                } else {     //用户提供的查询语句小于4，不对用户输入的信息分词
                    fc_keyword = keyWord;
                }
            }

            Query query1 = queryParser.parse(fc_keyword);
            //Query query2 = new TermQuery(new Term("siteid", String.valueOf(siteid)));
            Query query2 = NumericRangeQuery.newIntRange("siteid", 40, 40, true,true);// 没问题

            BooleanQuery query = new BooleanQuery();
            query.add(query1, BooleanClause.Occur.MUST);
            query.add(query2, BooleanClause.Occur.MUST);

            return queryResult(recordStart, recordEnd, sortField, query,words);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public static Map searchMaintitleAndContentOnlyByPeriod (String startdate,String enddate,String keyWord, int recordStart, int recordEnd, String columns, String sortField, String[] scFieldAry, int siteid) {
        if (scFieldAry == null) scFieldAry = defaultSearchField;
        //sortField = "";
        if (sortField.length() == 0) {
            return searchContent(keyWord, recordStart, recordEnd, columns, scFieldAry, siteid);
        }

        try
        {
            //定义搜索内容
            String[] fields = {"maintitle","content"};
            //QueryParser queryParser = new QueryParser("maintitle", analyzer);
            org.apache.lucene.queryparser.classic.MultiFieldQueryParser queryParser = new org.apache.lucene.queryparser.classic.MultiFieldQueryParser(Version.LUCENE_45,fields, new IKAnalyzer());  //lucene 2.4
            queryParser.setPhraseSlop(1);
            List<String> words = splitWord(keyWord, true); // 显示拆分结果
            String fc_keyword = "";
            if (keyWord!=null) {
                if (keyWord.length() > 4){
                    for (int ii=0; ii<words.size()-1; ii++) {
                        fc_keyword = fc_keyword + words.get(ii) + " OR ";
                    }
                    fc_keyword = fc_keyword + words.get(words.size()-1);
                } else {     //用户提供的查询语句小于4，不对用户输入的信息分词
                    fc_keyword = keyWord;
                }
            }

            Query query1 = queryParser.parse(fc_keyword);
            //Query query2 = new TermQuery(new Term("siteid", String.valueOf(siteid)));
            Query query2 = NumericRangeQuery.newIntRange("siteid", 40, 40, true,true);// 没问题
            Query query3 = NumericRangeQuery.newIntRange("createdate", Integer.valueOf(startdate), Integer.valueOf(enddate), true, true);

            BooleanQuery query = new BooleanQuery();
            query.add(query1, BooleanClause.Occur.MUST);
            query.add(query2, BooleanClause.Occur.MUST);
            query.add(query3, BooleanClause.Occur.MUST);

            return queryResult(recordStart, recordEnd, sortField, query,words);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public static Map searchMaintitleOnlyByPeriod  (String startdate,String enddate,String keyWord, int recordStart, int recordEnd, String columns, String sortField, String[] scFieldAry, int siteid) {
        if (scFieldAry == null) scFieldAry = defaultSearchField;
        //sortField = "";
        if (sortField.length() == 0) {
            return searchContent(keyWord, recordStart, recordEnd, columns, scFieldAry, siteid);
        }

        try
        {
            //定义搜索内容
            String[] fields = {"maintitle"};
            //QueryParser queryParser = new QueryParser("maintitle", analyzer);
            org.apache.lucene.queryparser.classic.MultiFieldQueryParser queryParser = new org.apache.lucene.queryparser.classic.MultiFieldQueryParser(Version.LUCENE_45,fields, new IKAnalyzer());  //lucene 2.4
            queryParser.setPhraseSlop(1);
            List<String> words = splitWord(keyWord, true); // 显示拆分结果
            String fc_keyword = "";
            if (keyWord!=null) {
                if (keyWord.length() > 4){
                    for (int ii=0; ii<words.size()-1; ii++) {
                        fc_keyword = fc_keyword + words.get(ii) + " OR ";
                    }
                    fc_keyword = fc_keyword + words.get(words.size()-1);
                } else {     //用户提供的查询语句小于4，不对用户输入的信息分词
                    fc_keyword = keyWord;
                }
            }

            Query query1 = queryParser.parse(fc_keyword);
            //Query query2 = new TermQuery(new Term("siteid", String.valueOf(siteid)));
            Query query2 = NumericRangeQuery.newIntRange("siteid", 40, 40, true,true);// 没问题
            Query query3 = NumericRangeQuery.newIntRange("createdate", Integer.valueOf(startdate), Integer.valueOf(enddate), true, true);

            BooleanQuery query = new BooleanQuery();
            query.add(query1, BooleanClause.Occur.MUST);
            query.add(query2, BooleanClause.Occur.MUST);
            query.add(query3, BooleanClause.Occur.MUST);

            return queryResult(recordStart, recordEnd, sortField, query,words);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public static Map searchContentOnlyByPeriod  (String startdate,String enddate,String keyWord, int recordStart, int recordEnd, String columns, String sortField, String[] scFieldAry, int siteid) {
        if (scFieldAry == null) scFieldAry = defaultSearchField;
        //sortField = "";
        if (sortField.length() == 0) {
            return searchContent(keyWord, recordStart, recordEnd, columns, scFieldAry, siteid);
        }

        try
        {
            //定义搜索内容
            String[] fields = {"content"};
            //QueryParser queryParser = new QueryParser("maintitle", analyzer);
            org.apache.lucene.queryparser.classic.MultiFieldQueryParser queryParser = new org.apache.lucene.queryparser.classic.MultiFieldQueryParser(Version.LUCENE_45,fields, new IKAnalyzer());  //lucene 2.4
            queryParser.setPhraseSlop(1);
            List<String> words = splitWord(keyWord, true); // 显示拆分结果
            String fc_keyword = "";
            if (keyWord!=null) {
                if (keyWord.length() > 4){
                    for (int ii=0; ii<words.size()-1; ii++) {
                        fc_keyword = fc_keyword + words.get(ii) + " OR ";
                    }
                    fc_keyword = fc_keyword + words.get(words.size()-1);
                } else {     //用户提供的查询语句小于4，不对用户输入的信息分词
                    fc_keyword = keyWord;
                }
            }

            Query query1 = queryParser.parse(fc_keyword);
            //Query query2 = new TermQuery(new Term("siteid", String.valueOf(siteid)));
            Query query2 = NumericRangeQuery.newIntRange("siteid", 40, 40, true,true);// 没问题
            Query query3 = NumericRangeQuery.newIntRange("createdate", Integer.valueOf(startdate), Integer.valueOf(enddate), true, true);

            BooleanQuery query = new BooleanQuery();
            query.add(query1, BooleanClause.Occur.MUST);
            query.add(query2, BooleanClause.Occur.MUST);
            //query.add(query3, BooleanClause.Occur.MUST);

            return queryResult(recordStart, recordEnd, sortField, query,words);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public static Map searchContentByPeriod  (String startdate,String enddate,String keyWord, int recordStart, int recordEnd, String columns, String sortField, String[] scFieldAry, int siteid) {
        if (scFieldAry == null) scFieldAry = defaultSearchField;
        if (sortField.length() == 0) {
            return searchContent(keyWord, recordStart, recordEnd, columns, scFieldAry, siteid);
        }

        try
        {
            //定义搜索内容
            String[] fields = {"maintitle", "content","keyword","summary","createdate"};
            org.apache.lucene.queryparser.classic.MultiFieldQueryParser queryParser = new org.apache.lucene.queryparser.classic.MultiFieldQueryParser(Version.LUCENE_45,fields, new IKAnalyzer());  //lucene 2.4

            queryParser.setPhraseSlop(1);
            List<String> words = splitWord(keyWord, true); // 显示拆分结果
            String fc_keyword = "";
            if (keyWord!=null) {
                if (keyWord.length() > 4){
                    for (int ii=0; ii<words.size()-1; ii++) {
                        fc_keyword = fc_keyword + words.get(ii) + " OR ";
                    }
                    fc_keyword = fc_keyword + words.get(words.size()-1);
                } else {     //用户提供的查询语句小于4，不对用户输入的信息分词
                    fc_keyword = keyWord;
                }
            }

            Query query1 = queryParser.parse(fc_keyword);
            //Query query1 = new TermQuery(new Term("maintitle", keyWord));             //标题必须包含该完整的关键字
            Query query2 = NumericRangeQuery.newIntRange("siteid", 40, 40, true,true);// 没问题
            Query query3 = NumericRangeQuery.newIntRange("createdate", Integer.valueOf(startdate), Integer.valueOf(enddate), true, true);

            BooleanQuery query = new BooleanQuery();
            query.add(query1, BooleanClause.Occur.MUST);
            query.add(query2, BooleanClause.Occur.MUST);
            query.add(query3, BooleanClause.Occur.MUST);

            return queryResult(recordStart, recordEnd, sortField, query,words);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public static Map searchContent(String keyWord, int recordStart, int recordEnd, String columns, String[] scFieldAry, int siteid)
    {
        if (scFieldAry == null) scFieldAry = defaultSearchField;
        List searcheResult = new ArrayList();
        Map resultHash = new HashMap(2);

        MultiReader mReaders = null;
        try
        {
            IndexReader[] readers = SearchObject.getInstance().getSearcherReads();

            mReaders = new MultiReader(readers);
            IndexSearcher indexSearch = new IndexSearcher(mReaders);

            BooleanQuery query = new BooleanQuery();

            BooleanClause.Occur[] flags = new BooleanClause.Occur[scFieldAry.length];
            for (int i = 0; i < scFieldAry.length; i++) {
                flags[i] = BooleanClause.Occur.SHOULD;
            }
            Query query1 = MultiFieldQueryParser.parse(Version.LUCENE_45, QueryParser.escape(keyWord), scFieldAry, flags, SearchConfig.analyzer);
            //Query query1 = MultiFieldQueryParser.parse(Version.LUCENE_45, keyWord, scFieldAry, flags, SearchConfig.analyzer);
            //Query query2 = new TermQuery(new Term("siteid", String.valueOf(siteid)));
            Query query2 = NumericRangeQuery.newIntRange("siteid", 40, 40, true,true);// 没问题

            query.add(query1, BooleanClause.Occur.MUST);
            query.add(query2, BooleanClause.Occur.MUST);
            if ((columns != null) && (columns.length() > 0)) {
                Query columnQuery = new QueryParser(Version.LUCENE_45, "columnParents", SearchConfig.analyzer).parse(columns);
                query.add(columnQuery, BooleanClause.Occur.MUST);
            }

            TopScoreDocCollector topCollector = TopScoreDocCollector.create(10000, true);
            indexSearch.search(query, topCollector);

            TopDocs topDocs = topCollector.topDocs();

            Formatter formatter = new SimpleHTMLFormatter("<font color=\"red\">", "</font>");
            Scorer scorer = new QueryScorer(query);
            Highlighter highlighter = new Highlighter(formatter, scorer);
            highlighter.setTextFragmenter(new SimpleFragmenter(200));

            int resultCount = topDocs.totalHits;
            resultHash.put("resultCount", Integer.valueOf(resultCount));

            for (int i = recordStart; (i < resultCount) && (i < recordEnd); i++) {
                Document doc = indexSearch.doc(topDocs.scoreDocs[i].doc);
                Article article = transferDoc(doc, highlighter);
                searcheResult.add(article);
            }
            resultHash.put("searcheResult", searcheResult);
        }
        catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (mReaders != null)
                    mReaders.close();
            }
            catch (IOException e) {
                e.printStackTrace();
            }
        }
        return resultHash;
    }

    /*********************该函数完成按多字段，多检索词与的查询处理**********************************************/
    public static Map searchMoreKeyField(int recordStart, int recordEnd, String columns, Map fieldKey, int siteid, String sortField)
    {
        try
        {
            BooleanQuery query = new BooleanQuery();
            //Query query2 = new TermQuery(new Term("siteid", String.valueOf(siteid)));
            Query query2 = NumericRangeQuery.newIntRange("siteid", 40, 40, true,true);// 没问题
            query.add(query2, BooleanClause.Occur.MUST);
            if ((columns != null) && (columns.length() > 0)) {
                Query columnQuery = new QueryParser(Version.LUCENE_CURRENT, "columnParents", SearchConfig.analyzer).parse(columns);
                query.add(columnQuery, BooleanClause.Occur.MUST);
            }
            Iterator iterator = fieldKey.keySet().iterator();
            while (iterator.hasNext()) {
                Object field = iterator.next();
                Object searchWord = fieldKey.get(field);
                Query tmp = new QueryParser(Version.LUCENE_CURRENT, (String)field, SearchConfig.analyzer).parse((String)searchWord);
                query.add(tmp, BooleanClause.Occur.MUST);
            }
            return queryResult(recordStart, recordEnd, "publishtime", query);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public static Map searchMoreKeyField(int recordStart, int recordEnd,String columns,Map fieldKey){
        int siteid = SearchConfig.getInstance().getSiteidConfig();
        try{
            BooleanQuery query = new BooleanQuery();
            //Query query2 = new TermQuery(new Term("siteid", String.valueOf(siteid)));
            Query query2 = NumericRangeQuery.newIntRange("siteid", 40, 40, true,true);// 没问题
            query.add(query2,BooleanClause.Occur.MUST);
            if (columns!=null && columns.length()>0){
                Query columnQuery = new QueryParser(Version.LUCENE_CURRENT, "columnParents",SearchConfig.analyzer).parse(columns);
                query.add(columnQuery,BooleanClause.Occur.MUST);
            }
            Iterator iterator = fieldKey.keySet().iterator();
            while (iterator.hasNext()) {
                Object field = iterator.next();
                Object searchWord =   fieldKey.get(field);
                Query tmp = new QueryParser(Version.LUCENE_CURRENT, (String)field,SearchConfig.analyzer).parse((String)searchWord);
                query.add(tmp,BooleanClause.Occur.MUST);
            }
            return queryResult(recordStart,recordEnd,"publishtime",query) ;
        }catch (Exception e){
            e.printStackTrace();
        }
        return null;
    }
    /*******************************************************************/

    public static Map searchContent(String keyWord,int recordStart, int recordEnd,String columns,String sortField,String[] scFieldAry){
        if (scFieldAry ==null) scFieldAry = defaultSearchField;
        if (sortField.length() ==0){
            return searchContent( keyWord,recordStart,  recordEnd, columns,scFieldAry)   ;
        }
        int siteid = SearchConfig.getInstance().getSiteidConfig();
        try{
            //下面主要根据或的关系查询"maintitle","summary","keyword","content" 四个字段是否包含要查询的关键字
            BooleanClause.Occur[] flags = new BooleanClause.Occur[scFieldAry.length];
            for(int i = 0;i<scFieldAry.length;i++){
                flags[i] = BooleanClause.Occur.SHOULD;
            }
            Query query1 = MultiFieldQueryParser.parse(Version.LUCENE_CURRENT, QueryParser.escape(keyWord), scFieldAry, flags, SearchConfig.analyzer);
            //Query query2 = new TermQuery(new Term("siteid", String.valueOf(siteid)));
            Query query2 = NumericRangeQuery.newIntRange("siteid", 40, 40, true,true);// 没问题
            //必须满足该查询条件
            BooleanQuery query = new BooleanQuery();
            query.add(query1, BooleanClause.Occur.MUST);
            query.add(query2,BooleanClause.Occur.MUST);
            if (columns!=null &&  columns.length()>0){
                Query columnQuery = new QueryParser(Version.LUCENE_CURRENT, "columnParents",SearchConfig.analyzer).parse(columns);
                query.add(columnQuery,BooleanClause.Occur.MUST);
            }
            return queryResult(recordStart,recordEnd,sortField,query) ;
        }catch(Exception e){
            e.printStackTrace();
        }
        return null;
    }

    public static Map searchContentDate(String keyWord, int recordStart, int recordEnd, String columns, String sortField, String[] scFieldAry, int siteid, String startdate, String enddate) {
        if (scFieldAry == null) scFieldAry = defaultSearchField;
        if (sortField.length() == 0) {
            return searchContent(keyWord, recordStart, recordEnd, columns, scFieldAry, siteid);
        }

        try
        {
            BooleanClause.Occur[] flags = new BooleanClause.Occur[scFieldAry.length];
            for (int i = 0; i < scFieldAry.length; i++) {
                flags[i] = BooleanClause.Occur.SHOULD;
            }

            Query query1 = MultiFieldQueryParser.parse(Version.LUCENE_CURRENT, QueryParser.escape(keyWord), scFieldAry, flags, SearchConfig.analyzer);
            //Query query2 = new TermQuery(new Term("siteid", String.valueOf(siteid)));
            Query query2 = NumericRangeQuery.newIntRange("siteid", 40, 40, true,true);// 没问题
            Query query3 = NumericRangeQuery.newIntRange("searchdate", Integer.valueOf(startdate), Integer.valueOf(enddate), true, true);

            BooleanQuery query = new BooleanQuery();
            query.add(query1, BooleanClause.Occur.MUST);
            query.add(query2, BooleanClause.Occur.MUST);
            query.add(query3, BooleanClause.Occur.MUST);

            if ((columns != null) && (columns.length() > 0)) {
                Query columnQuery = new QueryParser(Version.LUCENE_CURRENT, "columnParents", SearchConfig.analyzer).parse(columns);
                query.add(columnQuery, BooleanClause.Occur.MUST);
            }
            return queryResult(recordStart, recordEnd, sortField, query);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public static Map searchByField(String keyWord, int recordStart, int recordEnd, String columns, String sortField, String scField, int siteid) {
        if (sortField.length() == 0) {
            sortField = "publishtime";
        }
        try
        {
            BooleanQuery query = new BooleanQuery();

            Query query1 = new TermQuery(new Term(scField, QueryParser.escape(keyWord)));
            //Query query2 = new TermQuery(new Term("siteid", String.valueOf(siteid)));
            Query query2 = NumericRangeQuery.newIntRange("siteid", 40, 40, true,true);// 没问题

            query.add(query1, BooleanClause.Occur.MUST);
            query.add(query2, BooleanClause.Occur.MUST);
            if ((columns != null) && (columns.length() > 0)) {
                Query columnQuery = new QueryParser(Version.LUCENE_CURRENT, "columnParents", SearchConfig.analyzer).parse(columns);
                query.add(columnQuery, BooleanClause.Occur.MUST);
            }
            return queryResult(recordStart, recordEnd, sortField, query);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public static Map searchByField(String keyWord,int recordStart, int recordEnd,String columns,String sortField,String scField){
        if (sortField.length() ==0){
            sortField ="publishtime"   ;
        }
        int siteid = SearchConfig.getInstance().getSiteidConfig();
        try{
            BooleanQuery query = new BooleanQuery();
            //精确查询，TermQuery 里面内容必须完全匹配才能查询到结果
            //IndexSearcher indexSearch = SearchObject.getInstance().getSearcher("search");
            Query query1 = new TermQuery(new Term(scField,QueryParser.escape(keyWord)));
            //Query query2 = new TermQuery(new Term("siteid", String.valueOf(siteid)));
            Query query2 = NumericRangeQuery.newIntRange("siteid", 40, 40, true,true);// 没问题
            //必须满足该查询条件
            query.add(query1, BooleanClause.Occur.MUST);
            query.add(query2,BooleanClause.Occur.MUST);
            if (columns!=null &&  columns.length()>0){
                Query columnQuery = new QueryParser(Version.LUCENE_CURRENT, "columnParents",SearchConfig.analyzer).parse(columns);
                query.add(columnQuery,BooleanClause.Occur.MUST);
            }
            return queryResult(recordStart,recordEnd,sortField,query) ;
        }catch(Exception e){
            e.printStackTrace();
        }
        return  null;
    }
    //如果不传入columns默认是全站查找，不限制栏目
    //当查询限制栏目时，多个栏目可以逗号分隔
    //该检索主要是按相关度排序的结果，用户不干预检索结果
    public static Map searchContent(String keyWord,int recordStart, int recordEnd,String columns,String[] scFieldAry){
        if (scFieldAry ==null) scFieldAry = defaultSearchField;
        List<Article> searcheResult =  new ArrayList<Article>();
        Map resultHash = new HashMap<String, Object>(2);
        int siteid = SearchConfig.getInstance().getSiteidConfig();
        MultiReader mReaders =null;
        try{
            //取得查询对象
            IndexReader[] readers =  SearchObject.getInstance().getSearcherReads();
            //多域查询
            mReaders = new MultiReader(readers);
            IndexSearcher indexSearch = new  IndexSearcher(mReaders);
            //创建boolean查询
            //下面主要根据或的关系查询"maintitle","summary","keyword","content" 四个字段是否包含要查询的关键字
            BooleanQuery query = new BooleanQuery();

            BooleanClause.Occur[] flags = new BooleanClause.Occur[scFieldAry.length];
            for(int i = 0;i<scFieldAry.length;i++){
                flags[i] = BooleanClause.Occur.SHOULD;
            }
            Query query1 = MultiFieldQueryParser.parse(Version.LUCENE_CURRENT, QueryParser.escape(keyWord), scFieldAry, flags, SearchConfig.analyzer);
            //Query query2 = new TermQuery(new Term("siteid", String.valueOf(siteid)));
            Query query2 = NumericRangeQuery.newIntRange("siteid", 40, 40, true,true);// 没问题
            //必须满足该查询条件
            query.add(query1, BooleanClause.Occur.MUST);
            query.add(query2,BooleanClause.Occur.MUST);
            if (columns!=null && columns.length()>0){
                Query columnQuery = new QueryParser(Version.LUCENE_CURRENT, "columnParents",SearchConfig.analyzer).parse(columns);
                query.add(columnQuery,BooleanClause.Occur.MUST);
            }
            //10000为最多查询条数
            TopScoreDocCollector topCollector = TopScoreDocCollector.create(10000,true);
            indexSearch.search(query, topCollector);
            //取得查询结果
            TopDocs topDocs = topCollector.topDocs();
            /******************************/
            //关键字高亮显示
            Formatter formatter =  new SimpleHTMLFormatter("<font color=\"red\">", "</font>");   //前缀和后缀
            Scorer scorer = new QueryScorer(query);
            Highlighter highlighter = new Highlighter(formatter, scorer);
            highlighter.setTextFragmenter(new SimpleFragmenter(200)); //字长度
            // //高亮结束
            /****************************/
            int resultCount=topDocs.totalHits;
            resultHash.put("resultCount", resultCount);
            Document doc;
            Article article;
            for(int i=recordStart;i<resultCount && i<recordEnd;i++){
                doc = indexSearch.doc(topDocs.scoreDocs[i].doc);
                article = transferDoc(doc, highlighter);
                searcheResult.add(article);
            }
            resultHash.put("searcheResult", searcheResult);
            // System.out.println("查询结果条数："+resultCount);
        }catch(Exception e){
            e.printStackTrace();
        } finally {
            try {
                if(mReaders !=null)   {
                    mReaders.close();
                }
            } catch (IOException e) {
                e.printStackTrace();  //To change body of catch statement use File | Settings | File Templates.
            }
        }
        return   resultHash;
    }

    /**
     * 查看IKAnalyzer 分词器是如何将一个完整的词组进行分词的
     *
     * @param text
     * @param isMaxWordLength
     */
    public static List<String> splitWord(String text, boolean isMaxWordLength) {
        List<String> keywords = null;
        try {
            /* 创建分词对象 */
            // 遍历分词数据
            System.out.print("IKAnalyzer把关键字拆分的结果是：");
            keywords = new ArrayList<String>();
            Configuration configuration = DefaultConfig.getInstance();
            configuration.setUseSmart(true);
            StringReader reader = new StringReader(text);
            IKSegmenter ik = new IKSegmenter(reader, configuration);
            Lexeme lexeme = null;
            while ((lexeme = ik.next()) != null) {
                keywords.add(lexeme.getLexemeText());
                System.out.print("【" + lexeme.getLexemeText() + "】");
            }
            System.out.println("\r\n");
            reader.close();
        } catch (IOException e) {
            e.printStackTrace();
        }

        return keywords;
    }

    public static Map searchContent(String keyWord, int recordStart, int recordEnd, String columns, String sortField, String[] scFieldAry, int siteid)
    {
        if (scFieldAry == null) scFieldAry = defaultSearchField;
        //sortField = "";
        if (sortField.length() == 0) {
            return searchContent(keyWord, recordStart, recordEnd, columns, scFieldAry, siteid);
        }

        try
        {
            //定义搜索内容
            String[] fields = {"maintitle", "content","keyword","summary"};
            //QueryParser queryParser = new QueryParser("maintitle", analyzer);
            org.apache.lucene.queryparser.classic.MultiFieldQueryParser queryParser = new org.apache.lucene.queryparser.classic.MultiFieldQueryParser(Version.LUCENE_45,fields, new IKAnalyzer());  //lucene 2.4
            queryParser.setPhraseSlop(1);
            List<String> words = splitWord(keyWord, true); // 显示拆分结果
            String fc_keyword = "";
            if (keyWord!=null) {
                if (keyWord.length() > 4){
                    for (int ii=0; ii<words.size()-1; ii++) {
                        fc_keyword = fc_keyword + words.get(ii) + " OR ";
                    }
                    fc_keyword = fc_keyword + words.get(words.size()-1);
                } else {     //用户提供的查询语句小于4，不对用户输入的信息分词
                    fc_keyword = keyWord;
                }
            }

            Query query1 = queryParser.parse(fc_keyword);
            //Query query2 = new TermQuery(new Term("siteid", String.valueOf(siteid)));
            Query query2 = NumericRangeQuery.newIntRange("siteid", 40, 40, true,true);// 没问题

            BooleanQuery query = new BooleanQuery();
            query.add(query1, BooleanClause.Occur.MUST);
            query.add(query2, BooleanClause.Occur.MUST);

            return queryResult(recordStart, recordEnd, sortField, query,words);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    private static Map queryResult(int recordStart, int recordEnd, String sortField, Query query,List<String> words){
        List<Article> searcheResult =  new ArrayList<Article>();
        Map<String,Object> resultHash = new HashMap<String, Object>(2);
        IndexSearcher indexSearch = null;

        //排序尝试
        Sort sort = new Sort();
        SortField sf = new SortField(sortField,SortField.Type.INT,true);
        sort.setSort(sf);
        //排序结束

        try {
            String INDEX_PATH = SearchConfig.getInstance().getIndexpathConfig();
            File indexFile = new File(INDEX_PATH);
            IndexReader indexReader = IndexReader.open(FSDirectory.open(indexFile));
            indexSearch = new IndexSearcher(indexReader);

            //indexSearch = SearchObject.getInstance().getSearcher("search");
            if (indexSearch ==null) return null;

            //10000为最多查询条数//取得查询结果
            //TopFieldDocs docs=indexSearch.search(query,null, 10000, sort);     //按照指定的排序字段进行排序
            TopDocs docs = indexSearch.search(query,null, 10000);               //按照文章与查询关键字的相关性进行排序
            ScoreDoc[] scoreDocs=docs.scoreDocs;
            /**************关键字高亮显示****************/
            Formatter formatter =  new SimpleHTMLFormatter("<font color=\"red\">", "</font>");   //前缀和后缀
            Scorer scorer = new QueryScorer(query);
            Highlighter highlighter = new Highlighter(formatter, scorer);
            highlighter.setTextFragmenter(new SimpleFragmenter(200)); //字长度
            // //高亮结束
            /****************************/
            int resultCount=scoreDocs.length;
            resultHash.put("resultCount", resultCount);
            Document doc;
            Article article;
            int docId;
            for(int i=recordStart;i<resultCount && i<recordEnd;i++){
                //找到这个document原来的索引值
                docId=scoreDocs[i].doc;
                //根据这个值找到对象的document
                doc=indexSearch.doc(docId);
                article = transferDoc(doc, highlighter,words);
                searcheResult.add(article);
            }
            resultHash.put("searcheResult", searcheResult);
        }catch(Exception e){
            e.printStackTrace();
        }

        indexSearch=null;

        return  resultHash;
    }

    private static Article transferDoc(Document doc,Highlighter highlighter,List<String> words) {
        Analyzer analyzer = new IKAnalyzer();
        Article article = new Article();
        try
        {
            article.setSiteID(Integer.parseInt(doc.get("siteid")));
            article.setID(Integer.parseInt(doc.get("id")));
            String tmp= doc.get("maintitle");

            if (tmp !=null)  {
                for (int ii=0;ii<words.size();ii++) {
                    tmp = CommUtil.replace(tmp, words.get(ii), "<font color=\"red\">" + words.get(ii) + "</font>");
                }
            }
            if(tmp!=null){
                article.setMainTitle(tmp);
            }else{
                article.setMainTitle(doc.get("maintitle"));
            }

            article.setViceTitle(doc.get("vicetitle"));

            tmp =   doc.get("summary");
            if (tmp !=null)  {
                for (int ii=0;ii<words.size();ii++) {
                    tmp = CommUtil.replace(tmp,words.get(ii),"<font color=\"red\">"+words.get(ii) + "</font>");
                }
            }
            if (tmp !=null)  {
                article.setSummary(tmp);
            }else{
                article.setSummary(doc.get("summary"));
            }

            tmp =   doc.get("keyword");
            if (tmp !=null){
                for (int ii=0;ii<words.size();ii++) {
                    tmp = CommUtil.replace(tmp,words.get(ii),"<font color=\"red\">"+words.get(ii) + "</font>");
                }
            }
            if (tmp !=null){
                article.setKeyword(tmp);
            }else{
                article.setKeyword(doc.get("keyword"));
            }

            article.setAuthor(doc.get("author"));
            article.setColumnID(Integer.parseInt(doc.get("columnid")));
            article.setSortID(Integer.parseInt(doc.get("sortid")));
            article.setDirName(doc.get("dirname"));
            article.setFileName(doc.get("filename"));
            article.setPublishTime(CommUtil.string2timestamp(doc.get("publishtime"), "yyyyMMdd"));
            article.setCreateDate(CommUtil.string2timestamp(doc.get("createdate"),"yyyyMMdd" ));
            // article.setColumnParents(doc.get("columnParents"));
        } catch (Exception e) {
            e.printStackTrace();
        }
        return article;
    }

    private static Map queryResult(int recordStart, int recordEnd, String sortField, Query query){
        List<Article> searcheResult =  new ArrayList<Article>();
        Map<String,Object> resultHash = new HashMap<String, Object>(2);
        IndexSearcher indexSearch = null;

        //排序尝试
        Sort sort = new Sort();
        SortField sf = new SortField(sortField,SortField.Type.STRING,true);
        sort .setSort(sf);
        //排序结束

        try {
            String INDEX_PATH = SearchConfig.getInstance().getIndexpathConfig();
            File indexFile = new File(INDEX_PATH);
            IndexReader indexReader = IndexReader.open(FSDirectory.open(indexFile));
            indexSearch = new IndexSearcher(indexReader);

            //IndexSearcher indexSearch = SearchObject.getInstance().getSearcher("search");
            if (indexSearch ==null) return null;

            //10000为最多查询条数//取得查询结果
            System.out.println(query.toString());
            //TopFieldDocs docs=indexSearch.search(query,null, 10000, sort);
            TopDocs docs = indexSearch.search(query,null, 10000);
            ScoreDoc[] scoreDocs=docs.scoreDocs;
            /**************关键字高亮显示****************/
            Formatter formatter =  new SimpleHTMLFormatter("<font color=\"red\">", "</font>");   //前缀和后缀
            Scorer scorer = new QueryScorer(query);
            Highlighter highlighter = new Highlighter(formatter, scorer);
            highlighter.setTextFragmenter(new SimpleFragmenter(200)); //字长度
            // //高亮结束
            /****************************/
            int resultCount=scoreDocs.length;
            resultHash.put("resultCount", resultCount);
            Document doc;
            Article article;
            int docId;
            for(int i=recordStart;i<resultCount && i<recordEnd;i++){
                //找到这个document原来的索引值
                docId=scoreDocs[i].doc;
                //根据这个值找到对象的document
                doc=indexSearch.doc(docId);
                article = transferDoc(doc, highlighter);
                searcheResult.add(article);
            }
            resultHash.put("searcheResult", searcheResult);
        }catch(Exception e){
            e.printStackTrace();
        }

        //finally {
        //     if (indexSearch !=null)
        //         SearchObject.getInstance().getLuceneContext("search").releaseSearcher(indexSearch);
        // }
        indexSearch=null;
        return  resultHash;
    }

    private static Article transferDoc(Document doc,Highlighter highlighter) {
        Analyzer analyzer = new IKAnalyzer();
        Article article = new Article();
        try
        {
            article.setSiteID(Integer.parseInt(doc.get("siteid")));
            article.setID(Integer.parseInt(doc.get("id")));
            String tmp= doc.get("maintitle");

            if (tmp !=null)  {
                TokenStream tokenStream = analyzer.tokenStream("",new StringReader(tmp));
                tmp = highlighter.getBestFragment(tokenStream, tmp);
            }
            if(tmp!=null){
                article.setMainTitle(tmp);
            }else{
                article.setMainTitle(doc.get("maintitle"));
            }
            article.setViceTitle(doc.get("vicetitle"));

            tmp =   doc.get("summary");
            //if (tmp !=null)  {
            //    tmp = highlighter.getBestFragment(analyzer, "summary", tmp);
            //}
            //if (tmp !=null)  {
            article.setSummary(tmp);
            //}else{
            //    article.setSummary(doc.get("summary"));
            //}

            //tmp =   doc.get("keyword");
            //if (tmp !=null){
            //    tmp = highlighter.getBestFragment(analyzer, "keyword", doc.get("keyword"));
            //}
            //if (tmp !=null){
            article.setKeyword(tmp);
            //}else{
            //    article.setKeyword(doc.get("keyword"));
            //}

            article.setAuthor(doc.get("author"));
            article.setColumnID(Integer.parseInt(doc.get("columnid")));
            article.setSortID(Integer.parseInt(doc.get("sortid")));
            article.setDirName(doc.get("dirname"));
            article.setFileName(doc.get("filename"));
            article.setPublishTime(CommUtil.string2timestamp(doc.get("publishtime"), "yyyyMMdd"));
            article.setCreateDate(CommUtil.string2timestamp(doc.get("createdate"),"yyyyMMdd" ));
            // article.setColumnParents(doc.get("columnParents"));
        } catch (Exception e) {
            e.printStackTrace();
        }
        return article;
    }
}


