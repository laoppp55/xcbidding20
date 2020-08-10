package com.bizwink.util;

public class StringArraySort {
    public static String[] arraySort(String[] input){
        for (int i=0;i<input.length-1;i++){
            for (int j=0;j<input.length-i-1;j++) {
                if(isBiggerThan(input[j],input[j+1])){
                    String temp=input[j];
                    input[j]=input[j+1];
                    input[j+1]=temp;
                }
            }
        }
        return input;
    }

    /*如果first大于second，则返回true，否则返回false
     *
     */
    private static boolean isBiggerThan(String first, String second){
        if(first==null||second==null||"".equals(first) || "".equals(second)){
            System.out.println("字符串不能为空！");
            return false;
        }
        char[] arrayfirst=first.toCharArray();
        char[] arraysecond=second.toCharArray();
        int minSize = Math.min(arrayfirst.length, arraysecond.length);
        for (int i=0;i<minSize;i++) {
            if((int)arrayfirst[i]>(int)arraysecond[i]){
                return true;
            }else if((int)arrayfirst[i] < (int)arraysecond[i]){
                return false;
            }
        }
        if(arrayfirst.length>arraysecond.length){
            return true;
        }else {
            return false;
        }
    }

    public static void main(String[] args) {
        String[] input=new String[] {"tmc","apad","apache","nihao","nihaoa"};
        String[] output=arraySort(input);
        for (String out:output) {
            System.out.println(out);
        }
    }
}
