//prefix:数据库类型，空表示oracle，m表示mysql,s表示MSQL
function doLogin(prefix) {
    var username = loginForm.userid.value;
    var passwd = loginForm.passwd.value;
    //检查用户是否存在

    if (prefix==null || prefix=="") {
        $.post("/users/doLogin.jsp",{
                userid:encodeURI(username),
                pwd:encodeURI(passwd),
                doLogin:true
            },
            function(data) {
                if (data.username!=null) {
                    $("#userInfos").html("欢迎你：<font color=\"red\">" + data.username + "</font>&nbsp;&nbsp;<a href='#' onclick='javascript:logoff(prefix);'>退出</a>");
                    $("#userInfos").css({color:"red"});
                } else {
                    window.location.href="/users/login.jsp";
                }
            },
            "json"
        )
    } else {
        $.post("/users/" + prefix + "/doLogin.jsp",{
                userid:encodeURI(username),
                pwd:encodeURI(passwd),
                doLogin:true
            },
            function(data) {
                if (data.username!=null) {
                    $("#userInfos").html("欢迎你：<font color=\"red\">" + data.username + "</font>&nbsp;&nbsp;<a href='#' onclick='javascript:logoff(prefix);'>退出</a>");
                    $("#userInfos").css({color:"red"});
                } else {
                    window.location.href="/users/" + prefix + "/login.jsp";
                }
            },
            "json"
        )
    }
}

//prefix:数据库类型，空表示oracle，m表示mysql,s表示MSQL
function doRegister(prefix,iHeight,iWidth) {
    //获得窗口的垂直位置
    var iTop = (window.screen.availHeight - 30 - iHeight) / 2;
    //获得窗口的水平位置
    var iLeft = (window.screen.availWidth - 10 - iWidth) / 2;

    if (prefix == null || prefix == "")
        window.open("/users/userreg.jsp",'regwin', 'height=' + iHeight + ', width=' + iWidth + ', top='+iTop + ', left=' + iLeft + ', toolbar=no, menubar=no, scrollbars=yes, resizable=yes, location=no, status=no');
    else
        window.open("/users/" + prefix + "/userreg.jsp",'regwin', 'height=' + iHeight + ', width=' + iWidth + ', top='+iTop + ', left=' + iLeft + ', toolbar=no, menubar=no, scrollbars=yes, resizable=yes, location=no, status=no');
}

//prefix:数据库类型，空表示oracle，m表示mysql,s表示MSQL
function logoff(prefix) {
    $.post("/users/logoff.jsp",{},
        function(data) {
            if (data.indexOf("nologin") > -1) {
                //var htmlcode = '<a href="/users/m/login.jsp" class="red">登录</a> | <a href="/users/m/userreg.jsp">注册</a>   <a href="/users/m/findPwd.jsp">忘记密码</a>   <a href="/users/m/personinfo.jsp">个人中心</a>';
                /*var htmlcode = '<form name="loginForm">' +
                    '<input class="txt" name="userid" type="text" /> '+
                    '<input class="txt" type="password" name="passwd" /> '+
                    '<input class="btn" type="button" name="" onclick="javascript:doLogin(prefix);" value="登录" /> '+
                    '<input class="btn" type="button" onclick="javascript:doRegister(prefix,800,1000);" value="注册" />'+
                    '</form>';
                */
                window.location.href="/ggzyjy/index.shtml";
                //$("#userInfos").html(htmlcode);
            }
        }
    )
}

function change_yzcodeimage() {
    $("#yzImageID").attr("src","/users/image.jsp?temp=" + Math.random());
}

String.prototype.getBytes = function() {
    var cArr = this.match(/[^\x00-\xff]/ig);
    return this.length + (cArr == null ? 0 : cArr.length);
}

function setMessage(ftype) {
    var name = regform.username.value;
    var email = regform.email.value;
    var mphone = regform.mphone.value;

    if (ftype=="usermsg") {
        if (name==null || name=="") {
            $.msgbox({
                height:150,
                width:250,
                content:{type:'alert', content:'用户名不能为空'},
                animation:0,       //禁止拖拽
                drag:false         //禁止动画
                //autoClose: 10     //自动关闭
            });
            return false;
        }
        if (name.getBytes() < 4) {
            //alert("用户名长度必须3位以上");
            $.msgbox({
                height:150,
                width:250,
                content:{type:'alert', content:'用户名长度必须4位字母或2个汉字以上,字母或汉字开头'},
                animation:0,        //禁止拖拽
                drag:false          //禁止动画
                //autoClose: 10       //自动关闭
            });
            return false;
        }
        var reg = /[^\u4e00-\u9fa5A-Za-z0-9]/g;
        if (reg.test(name)) {
            //alert("用户名格式不正确");
            $.msgbox({
                height:150,
                width:250,
                content:{type:'alert', content:'用户名格式不正确，用户名只能包括含字母、数字和汉字'},
                animation:0,       //禁止拖拽
                drag:false         //禁止动画
                //autoClose: 10     //自动关闭
            });
            return false;
        }

        var reg = /^[\u4e00-\u9fa5A-Za-z]{1,1}$/;
        if (reg.test(name)) {
            $.msgbox({
                height:150,
                width:250,
                content:{type:'alert', content:'用户名格式不正确，用户名必须以字母或者汉字开头'},
                animation:0,       //禁止拖拽
                drag:false         //禁止动画
                //autoClose: 10     //自动关闭
            });
            return false;
        }

        //检查用户是否存在
        $.post("/users/checkname.jsp",{
                username:encodeURI(name)
            },
            function(data) {
                if (data.indexOf("true") > -1) {
                    $("#usermsg").html("此用户名已经被注册过，请更换用户名");
                    $("#usermsg").css({color:"red"});
                } else {
                    $("#usermsg").html("用户名可以使用");
                    $("#usermsg").css({color:"green"});
                }
            }
        )
    } else if (ftype=="emailmsg") {
        //检查电子邮件信息的合法性判断
        var retcode = (new RegExp(/^\w+((-\w+)|(\.\w+))*\@[A-Za-z0-9]+((\.|-)[A-Za-z0-9]+)*\.[A-Za-z0-9]+$/).test(email));
        if(email=="" || email==null){
            $.msgbox({
                height:120,
                width:250,
                content:{type:'alert', content:'请填写电子邮件，电子邮件地址不能为空'},
                animation:0,       //禁止拖拽
                drag:false         //禁止动画
                //autoClose: 10     //自动关闭
            });
            return false;
        }else if(!retcode){
            $.msgbox({
                height:120,
                width:250,
                content:{type:'alert', content:'电子邮件地址格式不正确！'},
                animation:0,       //禁止拖拽
                drag:false         //禁止动画
                //autoClose: 10     //自动关闭
            });
            return false;
        }
        //检查电子邮件地址是否存在
        $.post("/users/checkemail.jsp?thetime=<%=System.currentTimeMillis()%>",
            {
                email:encodeURI(email)
            },
            function(data) {
                //alert(data);
                if (data.indexOf("true") > -1) {
                    $("#emailmsg").html("电子邮件地址已经被注册过");
                    $("#emailmsg").css({color:"red"});
                } else {
                    $("#emailmsg").html("电子邮件地址可以使用");
                    $("#emailmsg").css({color:"green"});
                }
            }
        )
    } else if (ftype=="mphonemsg") {
        //手机信息的合法性判断
        var regPartton=/1[3-8]+\d{9}/;
        if(mphone=="" || mphone==null){
            $.msgbox({
                height:120,
                width:250,
                content:{type:'alert', content:'请填写手机号码，手机号码不能为空'},
                animation:0,       //禁止拖拽
                drag:false         //禁止动画
                //autoClose: 10     //自动关闭
            });
            return false;
        }else if(!regPartton.test(mphone)){
            $.msgbox({
                height:120,
                width:250,
                content:{type:'alert', content:'手机号码格式不正确！'},
                animation:0,       //禁止拖拽
                drag:false         //禁止动画
                //autoClose: 10     //自动关闭
            });
            return false;
        }
        //检查移动电话号码是否存在
        $.post("/users/checkcellphone.jsp?thetime=<%=System.currentTimeMillis()%>",
            {
                mphone:encodeURI(mphone)
            },
            function(data) {
                //alert(data);
                if (data.indexOf("true") > -1) {
                    $("#mphonemsg").html("手机号码已经被注册过");
                    $("#mphonemsg").css({color:"red"});
                } else {
                    $("#mphonemsg").html("手机号码可以使用");
                    $("#mphonemsg").css({color:"green"});
                }
            }
        )
    }
}

function validpassword(){
    var pass1 = regform.pwd.value;
    var pass2 = regform.repwd.value;

    var allValid = true;

    if( trim(pass1)=="" ) {
        $.msgbox({
            height:120,
            width:250,
            content:{type:'alert', content:'请输入密码，密码不能为空！'},
            animation:0,       //禁止拖拽
            drag:false         //禁止动画
            //autoClose: 10     //自动关闭
        });
        return false;
    }

    if( trim(pass2)=="" ) {
        $.msgbox({
            height:120,
            width:250,
            content:{type:'alert', content:'请输入确认密码，确认密码不能为空！'},
            animation:0,       //禁止拖拽
            drag:false         //禁止动画
            //autoClose: 10     //自动关闭
        });
        return false;
    }

    if (pass1.indexOf(" ") != -1) {
        $.msgbox({
            height:120,
            width:250,
            content:{type:'alert', content:'密码中包括空格，请输入新密码！'},
            animation:0,       //禁止拖拽
            drag:false         //禁止动画
            //autoClose: 10     //自动关闭
        });
        return false;
    }

    if (pass2.indexOf(" ") != -1) {
        $.msgbox({
            height:120,
            width:250,
            content:{type:'alert', content:'确认密码中包括空格，请输入确认密码！'},
            animation:0,       //禁止拖拽
            drag:false         //禁止动画
            //autoClose: 10     //自动关闭
        });
        return false;
    }

    if( pass1.length < 6 ) {
        $.msgbox({
            height:120,
            width:250,
            content:{type:'alert', content:'密码长度至少6个字符！'},
            animation:0,       //禁止拖拽
            drag:false         //禁止动画
            //autoClose: 10     //自动关闭
        });
        return false;
    }

    if( pass1.length != pass2.length ) {
        $.msgbox({
            height:120,
            width:250,
            content:{type:'alert', content:'两次输入的密码长度不一致！'},
            animation:0,       //禁止拖拽
            drag:false         //禁止动画
            //autoClose: 10     //自动关闭
        });
        return false;
    }

    for(i=0;i<pass1.length;i++) {
        if( pass1.charAt(i) != pass2.charAt(i) ) {
            $.msgbox({
                height:120,
                width:250,
                content:{type:'alert', content:'两次输入的密码不一致!'},
                animation:0,       //禁止拖拽
                drag:false         //禁止动画
                //autoClose: 10     //自动关闭
            });
            allValid = false;
            break;
        }
    }

    return allValid;
}

function trim(str)
{
    var i;

    i=0;
    while (i<str.length && str.charAt(i)==' ') i++;
    str=str.substr(i);
    i=str.length-1;
    while (i>=0 && str.charAt(i)==' ') i--;
    str=str.substr(0,i+1);

    return str
}

function ismail(mail) {
    falg = (new RegExp(/^\w+((-\w+)|(\.\w+))*\@[A-Za-z0-9]+((\.|-)[A-Za-z0-9]+)*\.[A-Za-z0-9]+$/).test(mail));
    if (falg) {
        sucess = "sucess";
    }
}

function goSearchPage(linkto,keyword) {
    var page = form.turnPage.value;
    if (keyword!=null && keyword!="")
        window.location.href=linkto + "?currpage=" + page + "&searchcontent=" + keyword;
    else
        window.location.href=linkto + "?currpage=" + page;
}

function Pagination(totalpages,curentpage,keyword,linkto) {
    var PaginationDiv = "";
    if (totalpages <= 1)
        PaginationDiv = "<div class=\"page\" style=\"display: none\">";
    else
        PaginationDiv = "<div class=\"page\" style=\"display: block\">";

    if (curentpage<=1)
        PaginationDiv = PaginationDiv + "<span>第1页</span>";
    else {
        if (keyword!=null && keyword!="")
            PaginationDiv = PaginationDiv + "<a href=\"" + linkto + "?currpage=1&searchcontent=" + keyword + "\">第1页</a>";
        else
            PaginationDiv = PaginationDiv + "<a href=\"" + linkto + "?currpage=1\">第1页</a>";
    }
    PaginationDiv = PaginationDiv + "<span>共" + totalpages + "页</span>";

    if (curentpage<=1)
        PaginationDiv = PaginationDiv + "<span>上一页</span>";
    else {
        if (keyword!=null && keyword!="")
            PaginationDiv = PaginationDiv + "<a href=\"" + linkto + "?currpage=" + (curentpage - 1) + "&searchcontent=" + keyword + "\">上一页</a>";
        else
            PaginationDiv = PaginationDiv + "<a href=\"" + linkto + "?currpage=" + (curentpage - 1) + "\">上一页</a>";
    }
    for(var ii=0;ii<totalpages;ii++) {
        if ((ii + 1) === curentpage)
            PaginationDiv = PaginationDiv + "<span class=\"cur\">" + curentpage + "</span>";
        else {
            if (keyword!=null && keyword!="")
                PaginationDiv = PaginationDiv + "<a href=\"" + linkto + "?currpage=" + (ii + 1) + "&searchcontent=" + keyword + "\">" + (ii + 1) + "</a>";
            else
                PaginationDiv = PaginationDiv + "<a href=\"" + linkto + "?currpage=" + (ii + 1) + "\">" + (ii + 1) + "</a>";
        }
    }
    if (curentpage<totalpages)
        if (keyword!=null && keyword!="")
            PaginationDiv = PaginationDiv + "<a href=\"" + linkto + "?currpage=" + (curentpage+1) + "&searchcontent=" + keyword + "\">下一页</a>";
        else
            PaginationDiv = PaginationDiv + "<a href=\"" + linkto + "?currpage=" + (curentpage+1) + "\">下一页</a>";
    else
        PaginationDiv = PaginationDiv + "<span>下一页</span>";

    PaginationDiv = PaginationDiv + "<span class=\"txtl\">转到第</span>";
    PaginationDiv = PaginationDiv + "<span class=\"select-pager\">";
    PaginationDiv = PaginationDiv + "<form name=\"form\">";
    PaginationDiv = PaginationDiv + "<select name=\"turnPage\" size=\"1\" onchange=\"javascript:goSearchPage('" + linkto + "','" + keyword + "');\">";

    for(var ii=0;ii<totalpages;ii++) {
        if ((ii+1) === curentpage)
            PaginationDiv = PaginationDiv + "<option value=\"" + (ii+1) + "\" selected>" + (ii+1) +  "</option>";
        else
            PaginationDiv = PaginationDiv + "<option value=\"" + (ii+1) + "\">" + (ii+1) + "</option>";
    }

    PaginationDiv = PaginationDiv + "</select>";
    PaginationDiv = PaginationDiv + "</form>";
    PaginationDiv = PaginationDiv + "</span>";
    PaginationDiv = PaginationDiv + "<span class=\"txtr\">页</span>";
    PaginationDiv = PaginationDiv + "</div>";

    //$("#pagesid").html(PaginationDiv);
    document.write(PaginationDiv);
}

function CheckSocialCreditCode(Code) {
    var patrn = /^[0-9A-Z]+$/;
    //18位校验及大写校验
    if ((Code.length != 18) || (patrn.test(Code) == false)) {
        console.info("不是有效的统一社会信用编码！");
        return false;
    }
    else {
        var Ancode;//统一社会信用代码的每一个值
        var Ancodevalue;//统一社会信用代码每一个值的权重
        var total = 0;
        var weightedfactors = [1, 3, 9, 27, 19, 26, 16, 17, 20, 29, 25, 13, 8, 24, 10, 30, 28];//加权因子
        var str = '0123456789ABCDEFGHJKLMNPQRTUWXY';
        //不用I、O、S、V、Z
        for (var i = 0; i < Code.length - 1; i++) {
            Ancode = Code.substring(i, i + 1);
            Ancodevalue = str.indexOf(Ancode);
            total = total + Ancodevalue * weightedfactors[i];
            //权重与加权因子相乘之和
        }
        var logiccheckcode = 31 - total % 31;
        if (logiccheckcode == 31) {
            logiccheckcode = 0;
        }
        var Str = "0,1,2,3,4,5,6,7,8,9,A,B,C,D,E,F,G,H,J,K,L,M,N,P,Q,R,T,U,W,X,Y";
        var Array_Str = Str.split(',');
        logiccheckcode = Array_Str[logiccheckcode];


        var checkcode = Code.substring(17, 18);
        if (logiccheckcode != checkcode) {
            console.info("不是有效的统一社会信用编码！");
            return false;
        }else{
            console.info("yes");
        }
        return true;
    }
}

//函数名：CheckDateTime
//功能介绍：检查是否为日期时间
function CheckDateTime(str){
    var reg = /^(\d+)-(\d{1,2})-(\d{1,2}) (\d{1,2}):(\d{1,2}):(\d{1,2})$/;
    var r = str.match(reg);
    if(r==null)return false;
    r[2]=r[2]-1;
    var d= new Date(r[1], r[2],r[3], r[4],r[5], r[6]);
    if(d.getFullYear()!=r[1])return false;
    if(d.getMonth()!=r[2])return false;
    if(d.getDate()!=r[3])return false;
    if(d.getHours()!=r[4])return false;
    if(d.getMinutes()!=r[5])return false;
    if(d.getSeconds()!=r[6])return false;
    return true;
}

/**
 判断输入框中输入的日期格式为yyyy-mm-dd和正确的日期
 */
function IsDate(mystring) {
    var reg = /^(\d{4})-(\d{2})-(\d{2})$/;
    var str = mystring;
    var arr = reg.exec(str);
    if (str=="") return true;
    if (!reg.test(str)&&RegExp.$2<=12&&RegExp.$3<=31){
        return false;
    }
    return true;
}

//输出为YYYYMMDD的格式
function toDateFromString( strDate ) {
    if (strDate.length != 8) {
        return null ;
    }
    var dtDate = null ;
    var nYear = parseInt( strDate.substring( 0, 4 ), 10 ) ;
    var nMonth = parseInt( strDate.substring( 4, 6 ), 10 ) ;
    var nDay = parseInt( strDate.substring( 6, 8 ), 10 ) ;
    if( isNaN( nYear ) == true || isNaN( nMonth ) == true || isNaN( nDay ) == true )
    {
        return null ;
    }
    dtDate = new Date( nYear, nMonth - 1, nDay ) ;
    if( nYear != dtDate.getFullYear() || ( nMonth - 1 ) != dtDate.getMonth() || nDay != dtDate.getDate() )
    {
        return null ;
    }
    return dtDate ;
}

function inpEndDateFlag() {
    var flagval = $("#longtimeflag").val();
    if(flagval == 2)
        $("#endDate").attr("disabled","disabled");
    else
        $("#endDate").removeAttr("disabled");
}

//检查手机号是否满足手机号规则
function checkMPhone(mphone){
    if(!(/^1(3|4|5|6|7|8|9)\d{9}$/.test(mphone))){
        return false;
    } else {
        return true;
    }
}

//检查电话号码是否满足电话号码规则
function checkTel(tel){
    if(!/^(\(\d{3,4}\)|\d{3,4}-|\s)?\d{7,14}$/.test(tel)){
        return false;
    } else {
        return true;
    }
}

//检查身份证是否满足规则
function checkIDCARD(idcard){
    if(!/^[1-9]\d{5}[1-9]\d{3}((0\d)|(1[0-2]))(([0|1|2]\d)|3[0-1])\d{4}$/.test(idcard)){
        return false;
    } else {
        return true;
    }
}

//身份证号合法性验证
//支持15位和18位身份证号
//支持地址编码、出生日期、校验位验证
function IdCodeValid(code){
    var city={11:"北京",12:"天津",13:"河北",14:"山西",15:"内蒙古",21:"辽宁",22:"吉林",23:"黑龙江 ",31:"上海",32:"江苏",33:"浙江",34:"安徽",35:"福建",36:"江西",37:"山东",41:"河南",42:"湖北 ",43:"湖南",44:"广东",45:"广西",46:"海南",50:"重庆",51:"四川",52:"贵州",53:"云南",54:"西藏 ",61:"陕西",62:"甘肃",63:"青海",64:"宁夏",65:"新疆",71:"台湾",81:"香港",82:"澳门",91:"国外 "};
    var row={
        'pass':true,
        'msg':'验证成功'
    };

    if(!code || !/^\d{6}(18|19|20)?\d{2}(0[1-9]|1[012])(0[1-9]|[12]\d|3[01])\d{3}(\d|[xX])$/.test(code)){
        row={
            'pass':false,
            'msg':'身份证号格式错误'
        };
    }else if(!city[code.substr(0,2)]){
        row={
            'pass':false,
            'msg':'身份证号地址编码错误'
        };
    }else{
        //18位身份证需要验证最后一位校验位
        if(code.length == 18){
            code = code.split('');
            //∑(ai×Wi)(mod 11)
            //加权因子
            var factor = [ 7, 9, 10, 5, 8, 4, 2, 1, 6, 3, 7, 9, 10, 5, 8, 4, 2 ];
            //校验位
            var parity = [ 1, 0, 'X', 9, 8, 7, 6, 5, 4, 3, 2 ];
            var sum = 0;
            var ai = 0;
            var wi = 0;
            for (var i = 0; i < 17; i++)
            {
                ai = code[i];
                wi = factor[i];
                sum += ai * wi;
            }
            if(parity[sum % 11] != code[17].toUpperCase()){
                row={
                    'pass':false,
                    'msg':'身份证号校验位错误'
                };
            }
        }
    }
    return row;
}

function checkFileExt(filename) {
    var flag = false; //状态
    var arr = ["jpg","jpeg","png","gif","doc","docx","ppt","pptx","pdf","xls","xlsx","JPG","JPEG","PNG","GIF","DOC","DOCX","PPT","PPTX","PDF","XLS","XLSX"];
    //取出上传文件的扩展名
    var index = filename.lastIndexOf(".");
    var ext = filename.substr(index+1);
    //循环比较
    for(var i=0;i<arr.length;i++) {
        if(ext == arr[i]) {
            flag = true; //一旦找到合适的，立即退出循环
            break;
        }
    }

    return flag;
}

function submitUpdatePersonInfo(form) {
    var idcard = form.idcard.value;
    var mphone = form.mphone.value;
    var phone = form.phone.value;
    var email = form.email.value;

    if (idcard==null || idcard=="" || idcard=='' || typeof idcard == "undefined") {
        $.msgbox({
            height:120,
            width:300,
            content:{type:'alert', content:'用户身份证号码不能为空'},
            animation:0,        //禁止拖拽
            drag:false          //禁止动画
            //autoClose: 10       //自动关闭
        });
        return false;
    } else {
        var result = IdCodeValid(idcard);
        if (result.pass == false) {
            $.msgbox({
                height:120,
                width:300,
                content:{type:'alert', content:'用户身份证号码格式错误，请填写正确的身份证号码'},
                animation:0,        //禁止拖拽
                drag:false          //禁止动画
                //autoClose: 10       //自动关闭
            });
            return false;
        }
    }

    if (mphone==null || mphone=="" || mphone=='' || typeof mphone == "undefined") {
        $.msgbox({
            height:120,
            width:300,
            content:{type:'alert', content:'用户手机号码不能为空'},
            animation:0,        //禁止拖拽
            drag:false          //禁止动画
            //autoClose: 10       //自动关闭
        });
        return false;
    } else {
        if (checkMPhone(mphone) == false) {
            $.msgbox({
                height:120,
                width:300,
                content:{type:'alert', content:'用户手机号码格式错误，请填写正确的手机号码'},
                animation:0,        //禁止拖拽
                drag:false          //禁止动画
                //autoClose: 10       //自动关闭
            });
            return false;
        }
    }

    if (phone==null || phone=="" || phone=='' || typeof phone == "undefined") {
        $.msgbox({
            height:120,
            width:300,
            content:{type:'alert', content:'用户座机电话号码不能为空'},
            animation:0,        //禁止拖拽
            drag:false          //禁止动画
            //autoClose: 10       //自动关闭
        });
        return false;
    } else {
        if (checkTel(phone) == false) {
            $.msgbox({
                height:120,
                width:300,
                content:{type:'alert', content:'用户座机电话号码格式错误，请填写正确的座机电话号码'},
                animation:0,        //禁止拖拽
                drag:false          //禁止动画
                //autoClose: 10       //自动关闭
            });
            return false;
        }
    }

    if (email==null || email=="" || email=='' || typeof email == "undefined") {
        $.msgbox({
            height:120,
            width:300,
            content:{type:'alert', content:'用户电子邮件地址不能为空'},
            animation:0,        //禁止拖拽
            drag:false          //禁止动画
            //autoClose: 10       //自动关闭
        });
        return false;
    } else {
        if (ismail(email) == "") {
            $.msgbox({
                height:120,
                width:250,
                content:{type:'alert', content:'邮箱地址格式错误，请填写正确邮件地址'},
                animation:0,        //禁止拖拽
                drag:false          //禁止动画
                //autoClose: 10       //自动关闭
            });
            return false;
        }
    }

    var yzcode = form.yzcode.value;
    if (yzcode == "") {
        $.msgbox({
            height:120,
            width:250,
            content:{type:'alert', content:'验证码不能为空，请输入验证码'},
            animation:0,        //禁止拖拽
            drag:false          //禁止动画
            //autoClose: 10       //自动关闭
        });
        return false;
    }

    if (yzcode.length != 4) {
        $.msgbox({
            height:120,
            width:250,
            content:{type:'alert', content:'验证码输入不正确'},
            animation:0,        //禁止拖拽
            drag:false          //禁止动画
            //autoClose: 10       //自动关闭
        });
        return false;
    }

    var unit = form.unit.value;
    var title = form.title.value;
    var sex = $("input[name='sex']:checked").val();
    var idcardpic_frontfile = form.idcardpic_frontfile.value;
    var idcardpic_backfile = form.idcardpic_backfile.value;
    var native = form.native.value;

    if (unit== null) unit = "";
    if (title== null) title = "";
    if (sex== null) sex = "";
    if (idcardpic_frontfile== null) idcardpic_frontfile = "";
    if (idcardpic_backfile== null) idcardpic_backfile = "";
    if (native== null) native = "";

    var messages = "idcard=" + idcard + "&mphone=" + mphone + "&phone=" + phone  + "&email=" + email + "&unit=" + unit + "&title=" + title +
        "&sex=" + sex + "&idcardpic_frontfile=" + idcardpic_frontfile + "&idcardpic_backfile=" + idcardpic_backfile + "&nation=" + native + "&yzcode=" + yzcode;

    form.checkval.value=hex_md5(messages);

    return true;
}

//form:表示提交检查的FORM对象
//actionflag:registe表示注册新用户，update表示修改注册信息
function checkvalid(form,actionflag) {
    var name = "";
    var pass = "";
    if (actionflag=="registe") {
        name = form.username.value;
        pass = form.pwdname.value;
    }
    var email = form.email.value;
    var yzcode = form.yzcode.value;


    if (actionflag=="registe") {
        if (name == "") {
            $.msgbox({
                height: 120,
                width: 300,
                content: {type: 'alert', content: '用户名不能为空'},
                animation: 0,        //禁止拖拽
                drag: false          //禁止动画
                //autoClose: 10       //自动关闭
            });
            return false;
        }

        if (name.getBytes() < 4) {
            $.msgbox({
                height: 120,
                width: 250,
                content: {type: 'alert', content: '用户名长度必须4位字母或2个汉字以上,字母或汉字开头'},
                animation: 0,        //禁止拖拽
                drag: false          //禁止动画
                //autoClose: 10       //自动关闭
            });
            return false;
        }

        var reg = /[^\u4e00-\u9fa5A-Za-z0-9]/g;
        if (reg.test(name)) {
            //alert("用户名格式不正确");
            $.msgbox({
                height: 120,
                width: 250,
                content: {type: 'alert', content: '用户名格式不正确，用户名只能包括含字母、数字和汉字'},
                animation: 0,       //禁止拖拽
                drag: false         //禁止动画
                //autoClose: 10     //自动关闭
            });
            return false;
        }

        var reg = /^[\u4e00-\u9fa5A-Za-z]{1,1}$/;
        if (reg.test(name)) {
            $.msgbox({
                height: 120,
                width: 250,
                content: {type: 'alert', content: '用户名格式不正确，用户名必须以字母或者汉字开头'},
                animation: 0,       //禁止拖拽
                drag: false         //禁止动画
                //autoClose: 10     //自动关闭
            });
            return false;
        }

        //检查用户名称是否存在
        var existflag = 0;
        htmlobj = $.ajax({
            url: "checkname.jsp",
            type: 'post',
            dataType: 'json',
            data: {
                username: encodeURI(name)
            },
            async: false,
            cache: false,
            success: function (data) {
                if (data.result) {
                    existflag = 1;
                }
            }
        });

        if (existflag == 1) {
            //alert("电子邮件地址已经被注册过，请更换电子邮件地址！");
            $.msgbox({
                height: 120,
                width: 300,
                content: {type: 'alert', content: '用户名称已经被注册过，请更换用户名称！'},
                animation: 0,        //禁止拖拽
                drag: false          //禁止动画
                //autoClose: 10       //自动关闭
            });
            return false;
        }

        if (pass == "") {
            $.msgbox({
                height: 120,
                width: 300,
                content: {type: 'alert', content: '密码不能为空，请填写密码'},
                animation: 0,        //禁止拖拽
                drag: false          //禁止动画
                //autoClose: 10       //自动关闭
            });
            return false;
        }

        if (pass.length < 6) {
            $.msgbox({
                height: 120,
                width: 300,
                content: {type: 'alert', content: '密码长度必须大于6位'},
                animation: 0,        //禁止拖拽
                drag: false          //禁止动画
                //autoClose: 10       //自动关闭
            });
            return false;
        }

        /*if (pass != confpass) {
            $.msgbox({
                height:120,
                width:250,
                content:{type:'alert', content:'两次填写的密码不一致'},
                animation:0,        //禁止拖拽
                drag:false          //禁止动画
                //autoClose: 10       //自动关闭
            });
            return false;
        }*/
    }

    var suppname = form.suppliername.value;
    if (suppname == "" || suppname == null) {
        $.msgbox({
            height:120,
            width:300,
            content:{type:'alert', content:'供应商名称不能为空，请填写供应商全称'},
            animation:0,        //禁止拖拽
            drag:false          //禁止动画
            //autoClose: 10       //自动关闭
        });
        return false;
    }

    var suppcode = form.supplierCode.value;
    if (suppcode == "" || suppcode == null) {
        $.msgbox({
            height:120,
            width:300,
            content:{type:'alert', content:'供应商统一社会信用代码不能为空，请按营业执照填写统一社会信用代码'},
            animation:0,        //禁止拖拽
            drag:false          //禁止动画
            //autoClose: 10       //自动关闭
        });
        return false;
    } else{
        var checkresult = CheckSocialCreditCode(suppcode);
        if (checkresult == false) {
            $.msgbox({
                height: 120,
                width: 300,
                content: {type: 'alert', content: '供应商统一社会信用代码不符合规则，请按营业执照填写统一社会信用代码'},
                animation: 0,        //禁止拖拽
                drag: false          //禁止动画
                //autoClose: 10       //自动关闭
            });
            return false;
        }
    }

    var lawPersonName = form.lawPersonName.value;
    if (lawPersonName == "" || lawPersonName == null) {
        $.msgbox({
            height:120,
            width:300,
            content:{type:'alert', content:'供应商法人代表名称不能为空，请按营业执照填写法人代表名称'},
            animation:0,        //禁止拖拽
            drag:false          //禁止动画
            //autoClose: 10       //自动关闭
        });
        return false;
    } else {
        var reg = /^[\u4e00-\u9fa5A-Za-z]{1,1}$/;
        if (reg.test(name)) {
            $.msgbox({
                height:120,
                width:300,
                content:{type:'alert', content:'供应商法人代表名称格式不正确，请按营业执照填写法人代表名称'},
                animation:0,       //禁止拖拽
                drag:false         //禁止动画
                //autoClose: 10     //自动关闭
            });
            return false;
        }
    }

    var beginDate = form.beginDate.value;
    if (beginDate == "" || beginDate == null) {
        $.msgbox({
            height:120,
            width:300,
            content:{type:'alert', content:'营业开始日期不能为空，请按营业执照填写营业开始日期'},
            animation:0,        //禁止拖拽
            drag:false          //禁止动画
            //autoClose: 10       //自动关闭
        });
        return false;
    } else {
        if (IsDate(beginDate)==false) {
            $.msgbox({
                height:120,
                width:300,
                content:{type:'alert', content:'营业开始日期格式不正确，请按营业执照填写营业开始日期'},
                animation:0,       //禁止拖拽
                drag:false         //禁止动画
                //autoClose: 10     //自动关闭
            });
            return false;
        }
    }

    var registerDate = form.registerDate.value;
    if (registerDate == "" || registerDate == null) {
        $.msgbox({
            height:120,
            width:300,
            content:{type:'alert', content:'成立日期不能为空，请按营业执照填写成立日期'},
            animation:0,        //禁止拖拽
            drag:false          //禁止动画
            //autoClose: 10       //自动关闭
        });
        return false;
    } else {
        if (IsDate(registerDate)==false) {
            $.msgbox({
                height:120,
                width:300,
                content:{type:'alert', content:'成立日期格式不正确，请按营业执照填写成立日期'},
                animation:0,       //禁止拖拽
                drag:false         //禁止动画
                //autoClose: 10     //自动关闭
            });
            return false;
        }
    }

    var registeredCapital = form.registeredCapital.value;
    if (registeredCapital == "" || registeredCapital == null) {
        $.msgbox({
            height:120,
            width:300,
            content:{type:'alert', content:'注册资本不能为空，请按营业执照填写注册资本'},
            animation:0,        //禁止拖拽
            drag:false          //禁止动画
            //autoClose: 10       //自动关闭
        });
        return false;
    } else {
        if(!(/^\d+(\.\d{1,2})?$/.test(registeredCapital) || /^\d$/.test(registeredCapital))){
            $.msgbox({
                height:120,
                width:300,
                content:{type:'alert', content:'注册资本格式不正确，请按营业执照填写注册资本'},
                animation:0,       //禁止拖拽
                drag:false         //禁止动画
                //autoClose: 10     //自动关闭
            });
            return false;
        }
    }

    var registrationAuthority = form.registrationAuthority.value;
    if (registrationAuthority == "" || registrationAuthority == null) {
        $.msgbox({
            height:120,
            width:300,
            content:{type:'alert', content:'登记机关不能为空，请按营业执照填写登记机关'},
            animation:0,        //禁止拖拽
            drag:false          //禁止动画
            //autoClose: 10       //自动关闭
        });
        return false;
    }

    var registrationDate = form.registrationDate.value;
    if (registrationDate == "" || registrationDate == null) {
        $.msgbox({
            height:120,
            width:300,
            content:{type:'alert', content:'登记日期不能为空，请按营业执照填写登记日期'},
            animation:0,        //禁止拖拽
            drag:false          //禁止动画
            //autoClose: 10       //自动关闭
        });
        return false;
    } else {
        if (IsDate(registrationDate)==false) {
            $.msgbox({
                height:120,
                width:300,
                content:{type:'alert', content:'登记日期格式不正确，请按营业执照填写登记日期'},
                animation:0,       //禁止拖拽
                drag:false         //禁止动画
                //autoClose: 10     //自动关闭
            });
            return false;
        }
    }

    var contactorname = form.contactorname.value;
    if (contactorname == "" || contactorname == null) {
        $.msgbox({
            height:120,
            width:300,
            content:{type:'alert', content:'联系人姓名不能为空'},
            animation:0,        //禁止拖拽
            drag:false          //禁止动画
            //autoClose: 10       //自动关闭
        });
        return false;
    }

    var contactormphone = form.contactormphone.value;
    if (contactormphone == "" || contactormphone == null) {
        $.msgbox({
            height:120,
            width:300,
            content:{type:'alert', content:'联系人手机号码不能为空'},
            animation:0,        //禁止拖拽
            drag:false          //禁止动画
            //autoClose: 10       //自动关闭
        });
        return false;
    } else {
        if (checkMPhone(contactormphone)==false) {
            $.msgbox({
                height:120,
                width:300,
                content:{type:'alert', content:'联系人手机号码格式不正确，请填写正确的手机号码'},
                animation:0,       //禁止拖拽
                drag:false         //禁止动画
                //autoClose: 10     //自动关闭
            });
            return false;
        }
    }

    if(actionflag=="registe") {
        //检查联系人手机号码是否存在
        existflag = 0;
        htmlobj = $.ajax({
            url: "checkcellphone.jsp",
            type: 'post',
            dataType: 'json',
            data: {
                mphone: encodeURI(contactormphone)
            },
            async: false,
            cache: false,
            success: function (data) {
                if (data.result) {
                    existflag = 1;
                }
            }
        });

        if (existflag == 1) {
            //alert("联系人手机号已经被注册过，请更换联系人手机号！");
            $.msgbox({
                height: 120,
                width: 300,
                content: {type: 'alert', content: '联系人手机号已经被注册过，请更换联系人手机号码！'},
                animation: 0,        //禁止拖拽
                drag: false          //禁止动画
                //autoClose: 10       //自动关闭
            });
            return false;
        }
    }

    var contactorphone = form.contactorphone.value;
    if (contactorphone == "" || contactorphone == null) {
        $.msgbox({
            height:120,
            width:300,
            content:{type:'alert', content:'联系人办公电话不能为空'},
            animation:0,        //禁止拖拽
            drag:false          //禁止动画
            //autoClose: 10       //自动关闭
        });
        return false;
    } else {
        if (checkTel(contactorphone)==false) {
            $.msgbox({
                height:120,
                width:300,
                content:{type:'alert', content:'联系人办公电话格式不正确，请填写座机电话的正确格式'},
                animation:0,       //禁止拖拽
                drag:false         //禁止动画
                //autoClose: 10     //自动关闭
            });
            return false;
        }
    }


    if (email == "" || email == null) {
        $.msgbox({
            height:120,
            width:300,
            content:{type:'alert', content:'邮箱不能为空，请填写正确邮件地址'},
            animation:0,        //禁止拖拽
            drag:false          //禁止动画
            //autoClose: 10       //自动关闭
        });
        return false;
    } else {
        if (actionflag=="registe") {
            //检查电子邮件地址是否存在
            var existflag = 0;

            htmlobj = $.ajax({
                url: "checkemail.jsp",
                type: 'post',
                dataType: 'text',
                data: {
                    email: encodeURI(email)
                },
                async: false,
                cache: false,
                success: function (data) {
                    if (data.indexOf("true") > -1) {
                        existflag = 1;
                    }
                }
            });

            if (existflag == 1) {
                //alert("电子邮件地址已经被注册过，请更换电子邮件地址！");
                $.msgbox({
                    height: 120,
                    width: 300,
                    content: {type: 'alert', content: '电子邮件地址已经被注册过，请更换电子邮件地址！'},
                    animation: 0,        //禁止拖拽
                    drag: false          //禁止动画
                    //autoClose: 10       //自动关闭
                });
                return false;
            }
        }
    }

    ismail(email);

    if (sucess == "") {
        $.msgbox({
            height:120,
            width:250,
            content:{type:'alert', content:'邮箱地址格式错误，请填写正确邮件地址'},
            animation:0,        //禁止拖拽
            drag:false          //禁止动画
            //autoClose: 10       //自动关闭
        });
        return false;
    }


    //var fromway = "";
    //$("input:checkbox[name='fromway']:checked").each(function() {
    //    fromway = fromway + $(this).val() + " ";
    //});

    //var usertype = $("input[name='usertype']:checked").val();

    if (yzcode == "") {
        $.msgbox({
            height:120,
            width:250,
            content:{type:'alert', content:'验证码不能为空，请输入验证码'},
            animation:0,        //禁止拖拽
            drag:false          //禁止动画
            //autoClose: 10       //自动关闭
        });
        return false;
    }

    if (yzcode.length != 4) {
        $.msgbox({
            height:120,
            width:250,
            content:{type:'alert', content:'验证码输入不正确'},
            animation:0,        //禁止拖拽
            drag:false          //禁止动画
            //autoClose: 10       //自动关闭
        });
        return false;
    }

    var lawPersonIdcard = form.Idcard.value;
    if (lawPersonIdcard == null || (typeof lawPersonIdcard == "undefined") || lawPersonIdcard == "")
        lawPersonIdcard = "";
    else {
        if (checkIDCARD(lawPersonIdcard) == false) {
            $.msgbox({
                height:120,
                width:250,
                content:{type:'alert', content:'法人身份证号码输入不正确'},
                animation:0,        //禁止拖拽
                drag:false          //禁止动画
                //autoClose: 10       //自动关闭
            });
            return false;
        }
    }
    var lawPersonTel = form.lawPersonTel.value;
    if (lawPersonTel == null || (typeof lawPersonTel == "undefined") || lawPersonTel == "")
        lawPersonTel = "";
    else {
        if(checkTel(lawPersonTel) == false) {
            $.msgbox({
                height:120,
                width:250,
                content:{type:'alert', content:'法人代表联系电话号码输入不正确'},
                animation:0,        //禁止拖拽
                drag:false          //禁止动画
                //autoClose: 10       //自动关闭
            });
            return false;
        }
    }

    var uuid = "";
    if (actionflag=="update") uuid = form.uuid.value;
    var supplierType = form.supplierType.value;
    var suppOrgType = form.suppOrgType.value;
    var comprole = form.suppRole.value;
    var longtimeflag = form.longtimeflag.value;
    var edate = form.edate.value;
    if (edate == null || (typeof edate == "undefined")) edate = "";
    var regaddress = form.regaddress.value;
    if (regaddress == null || (typeof regaddress == "undefined")) regaddress = "";
    var bankname = form.bankname.value;
    if (bankname == null || (typeof bankname == "undefined")) bankname = "";
    var BaseAccountName = form.BaseAccountName.value;
    if (BaseAccountName == null || (typeof BaseAccountName == "undefined")) BaseAccountName = "";
    var baseAccount = form.baseAccount.value;
    if (baseAccount == null || (typeof baseAccount == "undefined")) baseAccount = "";
    var weburl = form.weburl.value;
    if (weburl == null || (typeof weburl == "undefined")) weburl = "";
    var businessBrief = form.businessBrief.value;
    if (businessBrief == null || (typeof businessBrief == "undefined")) businessBrief = "";
    var provname = form.provname.value;
    if (provname == null || (typeof provname == "undefined")) provname = "";
    var cityname = form.cityname.value;
    if (cityname == null || (typeof cityname == "undefined")) cityname = "";
    var areaname = form.areaname.value;
    if (areaname == null || (typeof areaname == "undefined")) areaname = "";
    var zipcode = form.zipcode.value;
    if (zipcode == null || (typeof zipcode == "undefined")) zipcode = "";
    var operationAddress = form.operationAddress.value;
    if (operationAddress == null || (typeof operationAddress == "undefined")) operationAddress = "";
    var faxnum = form.faxnum.value;
    if (faxnum == null || (typeof faxnum == "undefined")) faxnum = "";



    var messages = "";
    if(actionflag=="registe")
        messages = "username=" + name + "&pwdname=" + pass + "&suppliername=" + suppname  + "&supplierCode=" + suppcode + "&lawPersonName=" + lawPersonName + "&lawPersonTel=" + lawPersonTel +
            "&supplierType=" + supplierType + "&suppOrgType=" + suppOrgType + "&comprole=" + comprole + "&regDate=" + registerDate + "&longtimeflag=" + longtimeflag + "&sdate=" + beginDate + "&edate=" + edate + "&regaddress=" + regaddress +
            "&regCapital=" + registeredCapital + "&bankname=" + bankname + "&BaseAccountName=" + BaseAccountName + "&baseAccount=" + baseAccount + "&weburl=" + weburl + "&businessBrief=" + businessBrief +
            "&regAuthName=" + registrationAuthority + "&checkInDate=" + registrationDate + "&provname=" + provname + "&cityname=" + cityname + "&areaname=" + areaname + "&zipcode=" + zipcode + "&operationAddress=" + operationAddress +
            "&contactorname=" + contactorname + "&contactormphone=" + contactormphone + "&contactorphone=" + contactorphone + "&email=" + email + "&faxnum=" + faxnum + "&yzcode=" + yzcode + "&Idcard=" + lawPersonIdcard;
    else
        messages = "uuid=" + uuid + "&suppliername=" + suppname  + "&supplierCode=" + suppcode + "&lawPersonName=" + lawPersonName + "&lawPersonTel=" + lawPersonTel +
            "&supplierType=" + supplierType + "&suppOrgType=" + suppOrgType + "&comprole=" + comprole + "&regDate=" + registerDate + "&longtimeflag=" + longtimeflag + "&sdate=" + beginDate + "&edate=" + edate + "&regaddress=" + regaddress +
            "&regCapital=" + registeredCapital + "&bankname=" + bankname + "&BaseAccountName=" + BaseAccountName + "&baseAccount=" + baseAccount + "&weburl=" + weburl + "&businessBrief=" + businessBrief +
            "&regAuthName=" + registrationAuthority + "&checkInDate=" + registrationDate + "&provname=" + provname + "&cityname=" + cityname + "&areaname=" + areaname + "&zipcode=" + zipcode + "&operationAddress=" + operationAddress +
            "&contactorname=" + contactorname + "&contactormphone=" + contactormphone + "&contactorphone=" + contactorphone + "&email=" + email + "&faxnum=" + faxnum + "&yzcode=" + yzcode + "&Idcard=" + lawPersonIdcard;


    form.checkval.value=hex_md5(messages);
    //alert(messages);
    //form.checkval.value = messages;

    //var agreement = "";
    // $("input:checkbox[name='agreement']:checked").each(function() {
    // agreement = $(this).val();
    // });

    // if (agreement=="") {
    // alert("请阅读协议，并勾选我已看过并同意条款才能通过");
    // return false;
    // }

    return true;
}

function uploadFile() {
    var iWidth=600;                                                 //弹出窗口的宽度;
    var iHeight=400;                                                //弹出窗口的高度;
    var iTop = (window.screen.availHeight-30-iHeight)/2;           //获得窗口的垂直位置;
    var iLeft = (window.screen.availWidth-10-iWidth)/2;            //获得窗口的水平位置;
    window.open("../upload/uploadfile.jsp", "uplodwin", "width=" + iWidth + ",height=" + iHeight + ",left=" + iLeft + ",top=" + iTop + ",status,scrollbars");
}

function showDate(){
    var mydate = new Date();
    var str = "" + mydate.getFullYear() + "年";
    str += (mydate.getMonth()+1) + "月";
    str += mydate.getDate() + "日";
    var today = new Array('星期日','星期一','星期二','星期三','星期四','星期五','星期六');
    var week = today[mydate.getDay()];
    $("#current_dateid").html("hello word");
}
