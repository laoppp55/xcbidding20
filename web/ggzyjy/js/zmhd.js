/**
 * Created with IntelliJ IDEA.
 * User: Mark
 * Date: 13-10-14
 * Time: 上午10:44
 * To change this template use File | Settings | File Templates.
 */
function lxxd_index(id, length) {
    $.ajax({
        type: "post",
        url: "/sjswsbs/Zmhd.action",
        data: {"getBoardInfo": "", "board": "http://zmhd.bjsjs.gov.cn/zmhd/lxxd.jsp", "catg": 0},
        success: function (data) {
            $("#" + id).empty();
            if (length > data.length) length = data.length;
            for (var i = 0; i < length; i++) {
                $("<li class='laixin_type'>" + data[i].code_Name + "</li>" +
                    "<li class='laixin_title' style='overflow: hidden'>" + data[i].title + "</li>").appendTo("#" + id);
            }
            $("#" + id + " a").each(function () {
                //$(this).attr("href", "http://zmhd.bjsjs.gov.cn" + $(this).attr("href"));
               var  oldhref = $(this).attr("href");				 
				if (oldhref.indexOf("www.bjsjs") >=0)
				{
					oldhref =oldhref.replace("www", "zmhd");
					$(this).attr("href",   oldhref );
				}else {
					$(this).attr("href", "http://zmhd.bjsjs.gov.cn" + oldhref );
				}
            });
        }
    });
}
function lxxd(id, length) {
    $.ajax({
        type: "post",
        url: "/sjswsbs/Zmhd.action",
        data: {"getBoardInfo": "", "board": "http://zmhd.bjsjs.gov.cn/zmhd/lxxd.jsp", "catg": 0},
        success: function (data) {
            $("#" + id).empty();
            if (length > data.length) length = data.length;
            for (var i = 0; i < length; i++) {
                $("<li class='tit_115'>" + data[i].code_Name + "</li>" +
                    "<li class='tit_220' style='overflow: hidden'>" + data[i].title + "</li>" +
                    "<li class='tit_65'>" + data[i].oprTime + "</li>").appendTo("#" + id);
            }
            $("#" + id + " a").each(function () {
               // $(this).attr("href", "http://zmhd.bjsjs.gov.cn" + $(this).attr("href"));
			   var  oldhref = $(this).attr("href");				 
				if (oldhref.indexOf("www.bjsjs") >=0)
				{
					oldhref =oldhref.replace("www", "zmhd");
					$(this).attr("href",   oldhref );
				}else {
					$(this).attr("href", "http://zmhd.bjsjs.gov.cn" + oldhref );
				}
            });
        }
    });
}
function zxlx(id) {
    $.ajax({
        type: "post",
        url: "/sjswsbs/Zmhd.action",
        data: {"getBoardInfo": "", "board": "http://zmhd.bjsjs.gov.cn/zmhd/zxlx.jsp", "catg": 1},
        success: function (data) {
            $("#" + id).empty();
            for (var i = 0; i < 3; i++) {
                if (data.length > i) {
                    $("<li class='tit_260' style='overflow: hidden'>" + data[i].title + "</li>" +
                        "<li class='tit_65'>" + data[i].submit_time + "</li>" +
                        "<li class='tit_65'>" + data[i].name + "</li>").appendTo("#" + id);
                } else {
                    $("<li class='tit_260'> </li>" +
                        "<li class='tit_65'> </li>" +
                        "<li class='tit_65'> </li>").appendTo("#" + id);
                }
            }
        }
    });
}
function zxhf(id, length) {
    $.ajax({
        type: "post",
        url: "/sjswsbs/Zmhd.action",
        data: {"getBoardInfo": "", "board": "http://zmhd.bjsjs.gov.cn/zmhd/zxhf.jsp", "catg": 2},
        success: function (data) {
            $("#" + id).empty();
            for (var i = 0; i < 3; i++) {
                if (data.length > i) {
                    $("<li class='tit_260' style='overflow: hidden'>" + data[i].title + "</li>" +
                        "<li class='tit_65'>" + data[i].submit_time + "</li>" +
                        "<li class='tit_65'>" + data[i].name + "</li>").appendTo("#" + id);
                } else {
                    $("<li class='tit_260'> </li>" +
                        "<li class='tit_65'> </li>" +
                        "<li class='tit_65'> </li>").appendTo("#" + id);
                }
            }
        }
    });
}

function slph(id){
            $.ajax({
                type: "post",
                url: "/sjswsbs/Zmhd.action",
                data: {"getBoardInfo": "", "board": "http://zmhd.bjsjs.gov.cn/zmhd/slphb.jsp","catg":3},
                success: function (data) {
                    $("#"+id).empty();
                    for (var i = 0; i < 5; i++) {
                        $("<li class='con_100 no"+(i+1)+"'>" + data[i].name + "</li>" +
                          "<li class='con_50'>" + data[i].finish + "</li>" +
                          "<li class='con_65'>" + data[i].percent + "</li>").appendTo("#"+id);
                    }
                }
            });
        }