package com.bizwink.indexer;

import org.apache.lucene.document.*;
import com.bizwink.po.Article;
import com.bizwink.util.StringUtil;

public class DBDocument {
    //文档
    public static Document Document(int siteid,String sitename,String dbtype,String classid,Article article,String dirname,String createdate){
        int articleid=0;
        int sortid = 0;
        String maintitle = null;
        String keyword = null;
        String summary = null;
        String content = null;
        String articlepic = "";
        float saleprice = 0.00f;            	            //电子商务使用  商品售价
        float inprice = 0.00f;                            	//电子商务使用  商品进价
        float marketprice = 0.00f;          	            //电子商务使用  商品市场价
        float vipprice = 0.00f;          	                //电子商务使用  商品VIP价
        int   stocknum = 0;             	                //电子商务使用  商品库存量
        String brand = "";                	            //电子商务使用  商品品牌
        String pic = "";                  	            //电子商务使用  商品小图片
        String bigpic = "";               	            //电子商务使用  商品大图片
        String lastupdate = null;
        String publishtime = null;
        String filename = null;

        articleid = article.getID().intValue();
        if (dbtype.equalsIgnoreCase("mssql")) {
            content = StringUtil.gb2iso4View(article.getCONTENT());
            maintitle = StringUtil.gb2iso4View(article.getMAINTITLE());
            summary = StringUtil.gb2iso4View(article.getSUMMARY());
            keyword = StringUtil.gb2iso4View(article.getKEYWORD());
        } else if(dbtype.equalsIgnoreCase("mysql")) {
            content = article.getCONTENT();
            maintitle = article.getMAINTITLE();
            summary = article.getSUMMARY();
            keyword = article.getKEYWORD();
        } else {
            content = article.getCONTENT();
            maintitle = article.getMAINTITLE();
            summary = article.getSUMMARY();
            keyword = article.getKEYWORD();
        }
        articlepic = article.getARTICLEPIC();
        if (articlepic == null) articlepic = "";
        saleprice = article.getSALEPRICE().floatValue();
        inprice = article.getINPRICE().floatValue();
        marketprice = article.getMARKETPRICE().floatValue();
        vipprice = article.getVIPPRICE().floatValue();
        stocknum = article.getSTOCKNUM().byteValue();
        brand = article.getBRAND();
        if (brand == null) brand = "";
        dirname = article.getDIRNAME();
        lastupdate = article.getLASTUPDATED().toString();
        publishtime = article.getPUBLISHTIME().toString();
        filename = article.getFILENAME();

        Document doc = new Document();
        try {
            doc.add(new Field("id", String.valueOf(articleid), Field.Store.YES, Field.Index.NOT_ANALYZED));
            doc.add(new Field("siteid", String.valueOf(siteid), Field.Store.YES, Field.Index.NOT_ANALYZED));
            doc.add(new Field("classid", classid, Field.Store.YES, Field.Index.NOT_ANALYZED));
            doc.add(new Field("sortid", String.valueOf(sortid), Field.Store.YES, Field.Index.NOT_ANALYZED));
            doc.add(new Field("saleprice", String.valueOf(saleprice), Field.Store.YES, Field.Index.NOT_ANALYZED));
            doc.add(new Field("inprice", String.valueOf(inprice), Field.Store.YES, Field.Index.NOT_ANALYZED));
            doc.add(new Field("marketprice", String.valueOf(marketprice), Field.Store.YES, Field.Index.NOT_ANALYZED));
            doc.add(new Field("vipprice", String.valueOf(vipprice), Field.Store.YES, Field.Index.NOT_ANALYZED));
            doc.add(new Field("stocknum", String.valueOf(stocknum), Field.Store.YES, Field.Index.NOT_ANALYZED));
            doc.add(new Field("brand", brand, Field.Store.YES, Field.Index.NOT_ANALYZED));
            doc.add(new Field("pic", pic, Field.Store.YES, Field.Index.NOT_ANALYZED));
            doc.add(new Field("bigpic", bigpic, Field.Store.YES, Field.Index.NOT_ANALYZED));
            doc.add(new Field("columnid", String.valueOf(article.getCOLUMNID()), Field.Store.YES, Field.Index.NOT_ANALYZED));
            doc.add(new Field("articlepic", articlepic, Field.Store.YES, Field.Index.NOT_ANALYZED));
            doc.add(new Field("createdate", createdate, Field.Store.YES, Field.Index.NOT_ANALYZED));
        }catch(Exception e){
            e.printStackTrace();
        }

        if (sitename != null) {
            try {
                doc.add(new Field("sitename", sitename, Field.Store.YES, Field.Index.NOT_ANALYZED));
            } catch(Exception e) {
                e.printStackTrace();
            }
        }

        if(maintitle != null){
            try{
                doc.add(new Field("maintitle", maintitle, Field.Store.YES, Field.Index.ANALYZED));
            }catch(Exception e){
                e.printStackTrace();
            }
        }

        if(summary != null){
            //System.out.println("have summary=" + summary);
            try{
                doc.add(new Field("summary", summary, Field.Store.YES, Field.Index.ANALYZED));
            }catch(Exception e){
                e.printStackTrace();
            }
        } else {
            summary = StringUtil.getContentFromHTML(content);
            summary = summary.trim();
            //content = StringUtil.getContentFromHTML(content,"<style ","</style>");
            //summary = StringUtil.getContentFromHTML(content,"<",">");
            //System.out.println(summary.length());
            if (summary.length() > 50) summary = summary.substring(0,50);
            try{
                doc.add(new Field("summary", summary, Field.Store.YES, Field.Index.ANALYZED));
            }catch(Exception e){
                e.printStackTrace();
            }
        }

        if(keyword != null){
            try{
                doc.add(new Field("keyword", keyword, Field.Store.YES, Field.Index.ANALYZED));
            }catch(Exception e){
                e.printStackTrace();
            }
        }

        if(content != null){
            try{
                doc.add(new Field("content", content, Field.Store.NO, Field.Index.ANALYZED));
            }catch(Exception e){
                e.printStackTrace();
            }
        }

        try{
            doc.add(new Field("lastupdated", article.getLASTUPDATED().toString(), Field.Store.YES, Field.Index.NOT_ANALYZED));
            doc.add(new Field("publishtime", String.valueOf(publishtime), Field.Store.YES, Field.Index.NOT_ANALYZED));

            if (filename != null)
                doc.add(new Field("filename", filename, Field.Store.YES, Field.Index.NOT_ANALYZED));
            doc.add(new Field("dirname", dirname, Field.Store.YES, Field.Index.NOT_ANALYZED));
        }catch(Exception e){
            e.printStackTrace();
        }

        return doc;
    }

    public static Document Document(int siteid,String articlePathinfo,String columnChineseName,com.bizwink.po.Article article){
        int articleid=0;
        int sortid = 0;
        String maintitle = null;
        String keyword = null;
        String summary = null;
        String content = null;
        String articlepic = "";
        float saleprice = 0.00f;            	            //电子商务使用  商品售价
        float inprice = 0.00f;                            	//电子商务使用  商品进价
        float marketprice = 0.00f;          	            //电子商务使用  商品市场价
        float vipprice = 0.00f;          	                //电子商务使用  商品VIP价
        int   stocknum = 0;             	                //电子商务使用  商品库存量
        String brand = "";                	            //电子商务使用  商品品牌
        String pic = "";                  	            //电子商务使用  商品小图片
        String bigpic = "";               	            //电子商务使用  商品大图片
        String publishtime = null;
        String filename = null;

        articleid = article.getID().intValue();
        content = article.getCONTENT();
        maintitle = article.getMAINTITLE();
        summary = article.getSUMMARY();
        keyword = article.getKEYWORD();
        articlepic = article.getARTICLEPIC();
        if (articlepic == null) articlepic = "";
        brand = article.getBRAND();
        if (brand == null) brand = "";
        if (bigpic == null) bigpic = "";
        String dirname = article.getDIRNAME();
        filename = article.getFILENAME();

        Document doc = new Document();
        try {
            doc.add(new IntField("id", articleid, IntField.Store.YES));
            doc.add(new IntField("siteid", siteid, IntField.Store.YES));
            doc.add(new StringField("classid", articlePathinfo, StringField.Store.YES));
            doc.add(new IntField("sortid", sortid, IntField.Store.YES));
            doc.add(new FloatField("saleprice", saleprice, FloatField.Store.YES));
            doc.add(new FloatField("inprice", inprice, FloatField.Store.YES));
            doc.add(new FloatField("marketprice", marketprice, FloatField.Store.YES));
            doc.add(new FloatField("vipprice", vipprice, FloatField.Store.YES));
            doc.add(new IntField("stocknum", stocknum, IntField.Store.YES));
            doc.add(new StringField("brand", brand, StringField.Store.YES));
            doc.add(new StringField("pic", pic, StringField.Store.YES));
            doc.add(new StringField("bigpic", bigpic, StringField.Store.YES));
            doc.add(new IntField("columnid", article.getCOLUMNID().intValue(), Field.Store.YES));
            doc.add(new StringField("articlepic", articlepic, Field.Store.YES));
            doc.add(new StringField("colname", columnChineseName, Field.Store.YES));
            IntField createDateField = new IntField("createdate", Integer.parseInt(DateTools.dateToString(article.getCREATEDATE(), DateTools.Resolution.DAY)),Field.Store.YES);
            doc.add(createDateField);
            IntField pubDateField = new IntField("publishtime", Integer.parseInt(DateTools.dateToString(article.getPUBLISHTIME(), DateTools.Resolution.DAY)),Field.Store.YES);
            doc.add(pubDateField);
            System.out.println("createdate==="  + DateTools.dateToString(article.getCREATEDATE(),DateTools.Resolution.DAY));
        }catch(Exception e){
            e.printStackTrace();
        }

        if(maintitle != null){
            try{
                doc.add(new TextField("maintitle", maintitle, TextField.Store.YES));
            }catch(Exception e){
                e.printStackTrace();
            }
        }

        if(summary != null){
            //System.out.println("have summary=" + summary);
            try{
                doc.add(new TextField("summary", summary, TextField.Store.YES));
            }catch(Exception e){
                e.printStackTrace();
            }
        } else {
            summary = com.bizwink.util.CommUtil.getContentFromHTML(content);
            summary = summary.trim();
            //content = StringUtil.getContentFromHTML(content,"<style ","</style>");
            //summary = StringUtil.getContentFromHTML(content,"<",">");
            //System.out.println(summary.length());
            if (summary.length() > 50) summary = summary.substring(0,50);
            try{
                doc.add(new TextField("summary", summary, TextField.Store.YES));
            }catch(Exception e){
                e.printStackTrace();
            }
        }

        if(keyword != null){
            try{
                doc.add(new TextField("keyword", keyword, TextField.Store.YES));
            }catch(Exception e){
                e.printStackTrace();
            }
        }

        if(content != null){
            try{
                doc.add(new TextField("content", content, TextField.Store.NO));
            }catch(Exception e){
                e.printStackTrace();
            }
        }

        try{
            if (filename != null)
                doc.add(new StringField("filename", filename, StringField.Store.YES));
            doc.add(new StringField("dirname", dirname, StringField.Store.YES));
        }catch(Exception e){
            e.printStackTrace();
        }

        return doc;
    }

    public static Document Document(Article article){
        Document doc = new Document();

        doc.add(new Field("id", String.valueOf(article.getID()), Field.Store.YES, Field.Index.NOT_ANALYZED));
        doc.add(new Field("siteid", String.valueOf(article.getSITEID()), Field.Store.YES, Field.Index.NOT_ANALYZED));
        doc.add(new Field("sortid", String.valueOf(article.getSORTID()), Field.Store.YES, Field.Index.NOT_ANALYZED));
        doc.add(new Field("columnid", String.valueOf(article.getCOLUMNID()), Field.Store.YES, Field.Index.NOT_ANALYZED));

        if(article.getMAINTITLE() != null){
            try{
                doc.add(new Field("maintitle", article.getMAINTITLE(), Field.Store.YES, Field.Index.ANALYZED));
            }catch(Exception e){
            }
        }

        if(article.getSUMMARY() != null){
            try{
                doc.add(new Field("summary", article.getSUMMARY(), Field.Store.YES, Field.Index.ANALYZED));
            }catch(Exception e){
            }
        }

        if(article.getKEYWORD() != null){
            try{
                doc.add(new Field("keyword", article.getKEYWORD(), Field.Store.YES, Field.Index.ANALYZED));
            }catch(Exception e){
            }
        }

        if(article.getCONTENT() != null){
            try{
                doc.add(new Field("content", article.getCONTENT(), Field.Store.NO, Field.Index.ANALYZED));
            }catch(Exception e){
            }
        }

        doc.add(new Field("lastupdated", article.getLASTUPDATED().toString(), Field.Store.YES, Field.Index.NOT_ANALYZED));
        doc.add(new Field("publishtime", article.getPUBLISHTIME().toString(), Field.Store.YES, Field.Index.NOT_ANALYZED));

        if (article.getFILENAME() != null)
            doc.add(new Field("filename", article.getFILENAME(), Field.Store.YES, Field.Index.NOT_ANALYZED));
        doc.add(new Field("dirname", article.getDIRNAME(), Field.Store.YES, Field.Index.NOT_ANALYZED));

        return doc;
    }

    public DBDocument() {

    }
}
