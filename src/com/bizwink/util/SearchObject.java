package com.bizwink.util;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import org.apache.lucene.index.IndexReader;
import org.apache.lucene.search.IndexSearcher;


public  class SearchObject {

    private static Map<String,SearchEngineCore> luceneContextMap =null;
    private static IndexSearcher[] searchers =null;
    private static IndexReader[] readers =null;
    private static SearchObject instance;
    /**
     * 初始化对象
     * @return
     */
    public static SearchObject getInstance(){
        if(instance==null){
            //try {
                //init();
                instance = new SearchObject();
            //}catch (IOException e){
            //    instance =null;
            //    e.printStackTrace();
            //}
        }
        return instance;
    }
    /**
     *  Function:创建Lucene索引对象
     *  @author JLC
     */
    public static void init() throws IOException{
            //后面可能会出现多个索引配置  先写成公共的方便拓展
            luceneContextMap = new HashMap<String, SearchEngineCore>();
            searchers = new   IndexSearcher[1];
            readers = new IndexReader[1];
            int i=0;
            luceneContextMap.put("search",new SearchEngineCore("search"));
            searchers[0]=luceneContextMap.get("search").getSearcher();
            readers[0] = searchers[0].getIndexReader();
    }
    /**
     *  Function:取得所有查询对象
     *  @author JLC
     *  @return 返回所有查询对象
     */
    public  IndexSearcher[] getSearchers(){
        int i=0;
        if(searchers!=null&&searchers.length>0&&luceneContextMap!=null&&luceneContextMap.size()>0){
            searchers[i++]=luceneContextMap.get("search").getSearcher();
        }else{
            try {
                init();
            }catch (IOException e){
                instance =null;
            e.printStackTrace();
        }
        }
        return searchers;
    }

    /**
     *  Function:取得所有查询对象Reader
     *  @author JLC
     *  @return
     */
    public  IndexReader[] getSearcherReads(){
        int i=0;
        if(searchers!=null&&searchers.length>0&&luceneContextMap!=null&&luceneContextMap.size()>0){
            readers[i++]=luceneContextMap.get("search").getSearcher().getIndexReader();
        }
        return readers;
    }

    /**
     *  Function:取得制定查询对象
     *  @author JLC
     *  @return
     */
    public  IndexSearcher getSearcher(String index){
        return luceneContextMap.get(index).getSearcher();
    }



    public  SearchEngineCore getLuceneContext(String index){
        return luceneContextMap.get(index);
    }
}