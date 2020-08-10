<%@page contentType="text/html;charset=gbk"%>
<%@ page import="java.util.*,
                 com.bizwink.cms.toolkit.companyinfo.*,
                 com.bizwink.cms.util.*" contentType="text/html;charset=gbk" %>
<%@ page import="com.bizwink.webapps.feedback.*" %>
<%@ page import="com.google.gson.Gson" %>

<%
    String sitename = request.getServerName();
    ICompanyinfoManager companyManager = CompanyinfoPeer.getInstance();
    List companyList = new ArrayList();
    List companyClassList = new ArrayList();
    int columnID = ParamUtil.getIntParameter(request, "column", 0);
    IFeedbackManager feedMgr = FeedbackPeer.getInstance();
    int siteid = feedMgr.getSiteID(sitename);
    sitename = StringUtil.replace(sitename,".","_");
    companyClass companyclass = null;
    try {
        companyClassList = companyManager.getCompanyClassList(siteid);
        if (columnID == 0) {
            if (companyClassList.size() > 0) {
                companyclass = (companyClass)companyClassList.get(0);
                companyList = companyManager.getCompanyInfos(siteid,companyclass.getId(), 0, 50, "",0);
            }
        } else {
            companyList = companyManager.getCompanyInfos(siteid,columnID, 0, 50, "",0);
        }
    } catch (Exception e) {
        e.printStackTrace();
    }

    Gson gson = new Gson();
    String jsondata=null;
    if (companyList != null){
        jsondata = gson.toJson(companyList);
    }

    float latf = 39.88630294799805f;
    float lngf = 116.36625671386719f;
    StringBuffer buf = new StringBuffer();
%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="viewport" content="initial-scale=1.0, user-scalable=no" />
    <style type="text/css">
        body, html {width: 100%;height: 100%;margin:0;font-family:"΢���ź�";}
        #allmap{width:100%;height:500px;}
        p{margin-left:5px; font-size:14px;}
    </style>
    <script type="text/javascript" src="http://api.map.baidu.com/api?v=2.0&ak=hU1cmHl6RpfSynnsYXRcLPYlahyoosY1  "></script>
    <script src="http://libs.baidu.com/jquery/1.9.0/jquery.js"></script>
    <title>������������Ϣ����</title>
</head>
<body>
<center>
    <table cellspacing="0" cellpadding="0">
        <tbody>
        <tr>
            <td><img alt="" hspace="0" border="0" src="/images/picp55cggg6.jpg" /></td>
        </tr>
        </tbody>
    </table>
    <table cellspacing="0" cellpadding="0">
        <tbody>
        <tr>
            <td align="center"></td>
        </tr>
        </tbody>
    </table>
    <table cellspacing="0" cellpadding="0" width="1002" border="0">
        <tbody>
        <tr>
            <td valign="middle" align="left"><img height="2" alt="" width="1" src="/images/tm.gif" /></td>
        </tr>
        <tr>
            <td valign="middle" align="left" style="padding-right: 0px; padding-left: 35px; font-weight: bold; font-size: 14px; background: url(/images/title_bg.jpg) no-repeat; padding-bottom: 0px; color: #ffffff; padding-top: 3px; height: 26px">�������</td>
        </tr>
        </tbody>
    </table>
    <table cellspacing="0" cellpadding="0" width="1002" border="0" style="border-right: #6dbe09 1px solid; border-left: #6dbe09 1px solid; border-bottom: #6dbe09 1px solid">
        <tbody>
        <tr>
            <td align="center" style="padding-right: 10px; padding-left: 10px; padding-bottom: 10px; padding-top: 10px">
                <div id="allmap"></div>
            </td>
        </tr>
        </tbody>
    </table>
    <table cellspacing="0" cellpadding="0" width="1002" bgcolor="#ffffff">
        <tbody>
        <tr>
            <td valign="top">
                <table cellspacing="0" cellpadding="0" border="0" style="margin-top: 0px; margin-left: 0px; width: 1002px">
                    <tbody>
                    <tr>
                        <td>
                            <table cellspacing="0" cellpadding="0" style="background-image: url(/img/tm.gif); height: 50px">
                                <tbody>
                                <tr>
                                    <td style="background-position: 0% 0%; background-image: none"><img alt="" style="height: 0px" src="/images/tm.gif" /></td>
                                    <td valign="top" style="background-position: 0% 0%; background-image: none; width: 100%">
                                        <div id="CNT_4701/NJZWqcbs/14279" style="margin-top: 5px; margin-left: 0px; width: 1000px; margin-right: 0px">
                                            <table cellspacing="0" cellpadding="0" width="100%">
                                                <tbody>
                                                <tr>
                                                    <td>
                                                        <p align="center"><font face="Verdana" color="#06a506">��ѹۿ�Ч����1024��768��IE5.0�����ϰ汾</font></p>
                                                    </td>
                                                </tr>
                                                </tbody>
                                            </table>
                                            <!--PAGELETSUCCESS--></div>
                                    </td>
                                    <td style="background-position: 0% 0%; background-image: none"><img alt="" style="height: 0px" src="/images/tm.gif" /></td>
                                </tr>
                                </tbody>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <table cellspacing="0" cellpadding="0" style="background-position: 0% 0%; background-image: none">
                                <tbody>
                                <tr>
                                    <td style="background-image: none"><img alt="" style="width: 0px; height: 0px" src="/images/tm.gif" /></td>
                                    <td style="width: 100%"><img alt="" style="width: 0px" src="/images/tm.gif" /></td>
                                    <td style="background-image: none"><img alt="" style="width: 0px; height: 0px" src="/images/tm.gif" /></td>
                                </tr>
                                </tbody>
                            </table>
                        </td>
                    </tr>
                    </tbody>
                </table>
            </td>
        </tr>
        </tbody>
    </table>
</center>
</body>
</html>
<script type="text/javascript">
    // �ٶȵ�ͼAPI����
    map = new BMap.Map("allmap");
    map.enableScrollWheelZoom(true);
    map.centerAndZoom(new BMap.Point(<%=lngf%>,<%=latf%>), 17);
    var top_left_control = new BMap.ScaleControl({anchor: BMAP_ANCHOR_TOP_LEFT});// ���Ͻǣ���ӱ�����
    var top_left_navigation = new BMap.NavigationControl();  //���Ͻǣ����Ĭ������ƽ�ƿؼ�
    var top_right_navigation = new BMap.NavigationControl({anchor: BMAP_ANCHOR_TOP_RIGHT, type: BMAP_NAVIGATION_CONTROL_SMALL}); //���Ͻǣ�
    map.addControl(top_left_control);
    map.addControl(top_left_navigation);
    map.addControl(top_right_navigation);

    //��ʼ��һ����ά���飬Ϊ����õĶ�λ���鸳ֵ
    var data_info = new Array();
    var jsondata = <%=jsondata%>;
    for(var k=0;k < <%=companyList.size()%>;k++){                   //һά����Ϊi,iΪ���������Ը���ʵ������ı�
        data_info[k]=new Array();                                      //������ά��ÿһ��һά���������һ��Ԫ�ض���һ�����飻
        data_info[k][0] = jsondata[k].companylongitude;
        data_info[k][1] = jsondata[k].companylatitude;
        data_info[k][2] = "<div><h4 style='margin:0 0 5px 0;padding:0.2em 0'><a href='#' onclick=window.open('detail.jsp?id=" + jsondata[k].id + "')>" + jsondata[k].companyname + "</a></h4>";
        //"<img style='float:right;margin:4px' id='imgDemo' src='http://app.baidu.com/map/images/tiananmen.jpg' width='139' height='104' title='�찲��'/>" +
        if (jsondata[k].summary != null)
            data_info[k][2] = data_info[k][2] + "<p style='margin:0;line-height:1.5;font-size:13px;text-indent:2em'>" + jsondata[k].summary + "..." +"</p>" +
                    "</div>";
        else
            data_info[k][2] = data_info[k][2] + "</div>";
        data_info[k][3] = jsondata[k].id;
    }

    var opts = {
        width : 250,     // ��Ϣ���ڿ��
        height: 80,     // ��Ϣ���ڸ߶�
        title : "��Ϣ����" , // ��Ϣ���ڱ���
        enableMessage:true//����������Ϣ�����Ͷ�Ϣ
    };
    for(var i=0;i<data_info.length;i++){
        var marker = new BMap.Marker(new BMap.Point(data_info[i][0],data_info[i][1]));  // ������ע
        var content = data_info[i][2];
        var artid = data_info[i][3];
        map.addOverlay(marker);               // ����ע��ӵ���ͼ��
        addClickHandler(artid,content,marker);
    }
    function addClickHandler(artid,content,marker){
        marker.addEventListener("click",function(e){
                    //alert(artid);
                    window.open("detail.jsp?id=" +  artid);
                    //openInfo(content,e)
                }
        );
    }
    function openInfo(content,e){
        var p = e.target;
        var point = new BMap.Point(p.getPosition().lng, p.getPosition().lat);
        var infoWindow = new BMap.InfoWindow(content,opts);  // ������Ϣ���ڶ���
        map.openInfoWindow(infoWindow,point); //������Ϣ����
    }
</script>
