<%@ page import="com.bizwink.cms.util.SessionUtil" %>
<%@ page import="com.bizwink.cms.security.Auth" %>
<%@ page import="org.springframework.context.ApplicationContext" %>
<%@ page import="com.bizwink.util.SpringInit" %>
<%@ page import="com.bizwink.service.OrganizationService" %>
<%@ page import="com.bizwink.po.Organization" %>
<%@ page import="java.math.BigDecimal" %><%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 18-6-6
  Time: 上午10:22
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    Auth authToken = SessionUtil.getUserAuthorization(request, response, session);
    if (authToken == null)
    {
        response.sendRedirect(response.encodeRedirectURL("/webbuilder/index.jsp?msg=系统超时，请重新登陆!"));
        return;
    }

    int siteid = authToken.getSiteID();
    ApplicationContext appContext = SpringInit.getApplicationContext();
    Organization organization = null;
    if (appContext!=null) {
        OrganizationService organizationService = (OrganizationService)appContext.getBean("organizationService");
        organization = organizationService.getRootOrganization(BigDecimal.valueOf(siteid));
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <title>网站内容管理系统</title>
    <link rel="stylesheet" href="../design/css/layui.css">
    <link rel="stylesheet" href="../css/mycss.css">
    <link rel="stylesheet" href="../css/cms_css.css">
    <script type="text/javascript" src="../js/jquery-1.12.4.js"></script>
    <script type="text/javascript" src="../js/json2.js"></script>
    <script type="text/javascript" src="../design/layui.js"></script>
    <!--引用xtree-->
    <script type="text/javascript" src="../design/layui-xtree.js"></script>
    <script>
        $(document).ready(function(){
            layui.use('element', function(){
                var element = layui.element;
            });
        });

        function orgManager() {
            alert("组织架构管理");
            $("#sidetreeid").css('display','none');
        }
    </script>
</head>
<body class="layui-layout-body">
<div class="layui-layout layui-layout-admin">
    <div class="layui-header">
        <div class="layui-logo">CMS--组织架构管理</div>
        <ul class="layui-nav layui-layout-left">
            <li class="layui-nav-item"><a href="../column/indexnew.jsp">栏目管理</a></li>
            <li class="layui-nav-item"><a href="../template/indexnew.jsp">模板管理</a></li>
            <li class="layui-nav-item"><a href="../article/indexnew.jsp">文章管理</a></li>
            <li class="layui-nav-item"><a href="../articlemove/indexnew.jsp">文章迁移</a></li>
            <li class="layui-nav-item"><a href="../audit/indexnew.jsp">文章审核</a></li>
            <li class="layui-nav-item"><a href="../publish/indexnew.jsp">文章发布</a></li>
            <!--li class="layui-nav-item"><a href="javascript:;">系统设置</a></li-->
            <li class="layui-nav-item">
                <a href="javascript:;">系统设置</a>
                <dl class="layui-nav-child">
                    <dd><a href="../member/indexnew.jsp">用户管理</a></dd>
                    <dd><a href="../organization/indexnew.jsp">组织架构管理</a></dd>
                    <dd><a href="../roles/index.jsp">角色管理</a></dd>
                    <dd><a href="../rights/index.jsp">权限管理</a></dd>
                </dl>
            </li>
            <li class="layui-nav-item"><a href="javascript:;">工具箱</a></li>
        </ul>
        <ul class="layui-nav layui-layout-right">
            <li class="layui-nav-item">
                <a href="javascript:;">
                    <img src="http://t.cn/RCzsdCq" class="layui-nav-img">
                    贤心
                </a>
                <dl class="layui-nav-child">
                    <dd><a href="">基本资料</a></dd>
                    <dd><a href="">安全设置</a></dd>
                </dl>
            </li>
            <li class="layui-nav-item"><a href="">退了</a></li>
        </ul>
    </div>

    <div class="layui-body">
        <!-- 内容主体区域 -->
        <div id="contentid">
            文章列表区域
        </div>
    </div>

    <div class="layui-footer">
        <!-- 底部固定区域 -->
        © layui.com - 底部固定区域
    </div>
</div>
<script>
    /*layui.use(['element', 'tree', 'layer'], function(){
        var layer = layui.layer,$ = layui.jquery;
        //添加选中颜色显示
        $("body").on("mousedown", ".layui-tree a", function() {
            if(!$(this).siblings('ul').length) {
                $(".layui-tree a").removeClass('active');
                $(this).find('cite').parent().addClass('active');
            }
        });

        var tree = layui.tree;
        var inst1 = tree.render({
            elem: '#mytree', //指定元素
            showLine:true,
            onlyIconControl:true,
            //skin: 'sidebar',
            skin: 'dx',
            target: '_blank', //是否新选项卡打开（比如节点返回href才有效）
            click: function(item){ //点击节点回调
                htmlobj=$.ajax({
                    url:"articlesnew.jsp",
                    dataType:'json',
                    async:false,
                    data:{
                        column:item.id,
                        start:0
                    },
                    success:function(data){

                    }
                });
                layer.msg('当前节名称：'+ item.data.title + "==" + item.data.id + '<br>全部参数：'+ JSON.stringify(item));
                console.log(item);
            },
            data:< %=buf.toString()%>
        });

        $("#treebox").css("height",document.documentElement.clientHeight-60);
    });*/
</script>
</body>
</html>
