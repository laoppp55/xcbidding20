package com.bizwink.util;

import java.io.File;
import java.io.IOException;
import org.apache.lucene.search.IndexSearcher;
import org.apache.lucene.search.SearcherFactory;
import org.apache.lucene.search.SearcherManager;
import org.apache.lucene.store.Directory;
import org.apache.lucene.store.FSDirectory;
import org.apache.lucene.util.Version;

public class SearchEngineCore {
    private  SearcherManager sm;
    private  Directory directory;
    public SearchEngineCore(){}
    /**
     * 加载索引配置
     * @param index
     *@author JLC
     */
    public SearchEngineCore(final String index) throws IOException{
            //索引文件路径
           // SearchConfig sc = new SearchConfig();
            String INDEX_PATH = SearchConfig.getInstance().getIndexpathConfig();
            //创建索引目录
            directory = FSDirectory.open(new File(INDEX_PATH));
            SearcherFactory searcherFactory = new SearcherFactory();
            sm =new SearcherManager(directory, searcherFactory);
    }
    /**
     *  Function:取得索引对象
     *  @author JLC
     *  @return
     */
    public IndexSearcher getSearcher() {
        try{
            return sm.acquire();
        }catch(Exception e){

        }
        return null;
    }

    public void releaseSearcher(IndexSearcher searcher) {
        try {
            sm.release(searcher);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }



    public Version getVersion() {
        return Version.LUCENE_CURRENT;
    }


    public Directory getDirectory() {
        return directory;
    }
    /**
     * 刷新数据
     */
    public void refreshData(){
        try{
            sm.maybeRefresh();
        }catch (Exception e){
            e.printStackTrace();
        }
    }


}