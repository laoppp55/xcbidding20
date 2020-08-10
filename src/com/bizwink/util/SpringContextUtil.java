package com.bizwink.util;

import org.springframework.beans.BeansException;
import org.springframework.context.ApplicationContext;

public class SpringContextUtil implements org.springframework.context.ApplicationContextAware {
    private static ApplicationContext applicationContext;

    /**
     * 获取对象
     * @param name
     * @return Object 一个以所给名字注册的bean的实例
     * @throws org.springframework.beans.BeansException
     */
    public static Object getBean(String name) throws BeansException {
        return applicationContext.getBean(name);
    }

    /**
     * 获取类型为requiredType的对象
     * @param name   bean注册名
     * @param requiredType     返回对象类型
     * @return  Object 返回requiredType类型对象
     * @throws org.springframework.beans.BeansException
     */
    public static Object getBean(String name,Class requiredType) throws BeansException{
        return  applicationContext.getBean(name,requiredType);
    }

    public static ApplicationContext getApplicationContext() {
        return applicationContext;
    }

    /**
     * 如果BeanFactory包含一个与所给名称匹配的bean定义,则返回true
     * @param name
     * @return boolean
     */
    public  static boolean containsBean(String name){
        return    applicationContext.containsBean(name);
    }

    @Override
    public   void setApplicationContext(ApplicationContext applicationContext) throws BeansException {
        setValue(applicationContext);
    }
    public static void setValue(ApplicationContext applicationContext){
        SpringContextUtil.applicationContext=applicationContext;
    }
}

