<%@page import="java.util.*,
                com.bizwink.cms.security.*,
                com.bizwink.cms.tree.*"
        contentType="text/html;charset=gbk"
        %>
<%@ page import="com.bizwink.cms.util.StringUtil" %>

<%
    ITree treeMgr = TreeManager.getInstance();
    Tree colTree = treeMgr.getSiteTree(28);

    StringBuffer buf = new StringBuffer();                        //�洢���ɵĲ˵���
    if (colTree.getNodeNum() > 1) {
        node[] treeNodes = colTree.getAllNodes();                     //��ȡ���������нڵ�
        int pid[] = new int[colTree.getNodeNum()];                    //����������Ҫ�Ľڵ����飬�洢��ǰδ����Ľڵ�
        String parentMenuName[] = new String[colTree.getNodeNum()];   //�洢ĳ���ڵ�������ӽڵ�ĸ��˵�����
        String parentMenu = "menu";                                     //�洢��ǰ�ڵ�ĸ��˵�����
        String menuName = "menu";                                     //�洢��ǰ�ڵ�Ĳ˵�����
        int currentID = 0;                                            //��ǰ���ڴ���Ľڵ�
        int i = 0;                                                      //ѭ������
        int[] ordernum = new int[colTree.getNodeNum()];               //��ǰ�ڵ������ӽڵ��˳���
        int orderNumber = 0;                                          //��ǰ�ڵ���ͬ���ڵ��˳���
        int nodenum = 1;                                              //��ǰ������ڵ�ĳ�ʼֵ
        int subflag = 1;                                              //�жϵ�ǰ�ڵ��Ƿ����ӽڵ�

        buf.append("        var zNodes =[\r\n");

        do {
            currentID = pid[nodenum];

            //���õ�ǰ����ڵ�ĳ�ʼֵ
            if (currentID != 0) {
                parentMenu = parentMenuName[nodenum];
                orderNumber = ordernum[nodenum];
                menuName = "menu" + currentID;
            }

            //�Ӵ���Ľڵ�������ȡ����ǰ���ڴ����Ԫ�أ����Ҹ�Ԫ���µ���Ԫ��
            //���������ӽڵ�ĸ��˵����ƣ����������ӽڵ�����кţ������е��ӽڵ����pid������
            subflag = 0;
            nodenum = nodenum - 1;
            int current_nodeid = 0;
            for (i = 0; i < colTree.getNodeNum(); i++) {
                if (treeNodes[i].getLinkPointer() == currentID) {
                    nodenum = nodenum + 1;
                    pid[nodenum] = treeNodes[i].getId();
                    parentMenuName[nodenum] = menuName;
                    ordernum[nodenum] = subflag;
                    subflag = subflag + 1;
                }

                if (treeNodes[i].getId() == currentID) current_nodeid = i;
            }

            //�����ǰ�ڵ����ӽڵ㣬���ɵ�ǰ�ڵ�Ĳ˵�
            if (subflag != 0) {
                buf.append("{ name:\"" + treeNodes[current_nodeid].getChName() + " - չ��\", open:true,\r\n");
                buf.append("children: [\r\n");
            } else {
                buf.append("{ name:\"" + treeNodes[current_nodeid].getChName() + "\"},\r\n");
            }

            //for (i = 0; i < colTree.getNodeNum(); i++) {
            //    if (treeNodes[i].getLinkPointer() == currentID) {
            //        String name = "<span class=line id=href" + treeNodes[i].getId() + ">" + StringUtil.gb2iso4View(treeNodes[i].getChName()) + "</span>";
            //        buf.append(menuName).append(".MTMAddItem(new MTMenuItem(\"");
            //        buf.append(name).append("\",\"javascript:go(" + treeNodes[i].getId() + "); oncontextmenu=showmenuie5(" + treeNodes[i].getId() + ");\",\"cmsleft\"));");
            //        buf.append("\n");
            //    }
            //}

            //������ǰ�˵������ĸ��˵�
            //if (subflag != 0 && currentID != 0)
            //    buf.append(parentMenu + ".items[" + orderNumber + "].MTMakeSubmenu(" + menuName + ");\r\n");
        } while (nodenum >= 1);
        //ֱ��pid������û�д�����Ľڵ�Ϊֹ

        System.out.println(buf.toString());
    }
%>

<!DOCTYPE html>
<HTML>
<HEAD>
    <TITLE> ZTREE DEMO - Standard Data </TITLE>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
    <link rel="stylesheet" href="style/zTree.css" type="text/css">
    <link rel="stylesheet" href="style/zTreeStyle/zTreeStyle.css" type="text/css">
    <script type="text/javascript" src="js/jquery-1.4.4.min.js"></script>
    <script type="text/javascript" src="js/jquery.ztree.core-3.5.js"></script>
    <!--  <----script type="text/javascript" src="js/jquery.ztree.excheck-3.5.js"></script>
       <script type="text/javascript" src="js/jquery.ztree.exedit-3.5.js"></script>-->
    <SCRIPT type="text/javascript">
        <!--
        var setting = {
            data: {
                key: {
                    title:"t"
                },
                simpleData: {
                    enable: true
                }
            },
            callback: {
                beforeClick: beforeClick,
                onClick: onClick
            }
        };

        /*var zNodes =[
            { name:"���ڵ�1 - չ��", open:true,
                children: [
                    { name:"���ڵ�11 - �۵�",
                        children: [
                            { name:"Ҷ�ӽڵ�111"},
                            { name:"Ҷ�ӽڵ�112"},
                            { name:"Ҷ�ӽڵ�113"},
                            { name:"Ҷ�ӽڵ�114"}
                        ]},
                    { name:"���ڵ�12 - �۵�",
                        children: [
                            { name:"Ҷ�ӽڵ�121"},
                            { name:"Ҷ�ӽڵ�122"},
                            { name:"Ҷ�ӽڵ�123"},
                            { name:"Ҷ�ӽڵ�124"}
                        ]},
                    { name:"���ڵ�13 - û���ӽڵ�", isParent:true}
                ]},
            { name:"���ڵ�2 - �۵�",
                children: [
                    { name:"���ڵ�21 - չ��", open:true,
                        children: [
                            { name:"Ҷ�ӽڵ�211"},
                            { name:"Ҷ�ӽڵ�212"},
                            { name:"Ҷ�ӽڵ�213"},
                            { name:"Ҷ�ӽڵ�214"}
                        ]},
                    { name:"���ڵ�22 - �۵�",
                        children: [
                            { name:"Ҷ�ӽڵ�221"},
                            { name:"Ҷ�ӽڵ�222"},
                            { name:"Ҷ�ӽڵ�223"},
                            { name:"Ҷ�ӽڵ�224"}
                        ]},
                    { name:"���ڵ�23 - �۵�",
                        children: [
                            { name:"Ҷ�ӽڵ�231",t:"���������Ұ�"},
                            { name:"Ҷ�ӽڵ�232",t:"���������Ұ�"},
                            { name:"Ҷ�ӽڵ�233",t:"���������Ұ�"},
                            { name:"Ҷ�ӽڵ�234",t:"���������Ұ�"}
                        ]}
                ]},
            { name:"���ڵ�3 - û���ӽڵ�", isParent:true}

        ];*/


        var zNodes =[
            { name:"petersong.coosite.com - չ��", open:true,
                 children: [
                     { name:"hello"},
                     { name:"����ר��"},
                     { name:"ok����ע�ɾ�����;��ܷŵ�Ӱ��"},
                     { name:"������"},
                     { name:"���籭����"},
                     { name:"��Ӱ���"},
                     { name:"����"},
                     { name:"��ҵ��վ����"},
                     { name:"����"},
                     { name:"��վ�ƹ�"},
                     { name:"����"},
                     { name:"�羰"},
                     { name:"�ҵ��ղ� - չ��", open:true,
                         children: [
                           { name:"iphone����"},
                           { name:"�����ʼ�"},
                           { name:"������"},
                           { name:"����ϵͳ"},
                           { name:"fckeditor"},
                           { name:"�����㷨"},
                           { name:"vb.net���"},
                           { name:"moss2007"},
                           { name:"msoffice"},
                           { name:"mfc"},
                           { name:"flash����"},
                           { name:"Э��淶"},
                           { name:"WebService"},
                           { name:"Office�ĵ�����"},
                           { name:"linux����"},
                           { name:"ϵͳ��ȫ"},
                           { name:"ͼ����"},
                           { name:"java����"},
                           { name:"Cache����"},
                           { name:"���ݹ���ϵͳ"},
                           { name:"mysql"},
                           { name:"oracle����"},
                           { name:"���ڶ�ý���ļ�����"},
                           { name:"������"}
                     ]}
        ]}
        ];

        var log, className = "dark";
        function beforeClick(treeId, treeNode, clickFlag) {
            className = (className === "dark" ? "":"dark");
            showLog("[ "+getTime()+" beforeClick ]&nbsp;&nbsp;" + treeNode.name );
            return (treeNode.click != false);
        }

        function onClick(event, treeId, treeNode, clickFlag) {
            alert("[ "+getTime()+" beforeClick ]&nbsp;&nbsp;" + treeNode.name);
            //showLog("[ "+getTime()+" onClick ]&nbsp;&nbsp;clickFlag = " + clickFlag + " (" + (clickFlag===1 ? "��ͨѡ��": (clickFlag===0 ? "<b>ȡ��ѡ��</b>" : "<b>׷��ѡ��</b>")) + ")");
        }

        function showLog(str) {
            if (!log) log = $("#log");
            log.append("<li class='"+className+"'>"+str+"</li>");
            if(log.children("li").length > 8) {
                log.get(0).removeChild(log.children("li")[0]);
            }
        }

        function getTime() {
            var now= new Date(),
                    h=now.getHours(),
                    m=now.getMinutes(),
                    s=now.getSeconds();
            return (h+":"+m+":"+s);
        }

        $(document).ready(function(){
            $.fn.zTree.init($("#treeDemo"), setting, zNodes);
        });
        //-->
    </SCRIPT>
</HEAD>

<BODY>
<h1>��򵥵��� -- ��׼ JSON ����</h1>
<h6>[ �ļ�·��: core/standardData.html ]</h6>
<div class="content_wrap">
    <div class="zTreeDemoBackground left">
        <ul id="treeDemo" class="ztree"></ul>
    </div>
    <div class="right">
        <ul class="info">
            <li class="title"><h2>1��setting ������Ϣ˵��</h2>
                <ul class="list">
                    <li class="highlight_red">��ͨʹ�ã��ޱ������õĲ���</li>
                    <li>����ʾ��ص�������ο� API �ĵ��� setting.view �ڵ�������Ϣ</li>
                    <li>name��children��title �����Զ��������ο� API �ĵ��� setting.data.key �ڵ�������Ϣ</li>
                </ul>
            </li>
            <li class="title"><h2>2��treeNode �ڵ�����˵��</h2>
                <ul class="list">
                    <li class="highlight_red">��׼�� JSON ������ҪǶ�ױ�ʾ�ڵ�ĸ��Ӱ�����ϵ
                        <div><pre xmlns=""><code>���磺
                            var nodes = [
                            {name: "���ڵ�1", children: [
                            {name: "�ӽڵ�1"},
                            {name: "�ӽڵ�2"}
                            ]}
                            ];</code></pre></div>
                    </li>
                    <li>Ĭ��չ���Ľڵ㣬������ treeNode.open ����</li>
                    <li>���ӽڵ�ĸ��ڵ㣬������ treeNode.isParent ����</li>
                    <li>��������˵����ο� API �ĵ��� "treeNode �ڵ��������"</li>
                </ul>
            </li>
        </ul>
    </div>
</div>
</BODY>
</HTML>