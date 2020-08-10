package com.bizwink.wxchat.menu;

import org.springframework.stereotype.Component;
import com.alibaba.fastjson.JSONObject;
import net.sf.json.JSONArray;

/**
 * @author gede
 * @version date：2019年5月28日 下午7:03:24
 * @description ：
 */
@Component
public class MenuMain {

    public void createMenu(){
        ClickButton cbt=new ClickButton();
        cbt.setKey("image");
        cbt.setName("回复图片");
        cbt.setType("click");

        ViewButton vbt=new ViewButton();
        vbt.setUrl("https://www.cnblogs.com/gede");
        vbt.setName("博客");
        vbt.setType("view");

        JSONArray sub_button=new JSONArray();
        sub_button.add(cbt);
        sub_button.add(vbt);


        JSONObject buttonOne=new JSONObject();
        buttonOne.put("name", "菜单");
        buttonOne.put("sub_button", sub_button);

        JSONArray button=new JSONArray();
        button.add(vbt);
        button.add(buttonOne);
        button.add(cbt);

        JSONObject menujson=new JSONObject();
        menujson.put("button", button);
        System.out.println(menujson);

        try{
            AccessToken accessToken= WXHttpUtils.getAccessToken();
            System.out.println(accessToken.getAccessToken());
        }catch(Exception e){
            System.out.println("请求错误！");
        }
    }

    public static void main(String args[])
    {
        MenuMain menuMain = new MenuMain();
        menuMain.createMenu();
    }
}