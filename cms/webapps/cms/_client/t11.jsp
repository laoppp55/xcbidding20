<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="viewport" content="initial-scale=1.0, user-scalable=no" />
    <style type="text/css">
        body, html {width: 100%;height: 100%;margin:0;font-family:"微软雅黑";}
        #allmap{width:100%;height:500px;}
        p{margin-left:5px; font-size:14px;}
    </style>
    <script type="text/javascript" src="http://api.map.baidu.com/api?v=2.0&ak=OwLLcpOeTOoeZeWWMGR0NHXk2D3LK5G4"></script>
    <script src="http://libs.baidu.com/jquery/1.9.0/jquery.js"></script>
    <title>给多个点添加信息窗口</title>
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
        <tr heght="50px">
            <td align="center">
                <input type="text" name="keyword" value="">
                <input type="radio" name="stype" value="1">个人办事
                <input type="radio" name="stype" value="2">企业办事
            </td>
        </tr>
        </tbody>
    </table>
    <table cellspacing="0" cellpadding="0" width="1002" border="0">
        <tbody>
        <tr>
            <td valign="middle" align="left"><img height="2" alt="" width="1" src="/images/tm.gif" /></td>
        </tr>
        <tr>
            <td valign="middle" align="left" style="padding-right: 0px; padding-left: 35px; font-weight: bold; font-size: 14px; background: url(/images/title_bg.jpg) no-repeat; padding-bottom: 0px; color: #ffffff; padding-top: 3px; height: 26px">便民服务</td>
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
                                                        <p align="center"><font face="Verdana" color="#06a506">最佳观看效果：1024＊768；IE5.0或以上版本</font></p>
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
    // 百度地图API功能
    map = new BMap.Map("allmap");
    map.enableScrollWheelZoom(true);
    map.centerAndZoom(new BMap.Point(116.36626,39.886303), 17);
    var top_left_control = new BMap.ScaleControl({anchor: BMAP_ANCHOR_TOP_LEFT});// 左上角，添加比例尺
    var top_left_navigation = new BMap.NavigationControl();  //左上角，添加默认缩放平移控件
    var top_right_navigation = new BMap.NavigationControl({anchor: BMAP_ANCHOR_TOP_RIGHT, type: BMAP_NAVIGATION_CONTROL_SMALL}); //右上角，
    map.addControl(top_left_control);
    map.addControl(top_left_navigation);
    map.addControl(top_right_navigation);

    //初始化一个二维数组，为定义好的二位数组赋值
    //“教委”、“财政局”、“民政局”、“人力社保局”、“工商局”、“规划分局”、“烟草局”、“食药局”、“司法局”、“国土分局”、“商务委”、“质监局”
    var data_info = new Array();
    var jsondata = [
        {"id":716,"siteid":2251,"companyclassid":656,"companyname":"教委","companyaddress":"宣武区商会前孙公园胡同56号","companyphone":"83558088","classification":"餐饮店","companylatitude":39.888160705566406,"companylongitude":116.37141418457031,"publishflag":0,"createdate":"Aug 26, 2011 10:52:53 AM","lastupdated":"Aug 26, 2011 10:52:53 AM"},
        {"id":715,"siteid":2251,"companyclassid":656,"companyname":"财政局","companyaddress":"北京市西城区樱桃二条","companyphone":"63533113","classification":"餐饮店","companylatitude":39.881107330322266,"companylongitude":116.36007690429688,"publishflag":0,"createdate":"Aug 26, 2011 10:44:33 AM","lastupdated":"Aug 26, 2011 10:44:33 AM"},
        {"id":714,"siteid":2251,"companyclassid":656,"companyname":"民政局","companyaddress":"宣武区输入胡同","classification":"餐饮店","companylatitude":39.88630294799805,"companylongitude":116.36625671386719,"publishflag":0,"createdate":"Aug 26, 2011 10:40:17 AM","lastupdated":"Aug 26, 2011 10:40:17 AM"},
        {"id":713,"siteid":2251,"companyclassid":656,"companyname":"人力社保局","companyaddress":"宣武区牛街春风胡同春风小区底商","companyphone":"63537536","classification":"餐饮店","companylatitude":39.88364791870117,"companylongitude":116.36383056640625,"publishflag":0,"createdate":"Aug 26, 2011 10:30:15 AM","lastupdated":"Aug 26, 2011 10:30:15 AM"},
        {"id":712,"siteid":2251,"companyclassid":656,"companyname":"工商局","companyaddress":"宣武区牛街输入胡同路北大槐树下","companyphone":"63588132","classification":"餐饮店","companylatitude":39.886619567871094,"companylongitude":116.36433410644531,"publishflag":0,"createdate":"Aug 26, 2011 10:24:17 AM","lastupdated":"Aug 26, 2011 10:24:17 AM"},
        {"id":711,"siteid":2251,"companyclassid":656,"companyname":"规划分局","companyaddress":"宣武区广安门内大街教子胡同18号","companyphone":"83545481","classification":"餐饮店","companylatitude":39.88736343383789,"companylongitude":116.36759948730469,"publishflag":0,"createdate":"Aug 26, 2011 10:21:36 AM","lastupdated":"Aug 26, 2011 10:21:36 AM"},
        {"id":710,"siteid":2251,"companyclassid":656,"companyname":"烟草局","companyaddress":"北京市西城区广安门内大街广安门内大街临时63","companyphone":"83168911","classification":"餐饮店","companylatitude":39.889671325683594,"companylongitude":116.36397552490234,"publishflag":0,"createdate":"Aug 26, 2011 10:16:45 AM","lastupdated":"Aug 26, 2011 10:16:45 AM"},
        {"id":709,"siteid":2251,"companyclassid":656,"companyname":"食药局","companyaddress":"宣武区教子胡同法源寺西里5号楼甲4号1楼","companyphone":"63530644","classification":"餐饮店","companylatitude":39.884368896484375,"companylongitude":116.36752319335938,"publishflag":0,"createdate":"Aug 26, 2011 9:58:26 AM","lastupdated":"Aug 26, 2011 9:58:26 AM"},
        {"id":708,"siteid":2251,"companyclassid":656,"companyname":"司法局","companyaddress":"宣武区广内教子胡同法源寺西里3号楼","companyphone":"83523315","classification":"餐饮店","companylatitude":39.885154724121094,"companylongitude":116.36756134033203,"publishflag":0,"createdate":"Aug 25, 2011 5:18:10 PM","lastupdated":"Aug 25, 2011 5:23:24 PM"},
        {"id":707,"siteid":2251,"companyclassid":656,"companyname":"国土分局","companyaddress":"宣武区牛街5号牛街清真超市2楼","classification":"餐饮店","companylatitude":39.88753890991211,"companylongitude":116.36338806152344,"publishflag":0,"createdate":"Aug 25, 2011 5:14:19 PM","lastupdated":"Aug 25, 2011 5:22:28 PM"},
        {"id":706,"siteid":2251,"companyclassid":656,"companyname":"商务委","companyaddress":"宣武区牛街北口3号楼","companyphone":"83548892","classification":"餐饮店","companylatitude":39.88783264160156,"companylongitude":116.3632583618164,"publishflag":0,"createdate":"Aug 25, 2011 5:05:16 PM","lastupdated":"Aug 25, 2011 5:05:16 PM"},
        {"id":704,"siteid":2251,"companyclassid":656,"companyname":"质监局","companyaddress":"宣武区牛街输入胡同27号","classification":"餐饮店","companylatitude":39.88664627075195,"companylongitude":116.36402893066406,"publishflag":0,"createdate":"Aug 25, 2011 4:58:49 PM","lastupdated":"Aug 26, 2011 9:36:51 AM"},
        {"id":703,"siteid":2251,"companyclassid":656,"companyname":"文化局","companyaddress":"宣武区牛街11号","companyphone":"58373556","classification":"餐饮店","companylatitude":39.885040283203125,"companylongitude":116.36347198486328,"publishflag":0,"createdate":"Aug 25, 2011 4:48:29 PM","lastupdated":"Aug 26, 2011 9:38:45 AM"},
        {"id":702,"siteid":2251,"companyclassid":656,"companyname":"统计局","companyaddress":"宣武区牛街5号","companyphone":"63556687","classification":"餐饮店","companylatitude":39.887535095214844,"companylongitude":116.36326599121094,"publishflag":0,"createdate":"Aug 25, 2011 4:39:31 PM","lastupdated":"Aug 26, 2011 10:01:17 AM"},
        {"id":701,"siteid":2251,"companyclassid":656,"companyname":"卫生局","companyaddress":"宣武区牛街12号","companyphone":"63550735","classification":"餐饮店","companylatitude":39.886722564697266,"companylongitude":116.36405181884766,"publishflag":0,"createdate":"Aug 25, 2011 4:32:19 PM","lastupdated":"Aug 26, 2011 9:43:19 AM"},
        {"id":700,"siteid":2251,"companyclassid":656,"companyname":"德顺楼","companyaddress":"宣武区牛街11号","companyphone":"58373366","classification":"餐饮店","summary":"我餐厅经营清真风味炒菜、烤鸭。菜品不仅继承了清真菜系里的精华，而且在保留了传统制作工艺的基础上（如红烧牛尾、芫爆散丹等其特有的风味、口味及层次感），本着老菜革新（如爆糊、炸烹虾肉等），新菜创新（如一品鱼丁、桃仁鸭方、鲍汁茄子、肉丝烧长茄等）的原则，做出了自己的风格和特色，尤其是我们的独家秘制——清蒸羊肉（羊肉鲜香润滑，汤汁味道鲜美），更适合现代人健康饮食的理念。\r\n我们自建店之初就以清真饮食文化作为企业的文化底蕴；“以德为先，以人为本”作为企业的建店宗旨。\r\n而真诚服务是我们服务于客人的宗旨，对于客人我们始终会以一种亲人的和善服务。我们会为每一位来店就餐的客人在接受优质服务的同时，让客人拥有宾至如归得感受。\r\n经过不断的努力，我店被北京市卫生局评为卫生A级单位，被市商务局评为特色餐厅，被极具权威的媒体评为京城百家必去餐厅、十佳京味餐厅和最具文化价值品牌的十佳餐厅。","companylatitude":39.88512420654297,"companylongitude":116.36328887939453,"publishflag":0,"createdate":"Aug 25, 2011 4:23:46 PM","lastupdated":"Aug 25, 2011 4:23:46 PM"},
        {"id":698,"siteid":2251,"companyclassid":656,"companyname":"奶酪魏(牛街总店)","companyaddress":"宣武区广安门内大街202号107室","companyphone":"63522402","classification":"餐饮店","companylatitude":39.888736724853516,"companylongitude":116.36235046386719,"publishflag":0,"createdate":"Aug 25, 2011 4:11:17 PM","lastupdated":"Aug 29, 2011 11:33:07 AM"},
        {"id":697,"siteid":2251,"companyclassid":656,"companyname":"清真吐鲁番餐厅","companyaddress":"宣武区牛街北口6号楼","companyphone":"83164691","classification":"餐饮店","companylatitude":39.887855529785156,"companylongitude":116.36408233642578,"publishflag":0,"createdate":"Aug 25, 2011 3:46:12 PM","lastupdated":"Aug 26, 2011 9:28:27 AM"},
        {"id":696,"siteid":2251,"companyclassid":656,"companyname":"聚宝源","companyaddress":"宣武区牛街西里商业1号楼5-2号","companyphone":"83545602","classification":"餐饮店","companylatitude":39.88670349121094,"companylongitude":116.36329650878906,"publishflag":0,"createdate":"Aug 25, 2011 3:33:17 PM","lastupdated":"Aug 25, 2011 3:33:17 PM"}
        ];
    for(var k=0;k < 19;k++){                   //一维长度为i,i为变量，可以根据实际情况改变
    //for(var k=0;k < 1;k++){
        data_info[k]=new Array();                                      //声明二维，每一个一维数组里面的一个元素都是一个数组；
        data_info[k][0] = jsondata[k].companylongitude;
        data_info[k][1] = jsondata[k].companylatitude;
        data_info[k][2] = "<div><h4 style='margin:0 0 5px 0;padding:0.2em 0'>" +
                jsondata[k].companyname +
                "<br/>行政审批" +
                "<br/><a href='http://wsbs.bjsjs.gov.cn//slbglm/5091.htm' target='_blank'>" + "幼儿园、小学、初级中学的教师资格认定" + "</a></h4>"+
                "<br/><a href='http://wsbs.bjsjs.gov.cn//slbglm/5088.htm' target='_blank'>" + "幼儿园、小学、初级中学的教师资格认定" + "</a></h4>"+
                "<br/><a href='http://wsbs.bjsjs.gov.cn//slbglm/5089.htm' target='_blank'>" + "实施学历教育、学前教育、自学考试助学及其他文化教育的民办学校设立、变更、终止批准（分立、合并）" + "</a></h4>"+
                "<br/><a href='http://wsbs.bjsjs.gov.cn//slbglm/5094.htm' target='_blank'>" + "民办学校变更举办者的核准" + "</a></h4>";

        //"<img style='float:right;margin:4px' id='imgDemo' src='http://app.baidu.com/map/images/tiananmen.jpg' width='139' height='104' title='天安门'/>" +
        if (jsondata[k].summary != null)
            data_info[k][2] = data_info[k][2] + "<p style='margin:0;line-height:1.5;font-size:13px;text-indent:2em'>" + jsondata[k].summary + "..." +"</p>" +
                    "</div>";
        else
            data_info[k][2] = data_info[k][2] + "</div>";
        data_info[k][3] = jsondata[k].id;
        data_info[k][4] = jsondata[k].companyname;
    }

    var opts = {
        width : 250,     // 信息窗口宽度
        height: 600,     // 信息窗口高度
        title : "信息窗口" , // 信息窗口标题
        enableMessage:true//设置允许信息窗发送短息
    };

    for(var i=0;i<data_info.length;i++){
        var marker = new BMap.Marker(new BMap.Point(data_info[i][0],data_info[i][1]));  // 创建标注
        var content = data_info[i][2];
        var artid = data_info[i][3];
        map.addOverlay(marker);               // 将标注添加到地图中
        var label = new BMap.Label(data_info[i][4],{offset:new BMap.Size(20,-10)});
        marker.setLabel(label);
        addClickHandler(artid,content,marker);
    }

    function addClickHandler(artid,content,marker){
        marker.addEventListener("click",function(e){
                    //alert(artid);
                    //window.open("detail.jsp?id=" +  artid);
                    openInfo(content,e)
                }
        );
    }
    function openInfo(content,e){
        var p = e.target;
        var point = new BMap.Point(p.getPosition().lng, p.getPosition().lat);
        var infoWindow = new BMap.InfoWindow(content,opts);  // 创建信息窗口对象
        map.openInfoWindow(infoWindow,point); //开启信息窗口
    }
</script>
