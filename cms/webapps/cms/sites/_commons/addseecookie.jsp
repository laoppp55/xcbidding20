<%@ page import="java.net.URLEncoder" contentType="text/html;charset=gbk" %>
<%@ page import="com.bizwink.cms.util.ParamUtil" %>
<%@ page import="com.bizwink.cms.news.IArticleManager" %>
<%@ page import="com.bizwink.cms.news.ArticlePeer" %>
<%@ page import="com.bizwink.cms.news.Article" %>
<%
    int articleid = ParamUtil.getIntParameter(request, "articleid", -1);
    String sitename = request.getServerName();
    IArticleManager articlepeer = ArticlePeer.getInstance();
    Article article = articlepeer.getArticle(articleid);

    //׷��id
    Cookie[] cookies = request.getCookies();
    boolean flag = true;
    if (cookies != null) {
        System.out.println("cookies=" + cookies.length);
        for (int i = 0; i < cookies.length; i++) {
            System.out.println("name=" + cookies[i].getName());
            if (cookies[i].getName().equals(sitename)) {
                String oldValue = cookies[i].getValue();
                System.out.println("value=" + cookies[i].getValue());
                String newValue="";
                if(oldValue==null||oldValue.equals("null")){
                    oldValue="";
                }
                if(oldValue.indexOf(articleid+"")==-1){
                    newValue = oldValue + "_" + articleid;
                } else {
                    newValue=oldValue;
                }
                cookies[i].setValue(newValue);
                cookies[i].setPath("/");
                cookies[i].setMaxAge(365 * 24 * 60 * 60);
                response.addCookie(cookies[i]);
                flag=false;
                break;
            }
        }
    }


    if(flag){
        Cookie cookie = new Cookie(sitename, "_"+articleid);
        cookie.setPath("/");//���Ҫ����
        // cookie.setDomain(".wangwz.com");//���ҲҪ���ò���ʵ�������������վ����
        cookie.setMaxAge(365 * 24 * 60 * 60);//�����õĻ�����cookies��д��Ӳ��,����д���ڴ�,ֻ�ڵ�ǰҳ������,����Ϊ��λ
        response.addCookie(cookie);

        //cookie = new Cookie("nick", URLEncoder.encode("��ΰ��","UTF-8"));
        // cookie.setPath("/");
        //cookie.setDomain(".wangwz.com");
        //cookie.setMaxAge(365*24*60*60);
        //response.addCookie(cookie);
    }
%>