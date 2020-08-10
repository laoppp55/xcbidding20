package com.bizwink.util;

import java.io.File;
import java.io.FileOutputStream;
import java.io.RandomAccessFile;

/**
 * Created by Administrator on 17-9-28.
 */
public class FileUtil {
    public static boolean writeTxtFile(String content,File fileName)throws Exception{
        RandomAccessFile mm=null;
        boolean flag=false;
        FileOutputStream o=null;
        try {
            o = new FileOutputStream(fileName);
            o.write(content.getBytes("GBK"));
            o.close();
            //   mm=new RandomAccessFile(fileName,"rw");
            //   mm.writeBytes(content);
            flag=true;
        } catch (Exception e) {
            // TODO: handle exception
            e.printStackTrace();
        }finally{
            if(mm!=null){
                mm.close();
            }
        }
        return flag;
    }
}
