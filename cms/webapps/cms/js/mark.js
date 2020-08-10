function createStyle(type, columnID) {
    var winstrs = "";

    if (type == 1 || type == 3 || type == 4) {        //1文章列表样式
        winstrs = "../template1/editStyle.jsp?column=" + columnID + "&type=" + type;
        listwin = window.open(winstrs, "createStyle", "font-family:Verdana;font-size:12;dialogWidth:40px;dialogHeight:30px;status:no");
        listwin.focus();
    } else if (type == 6) {         //栏目文章列表样式
        winstrs = "../template1/editColumnStyleRight.jsp?type=" + type;
        wins = window.open(winstrs, "createStyle", "font-family:Verdana;font-size:12;dialogWidth:500px;dialogHeight:420px;status:no");
        wins.focus();
    } else {                      //5被读文章列表样式，2导航条列表样式 7新文章列表样式
        winstrs = "../template1/editOtherStyle.jsp?type=" + type;
        artwin = window.open(winstrs, "createStyle", "font-family:Verdana;font-size:12;dialogWidth:560px;dialogHeight:390px;status:no");
        artwin.focus();
    }
}

function  addNewOption(type,cname,newID) {
    if (type==1 || type==3 || type==4 || type == 8 || type == 6) {                 //1文章列表中的列表样式  6栏目列表样式 8中文路径样式
        var objSelect = document.getElementById("listType");
        var option = new Option(cname, newID);
        objSelect.add(option);
        objSelect.options[objSelect.length - 1].selected = true;
    } else if (type==5){
        var objSelect = document.getElementById("sellink");                     //文章列表中被读标题样式
        var option = new Option(cname, newID);
        objSelect.add(option);
        objSelect.options[objSelect.length - 1].selected = true;
    } else if (type==7) {                                                         //文章列表中新文章样式
        var objSelect = document.getElementById("seldays");
        var option = new Option(cname, newID);
        objSelect.add(option);
        objSelect.options[objSelect.length - 1].selected = true;
    } else if (type == 2) {                                                       //分页导航样式
        var objSelect = document.getElementById("navbar");
        var option = new Option(cname, newID);
        objSelect.add(option);
        objSelect.options[objSelect.length - 1].selected = true;
    } else if (type == 10) {
        var objSelect = document.getElementById("nextarticle");
        var option = new Option(cname, newID);
        objSelect.add(option);
        objSelect.options[objSelect.length - 1].selected = true;
    }
}

function updateStyle(type, styleID, columnID)
{
    if (styleID > 0)
    {
        if (type == 1 || type == 3 || type == 4) {
            wins = window.open("../template1/editStyle.jsp?column=" + columnID + "&ID=" + styleID + "&type=" + type, "updateStyle", "font-family:Verdana;font-size:12;dialogWidth:560px;dialogHeight:390px;status:no");
            wins.focus();
        } else if (type == 6) {
            wins = window.open("../template1/editColumnStyle.jsp?ID=" + styleID + "&type=" + type, "updateStyle", "font-family:Verdana;font-size:12;dialogWidth:560px;dialogHeight:390px;status:no");
            wins.focus();
        } else {
            wins = window.open("../template1/editOtherStyle.jsp?column=" + columnID + "&type=" + type + "&ID=" + styleID, "updateStyle", "font-family:Verdana;font-size:12;dialogWidth:560px;dialogHeight:390px;status:no");
            wins.focus();
        }
    }
}

function  updateStyleOption(type,cname,styleID) {
    if (type==1 || type==3 || type==4 || type == 8 || type == 6) {                 //1文章列表中的列表样式  6栏目列表样式 8中文路径样式
        $("#listType option[selected]").text=cname;
        $("#listType option[selected]").value=styleID;
    } else if (type==5){
        $("#sellink option[selected]").text=cname;
        $("#sellink option[selected]").value=styleID;
    } else if (type==7) {                                                         //文章列表中新文章样式
        $("#seldays option[selected]").text=cname;
        $("#seldays option[selected]").value=styleID;
    } else if (type == 2) {                                                       //分页导航样式
        $("#navbar option[selected]").text=cname;
        $("#navbar option[selected]").value=styleID;
    } else if (type == 10) {
        $("#nextarticle option[selected]").text=cname;
        $("#nextarticle option[selected]").value=styleID;
    }
}

function previewStyle(type, styleID)
{
    if (styleID > 0) {
        wins = window.open("../template1/getviewfile.jsp?id=" + styleID + "&type=" + type, "updateStyle", "font-family:Verdana;font-size:12;dialogWidth:560px;dialogHeight:390px;status:no");
        wins.focus();
    }
}

/*function selectStyle(styleID)
 {
 if (styleID > 0)
 document.all("title").value = "[TITLESTYLE]" + styleID + "[/TITLESTYLE]";
 }*/

function selectArticleList()
{
    if (markForm.selectArtList[0].checked)
    {
        markForm.artNum.disabled = 0;
        markForm.startArtNum.disabled = 0;
        markForm.endArtNum.disabled = 0;
        markForm.articleNumInPage.disabled = 1;
        markForm.navbar.disabled = 1;
        markForm.navPosition[0].disabled = 1;
        markForm.navPosition[1].disabled = 1;
        markForm.button1.disabled = 0;
        markForm.button2.disabled = 0;
        markForm.button3.disabled = 0;
        markForm.button4.disabled = 1;
        markForm.button5.disabled = 1;
        markForm.button6.disabled = 1;
        markForm.sellink.disabled = 0;
        markForm.innerFlag[0].disabled = 0;
        markForm.innerFlag[1].disabled = 0;
    }
    if (markForm.selectArtList[1].checked)
    {
        markForm.artNum.disabled = 1;
        markForm.startArtNum.disabled = 1;
        markForm.endArtNum.disabled = 1;
        markForm.articleNumInPage.disabled = 0;
        markForm.navPosition[0].disabled = 0;
        markForm.navPosition[1].disabled = 0;
        markForm.button1.disabled = 1;
        markForm.button2.disabled = 1;
        markForm.button3.disabled = 1;
        markForm.sellink.disabled = 1;
        markForm.innerFlag[0].checked = 1;
        markForm.innerFlag[0].disabled = 1;
        markForm.innerFlag[1].disabled = 1;
        markForm.navbar.disabled = 0;
        markForm.button4.disabled = 0;
        markForm.button5.disabled = 0;
        markForm.button6.disabled = 0;
        markForm.navPosition[0].checked = 1;
    }
}

function selectZhuceList(){
    if (markform.radio[0].checked){
        markform.select1.disabled = true;
        markform.select0.disabled = false;
        markform.select2.disabled = true;
        markform.select3.disabled = true;
        markform.select4.disabled = true;
        markform.select5.disabled = true;
        markform.select6.disabled = true;
        markform.select7.disabled = true;
        markform.select8.disabled = true;
        markform.select9.disabled = true;
        markform.select10.disabled = true;
        markform.select11.disabled = true;
        markform.select12.disabled = true;
        markform.select13.disabled = true;
        markform.select14.disabled = true;
        markform.select15.disabled = true;
        markform.select16.disabled = true;
        markform.select17.disabled = true;
        markform.select18.disabled = true;
        markform.select19.disabled = true;
        markform.select20.disabled = true;
        markform.select21.disabled = true;
        markform.select22.disabled = true;
        markform.select23.disabled = true;
        markform.select24.disabled = true;
        markform.select25.disabled = true;
        markform.select26.disabled = true;
        markform.select27.disabled = true;
        markform.select28.disabled = true;
        markform.select29.disabled = true;

    }
    if (markform.radio[1].checked){
        markform.select1.disabled = false;
        markform.select0.disabled = true;
        markform.select2.disabled = false;
        markform.select3.disabled = false;
        markform.select4.disabled = false;
        markform.select5.disabled = false;
        markform.select6.disabled = false;
        markform.select7.disabled = false;
        markform.select8.disabled = false;
        markform.select9.disabled = false;
        markform.select10.disabled = false;
        markform.select11.disabled = false;
        markform.select12.disabled = false;
        markform.select13.disabled = false;
        markform.select14.disabled = false;
        markform.select15.disabled = false;
        markform.select16.disabled = false;
        markform.select17.disabled = false;
        markform.select18.disabled = false;
        markform.select19.disabled = false;
        markform.select20.disabled = false;
        markform.select21.disabled = false;
        markform.select22.disabled = false;
        markform.select23.disabled = false;
        markform.select24.disabled = false;
        markform.select25.disabled = false;
        markform.select26.disabled = false;
        markform.select27.disabled = false;
        markform.select28.disabled = false;
        markform.select29.disabled = false;
    }
}

function openchakan0(){
    var i = document.getElementById("select0").value;
    showModalDialog("editchakan.jsp?i="+i,window, "font-family:Verdana; font-size:12; dialogWidth:80em; dialogHeight:10em;status:no");
}
function openchakan1(){
    var i = document.getElementById("select1").value;
    showModalDialog("editchakan.jsp?i="+i,window, "font-family:Verdana; font-size:12; dialogWidth:80em; dialogHeight:10em;status:no");
}
function openchakan2(){
    var i = document.getElementById("select2").value;
    showModalDialog("editchakan.jsp?i="+i,window, "font-family:Verdana; font-size:12; dialogWidth:80em; dialogHeight:10em;status:no");
}
function openchakan3(){
    var i = document.getElementById("select3").value;
    showModalDialog("editchakan.jsp?i="+i,window, "font-family:Verdana; font-size:12; dialogWidth:80em; dialogHeight:10em;status:no");
}
function openchakan4(){
    var i = document.getElementById("select4").value;
    showModalDialog("editchakan.jsp?i="+i,window, "font-family:Verdana; font-size:12; dialogWidth:80em; dialogHeight:10em;status:no");
}
function openchakan5(){
    var i = document.getElementById("select5").value;
    showModalDialog("editchakan.jsp?i="+i,window, "font-family:Verdana; font-size:12; dialogWidth:80em; dialogHeight:10em;status:no");
}
function openchakan6(){
    var i = document.getElementById("select6").value;
    showModalDialog("editchakan.jsp?i="+i,window, "font-family:Verdana; font-size:12; dialogWidth:80em; dialogHeight:10em;status:no");
}
function openchakan7(){
    var i = document.getElementById("select7").value;
    showModalDialog("editchakan.jsp?i="+i,window, "font-family:Verdana; font-size:12; dialogWidth:80em; dialogHeight:10em;status:no");
}
function openchakan8(){
    var i = document.getElementById("select8").value;
    showModalDialog("editchakan.jsp?i="+i,window, "font-family:Verdana; font-size:12; dialogWidth:80em; dialogHeight:10em;status:no");
}
function openchakan9(){
    var i = document.getElementById("select9").value;
    showModalDialog("editchakan.jsp?i="+i,window, "font-family:Verdana; font-size:12; dialogWidth:80em; dialogHeight:10em;status:no");
}
function openchakan10(){
    var i = document.getElementById("select10").value;
    showModalDialog("editchakan.jsp?i="+i,window, "font-family:Verdana; font-size:12; dialogWidth:80em; dialogHeight:10em;status:no");
}
function openchakan11(){
    var i = document.getElementById("select11").value;
    showModalDialog("editchakan.jsp?i="+i,window, "font-family:Verdana; font-size:12; dialogWidth:80em; dialogHeight:10em;status:no");
}
function openchakan12(){
    var i = document.getElementById("select12").value;
    showModalDialog("editchakan.jsp?i="+i,window, "font-family:Verdana; font-size:12; dialogWidth:80em; dialogHeight:10em;status:no");
}
function openchakan13(){
    var i = document.getElementById("select13").value;
    showModalDialog("editchakan.jsp?i="+i,window, "font-family:Verdana; font-size:12; dialogWidth:80em; dialogHeight:10em;status:no");
}
function openchakan14(){
    var i = document.getElementById("select14").value;
    showModalDialog("editchakan.jsp?i="+i,window, "font-family:Verdana; font-size:12; dialogWidth:80em; dialogHeight:10em;status:no");
}
function openchakan15(){
    var i = document.getElementById("select15").value;
    showModalDialog("editchakan.jsp?i="+i,window, "font-family:Verdana; font-size:12; dialogWidth:80em; dialogHeight:10em;status:no");
}
function openchakan16(){
    var i = document.getElementById("select16").value;
    showModalDialog("editchakan.jsp?i="+i,window, "font-family:Verdana; font-size:12; dialogWidth:80em; dialogHeight:10em;status:no");
}
function openchakan17(){
    var i = document.getElementById("select17").value;
    showModalDialog("editchakan.jsp?i="+i,window, "font-family:Verdana; font-size:12; dialogWidth:80em; dialogHeight:10em;status:no");
}
function openchakan18(){
    var i = document.getElementById("select18").value;
    showModalDialog("editchakan.jsp?i="+i,window, "font-family:Verdana; font-size:12; dialogWidth:80em; dialogHeight:10em;status:no");
}
function openchakan19(){
    var i = document.getElementById("select19").value;
    showModalDialog("editchakan.jsp?i="+i,window, "font-family:Verdana; font-size:12; dialogWidth:80em; dialogHeight:10em;status:no");
}
function openchakan20(){
    var i = document.getElementById("select20").value;
    showModalDialog("editchakan.jsp?i="+i,window, "font-family:Verdana; font-size:12; dialogWidth:80em; dialogHeight:10em;status:no");
}
function openchakan21(){
    var i = document.getElementById("select21").value;
    showModalDialog("editchakan.jsp?i="+i,window, "font-family:Verdana; font-size:12; dialogWidth:80em; dialogHeight:10em;status:no");
}
function openchakan22(){
    var i = document.getElementById("select22").value;
    showModalDialog("editchakan.jsp?i="+i,window, "font-family:Verdana; font-size:12; dialogWidth:80em; dialogHeight:10em;status:no");
}
function openchakan23(){
    var i = document.getElementById("select23").value;
    showModalDialog("editchakan.jsp?i="+i,window, "font-family:Verdana; font-size:12; dialogWidth:80em; dialogHeight:10em;status:no");
}
function openchakan24(){
    var i = document.getElementById("select24").value;
    showModalDialog("editchakan.jsp?i="+i,window, "font-family:Verdana; font-size:12; dialogWidth:80em; dialogHeight:10em;status:no");
}
function openchakan25(){
    var i = document.getElementById("select25").value;
    showModalDialog("editchakan.jsp?i="+i,window, "font-family:Verdana; font-size:12; dialogWidth:80em; dialogHeight:10em;status:no");
}
function openchakan26(){
    var i = document.getElementById("select26").value;
    showModalDialog("editchakan.jsp?i="+i,window, "font-family:Verdana; font-size:12; dialogWidth:80em; dialogHeight:10em;status:no");
}
function openchakan27(){
    var i = document.getElementById("select27").value;
    showModalDialog("editchakan.jsp?i="+i,window, "font-family:Verdana; font-size:12; dialogWidth:80em; dialogHeight:10em;status:no");
}
function openchakan28(){
    var i = document.getElementById("select28").value;
    showModalDialog("editchakan.jsp?i="+i,window, "font-family:Verdana; font-size:12; dialogWidth:80em; dialogHeight:10em;status:no");
}
function openchakan29(){
    var i = document.getElementById("select29").value;
    showModalDialog("editchakan.jsp?i="+i,window, "font-family:Verdana; font-size:12; dialogWidth:80em; dialogHeight:10em;status:no");
}

//选择二级分类 by feixiang 2008-01-08
function selecttypevalue(columnid,id){
    var objXml = new ActiveXObject("Microsoft.XMLHTTP");
    objXml.open("POST","selecttypevalue.jsp?column="+columnid+"&id="+id,false);
    objXml.Send();
    var retstr = objXml.responseText;
    if(retstr.length>0){
        typevaluelist.innerHTML = retstr;
    }
}

function selectColumnList()
{
    if (markForm.selectColList[0].checked)
    {
        markForm.colNumInPage.disabled = 1;
        markForm.navbar.disabled = 1;
        markForm.navPosition[0].disabled = 1;
        markForm.navPosition[1].disabled = 1;
        markForm.button1.disabled = 1;
        markForm.button2.disabled = 1;
        markForm.button3.disabled = 1;
        markForm.innerFlag[0].disabled = 0;
        markForm.innerFlag[1].disabled = 0;
    }
    if (markForm.selectColList[1].checked)
    {
        markForm.colNumInPage.disabled = 0;
        markForm.navPosition[0].disabled = 0;
        markForm.navPosition[1].disabled = 0;
        markForm.innerFlag[0].checked = 1;
        markForm.innerFlag[0].disabled = 1;
        markForm.innerFlag[1].disabled = 1;
        markForm.navbar.disabled = 0;
        markForm.button1.disabled = 0;
        markForm.button2.disabled = 0;
        markForm.button3.disabled = 0;
        markForm.navPosition[0].checked = 1;
    }
}

function selectSubColumnList()
{
    if (markForm.selectSubColList[0].checked)
    {
        markForm.colNumInPage.disabled = 1;
        markForm.navbar.disabled = 1;
        markForm.navPosition[0].disabled = 1;
        markForm.navPosition[1].disabled = 1;
        markForm.button1.disabled = 1;
        markForm.button2.disabled = 1;
        markForm.button3.disabled = 1;
    }
    if (markForm.selectSubColList[1].checked)
    {
        markForm.colNumInPage.disabled = 0;
        markForm.navPosition[0].disabled = 0;
        markForm.navPosition[1].disabled = 0;
        markForm.navbar.disabled = 0;
        markForm.button1.disabled = 0;
        markForm.button2.disabled = 0;
        markForm.button3.disabled = 0;
        markForm.navPosition[0].checked = 1;
    }
}

function selectColNavStyle()
{
    if (markForm.navPosition[0].checked)
    {
        markForm.navbar.disabled = 0;
        markForm.button1.disabled = 0;
        markForm.button2.disabled = 0;
        markForm.button3.disabled = 0;
    }
    else
    {
        markForm.navbar.disabled = 1;
        markForm.button1.disabled = 1;
        markForm.button2.disabled = 1;
        markForm.button3.disabled = 1;
    }
}

function selectNavStyle()
{
    if (markForm.navPosition[0].checked)
    {
        markForm.navbar.disabled = 0;
        markForm.button4.disabled = 0;
        markForm.button5.disabled = 0;
        markForm.button6.disabled = 0;
    }
    else
    {
        markForm.navbar.disabled = 1;
        markForm.button4.disabled = 1;
        markForm.button5.disabled = 1;
        markForm.button6.disabled = 1;
    }
}

function selectLink()
{
    if (markForm.linkradio[0].checked)
    {
        markForm.urlname.disabled = true;
        markForm.param.disabled = true;
        markForm.aid.disabled = true;
        markForm.cid.disabled = true;
    }
    else
    {
        markForm.urlname.disabled = false;
        markForm.param.disabled = false;
        markForm.aid.disabled = false;
        markForm.cid.disabled = false;
    }
}

function displayRange()
{
    if (range.style.display == "")
        range.style.display = "none";
    else
        range.style.display = "";
}

function displaySize()
{
    if (moresize.style.display == "")
        moresize.style.display = "none";
    else
        moresize.style.display = "";
}

function defineAttr(){
    var num = 0;
    var text = "";
    for (var i = 0; i < markForm.selectedColumn.length; i++){
        if (markForm.selectedColumn.options[i].selected){
            text = markForm.selectedColumn.options[i].text;
            break;
        }
    }

    if (text != ""){
        var winStr = "alItemAttr.jsp?item=" + text + "&row=" + i;
        var iWidth=600;                                                 //弹出窗口的宽度;
        var iHeight=450;                                                //弹出窗口的高度;
        var iTop = (window.screen.availHeight-30-iHeight)/2;        //获得窗口的垂直位置;
        var iLeft = (window.screen.availWidth-10-iWidth)/2;         //获得窗口的水平位置;
        window.open(winStr, "alItemAttr_window", "width=" + iWidth +",height=" + iHeight +",left=" + iLeft + ",top=" + iTop + ",status,scrollbars");
    }
    //if (text != ""){
    //    var retVal = showModalDialog("alItemAttr.jsp?item=" + text, "", "font-family:Verdana;font-size:12;dialogWidth:26em;dialogHeight:10em;status:no");
    //    if (retVal != undefined && retVal != ""){
    //        markForm.selectedColumn.options[i].text = retVal;
    //    }
    //}
}

function delItem()
{
    var select = false;
    for (var i = 0; i < markForm.selectedColumn.length; i++)
    {
        if (markForm.selectedColumn[i].selected)
        {
            select = true;
            break;
        }
    }

    if (select)
    {
        for (var i = 0; i < markForm.selectedColumn.length; i++)
            if (markForm.selectedColumn[i].selected)
                markForm.selectedColumn[i] = null;
    }
    else
    {
        alert("请选择栏目！");
    }
}

function delArticleItem()
{
    var select = false;
    for (var i = 0; i < markForm.selectedArticle.length; i++)
    {
        if (markForm.selectedArticle[i].selected)
        {
            select = true;
            break;
        }
    }

    if (select)
    {
        for (var i = 0; i < markForm.selectedArticle.length; i++)
            if (markForm.selectedArticle[i].selected) markForm.selectedArticle[i] = null;
    }
}

function check(type, extendStr, saveas,typesize)
{
    if ((markForm.selectArtList[0].checked && markForm.artNum.value == "") || (markForm.selectArtList[1].checked && markForm.articleNumInPage.value == ""))
    {
        alert("请选择要显示的文章数目！");
        return;
    }
    if (!checkNum(markForm.artNum.value) || !checkNum(markForm.articleNumInPage.value))
    {
        alert("文章数目应为整数！");
        return;
    }
    if (markForm.selectArtList[1].checked && markForm.navPosition[0].checked && (markForm.navbar.length == 0 || markForm.navbar.value == 0))
    {
        alert("请选取导航条样式！");
        return;
    }
    var t1 = markForm.time1.value;
    var t2 = markForm.time2.value;
    if (t1 != "" && t2 != "") {
        /*var d1 = new Date();
         d1.setYear(t1.substring(0, 4));
         d1.setMonth(parseInt(t1.substring(5, 7)) - 1);
         d1.setDate(t1.substring(8, 10));

         var d2 = new Date();
         d2.setYear(t2.substring(0, 4));
         d2.setMonth(parseInt(t2.substring(5, 7)) - 1);
         d2.setDate(t2.substring(8, 10));

         if (d1.getTime() > d2.getTime())*/
        if (t1 > t2)
        {
            alert("开始时间应比结束时间小！");
            return;
        }
    }

    if (markForm.num1.value != "" || markForm.num2.value != "") {
        if ((markForm.num1.value != "" && !checkNum(markForm.num1.value)) || (markForm.num2.value != "" && !checkNum(markForm.num2.value))) {
            alert("序号应为整数！");
            return;
        }
        if (markForm.num1.value != "" && markForm.num2.value != "" && parseInt(markForm.num1.value) > parseInt(markForm.num2.value)) {
            alert("开始序号应比结束序号小！");
            return;
        }
    }

    if (markForm.titlesize.value == "" || !checkNum(markForm.titlesize.value) ||
        markForm.vicetitlesize.value == "" || !checkNum(markForm.vicetitlesize.value) ||
        markForm.summarysize.value == "" || !checkNum(markForm.summarysize.value) ||
        markForm.authorsize.value == "" || !checkNum(markForm.authorsize.value) ||
        markForm.sourcesize.value == "" || !checkNum(markForm.sourcesize.value))
    {
        alert("请填写正确的要选取的字数！");
        return;
    }
    if (markForm.listType.length == 0 || markForm.listType.selectedIndex == 0)
    {
        alert("请选取文章列表样式！");
        return;
    }
    if (markForm.days.value == "" || (markForm.days.value != "" && !checkNum(markForm.days.value)))
    {
        alert("请填写正确的新文章天数！");
        return;
    }
    if (markForm.days.value != "" && markForm.days.value != "0" && (markForm.seldays.length == 0 || markForm.seldays.selectedIndex == 0))
    {
        alert("请选取新文章样式文件！");
        return;
    }
    if (markForm.linkradio[1].checked && markForm.urlname.value == "")
    {
        alert("请填写自定义的URL地址！");
        return;
    }
    if (markForm.chineseName.value == "")
    {
        alert("请填写标记中文名称！");
        return;
    }
    if (markForm.notes.value.indexOf('[') > -1 || markForm.notes.value.indexOf(']') > -1 ||
        markForm.chineseName.value.indexOf('[') > -1 || markForm.chineseName.value.indexOf(']') > -1)
    {
        alert("请不要在标记名称及描述中输入 [ ] 括号！");
        return;
    }

    var attrVal = "[TAG]";
    if (type == 1) {
        if (markForm.article.value == "")
            attrVal = attrVal + "[SUBARTICLE_LIST][ARTICLEID]0[/ARTICLEID]";
        else
            attrVal = attrVal + "[SUBARTICLE_LIST][ARTICLEID]" + markForm.article.value + "[/ARTICLEID]";
    } else if (type == 2) {
        if (markForm.article.value == "")
            attrVal = attrVal + "[BROTHER_LIST][ARTICLEID]0[/ARTICLEID]";
        else
            attrVal = attrVal + "[BROTHER_LIST][ARTICLEID]" + markForm.article.value + "[/ARTICLEID]";
    } else if (type == 3) {
        attrVal = attrVal + "[RECOMMEND_LIST]";
    } else {
        attrVal = attrVal + "[ARTICLE_LIST]";
    }

    //文章列表从第几篇文章开始，到第几篇文章结束
    if (markForm.startArtNum.value == "" || markForm.startArtNum.value == null) {
        attrVal = attrVal + "[STARTARTNUM]0[/STARTARTNUM]";
    } else {
        attrVal = attrVal + "[STARTARTNUM]" + markForm.startArtNum.value + "[/STARTARTNUM]";
    }

    if (markForm.endArtNum.value == "" || markForm.endArtNum.value == null) {
        attrVal = attrVal + "[ENDARTNUM]0[/ENDARTNUM]";
    } else {
        attrVal = attrVal + "[ENDARTNUM]" + markForm.endArtNum.value + "[/ENDARTNUM]";
    }

    columnlist = "[COLUMNS]";
    columnids = "[COLUMNIDS](";

    //选择使用那些的文章生成文章列表,如果没有选择栏目,则使用当前栏目的文章生成文章列表
    if (markForm.selectedColumn.length > 0) {
        for (var i = 0; i < markForm.selectedColumn.length - 1; i++)
        {
            var str = markForm.selectedColumn.options[i].text;
            var p = 0;
            if ((p = str.indexOf("-getAllSubArticle")) > -1)
            {
                str = str.substring(0, p);
                columnlist = columnlist + str + ",";
                columnids = columnids + markForm.selectedColumn.options[i].value + "-getAllSubArticle" + ",";
            }
            else
            {
                columnlist = columnlist + str + ",";
                columnids = columnids + markForm.selectedColumn.options[i].value + ",";
            }
        }

        var str = markForm.selectedColumn.options[markForm.selectedColumn.length - 1].text;
        var p = 0;
        if ((p = str.indexOf("-getAllSubArticle")) > -1)
        {
            str = str.substring(0, p);
            columnlist = columnlist + str + "[/COLUMNS]";
            columnids = columnids + markForm.selectedColumn.options[markForm.selectedColumn.length - 1].value + "-getAllSubArticle" + ")[/COLUMNIDS]";
        }
        else
        {
            columnlist = columnlist + str + "[/COLUMNS]";
            columnids = columnids + markForm.selectedColumn.options[markForm.selectedColumn.length - 1].value + ")[/COLUMNIDS]";
        }
    } else {
        columnlist = columnlist + "*[/COLUMNS]";
        columnids = columnids + "0)[/COLUMNIDS]";
    }
    attrVal = attrVal + columnlist + columnids;

    //判断文章选择的方式
    if (markForm.selectArtList[0].checked) {
        attrVal = attrVal + "[SELECTWAY]0[/SELECTWAY]";
        attrVal = attrVal + "[ARTICLENUM]" + markForm.artNum.value + "[/ARTICLENUM]";
    } else {
        attrVal = attrVal + "[SELECTWAY]2[/SELECTWAY]";
        attrVal = attrVal + "[ARTICLENUM]" + markForm.articleNumInPage.value + "[/ARTICLENUM]";
        if (markForm.navPosition[0].checked)
            attrVal = attrVal + "[NAVBAR]" + markForm.navbar.value + "[/NAVBAR]";
        else
            attrVal = attrVal + "[NAVBAR]0[/NAVBAR]";
    }

    attrVal = attrVal + "[LISTTYPE]" + markForm.listType.value + "[/LISTTYPE]";
    attrVal = attrVal + "[LETTERNUM]" + markForm.titlesize.value + "[/LETTERNUM]";
    if (markForm.vicetitlesize.value != "" && checkNum(markForm.vicetitlesize.value) && markForm.vicetitlesize.value != "0")
        attrVal = attrVal + "[ARTICLE_VICETITLE]" + markForm.vicetitlesize.value + "[/ARTICLE_VICETITLE]";
    if (markForm.summarysize.value != "" && checkNum(markForm.summarysize.value) && markForm.summarysize.value != "0")
        attrVal = attrVal + "[ARTICLE_SUMMARY]" + markForm.summarysize.value + "[/ARTICLE_SUMMARY]";
    if (markForm.authorsize.value != "" && checkNum(markForm.authorsize.value) && markForm.authorsize.value != "0")
        attrVal = attrVal + "[ARTICLE_AUTHOR]" + markForm.authorsize.value + "[/ARTICLE_AUTHOR]";
    if (markForm.sourcesize.value != "" && checkNum(markForm.sourcesize.value) && markForm.sourcesize.value != "0")
        attrVal = attrVal + "[ARTICLE_SOURCE]" + markForm.sourcesize.value + "[/ARTICLE_SOURCE]";
    if (markForm.contentsize.value != "" && checkNum(markForm.contentsize.value) && markForm.contentsize.value != "0")
        attrVal = attrVal + "[ARTICLE_CONTENT]" + markForm.contentsize.value + "[/ARTICLE_CONTENT]";

    if (extendStr != "") {
        var extend = extendStr.split(",");
        for (var i = 0; i < extend.length; i++)
        {
            var val = document.all(extend[i]).value;
            if (val != "" && checkNum(val) && val != "0")
                attrVal = attrVal + "[" + extend[i] + "]" + val + "[/" + extend[i] + "]";
        }
    }

    //文章显示顺序
    attrVal = attrVal + "[ORDER]" + markForm.order1.value + "," + markForm.order2.value + "," + markForm.order3.value + "[/ORDER]";
    attrVal = attrVal + "[ORDER_RANGE]";
    attrVal = attrVal + "[TIME_RANGE]" + markForm.time1.value + "," + markForm.time2.value + "[/TIME_RANGE]";
    attrVal = attrVal + "[POWER_RANGE]" + markForm.power1.value + "[/POWER_RANGE]";
    attrVal = attrVal + "[VICEPOWER_RANGE]" + markForm.power2.value + "[/VICEPOWER_RANGE]";
    attrVal = attrVal + "[NUMBER_RANGE]" + markForm.num1.value + "," + markForm.num2.value + "[/NUMBER_RANGE]";
    attrVal = attrVal + "[/ORDER_RANGE]";

    //被选中文章的标题在文章列表中的显示颜色
    attrVal = attrVal + "[COLOR]" + markForm.sellink.value + "[/COLOR]";

    var radionum = document.getElementsByName("archive");
    for(var i=0;i<radionum.length;i++){
        if(radionum[0].checked){
            attrVal = attrVal + "[EXCLUDE]" + radionum[0].value + "[/EXCLUDE]";
            break;
        } else if(radionum[1].checked){
            attrVal = attrVal + "[ARCHIVE]" + radionum[1].value + "[/ARCHIVE]";
            break;
        } else {
            attrVal = attrVal + "[ARCHIVE]" + radionum[2].value + "[/ARCHIVE]";
            break;
        }
    }

    attrVal = attrVal + "[NEW]" + markForm.days.value + "[/NEW]";
    if (markForm.days.value != "" && markForm.days.value != "0")
        attrVal = attrVal + "[DAYSTYLE]" + markForm.seldays.value + "[/DAYSTYLE]";

    //连接的定义方式
    attrVal = attrVal + "[LINK]";
    if (markForm.linkradio[0].checked)
    {
        attrVal = attrVal + "[WAY]0[/WAY]";
    }
    else
    {
        attrVal = attrVal + "[WAY]1[/WAY]";
        attrVal = attrVal + "[URL]" + markForm.urlname.value + "[/URL]";
        attrVal = attrVal + "[PARAM]" + markForm.param.value + "[/PARAM]";
        if (markForm.aid.checked)
            attrVal = attrVal + "[AID]1[/AID]";
        else
            attrVal = attrVal + "[AID]0[/AID]";
        if (markForm.cid.checked)
            attrVal = attrVal + "[CID]1[/CID]";
        else
            attrVal = attrVal + "[CID]0[/CID]";
    }
    attrVal = attrVal + "[/LINK]";

    //是否将标记发布成包含文件
    if (markForm.innerFlag[0].checked)
        attrVal = attrVal + "[INNERHTMLFLAG]0[/INNERHTMLFLAG]";
    else
        attrVal = attrVal + "[INNERHTMLFLAG]1[/INNERHTMLFLAG]";

    attrVal = attrVal + "[CHINESENAME]" + markForm.chineseName.value + "[/CHINESENAME]";
    attrVal = attrVal + "[NOTES]" + markForm.notes.innerText + "[/NOTES]";

    if(typesize > 0){
        //arrtVal = arrtValu + "[ARTICLE_TYPE]" + markForm.selecttypevau + "[/ARTICLE_TYPE]";
        attrVal = attrVal + "[ARTICLEFIRSTTYPE]0[/ARTICLEFIRSTTYPE]";
        attrVal = attrVal + "[ARTICLESECONDTYPE]" + markForm.typevalue.value +"[/ARTICLESECONDTYPE]";
    }

    if (type == 1)
        attrVal = attrVal + "[/SUBARTICLE_LIST][/TAG]";
    else if (type == 2)
        attrVal = attrVal + "[/BROTHER_LIST][/TAG]";
    else if (type == 3)
        attrVal = attrVal + "[/RECOMMEND_LIST][/TAG]";
    else
        attrVal = attrVal + "[/ARTICLE_LIST][/TAG]";

    markForm.saveas.value = saveas;
    markForm.columnIDs.value = columnids;
    markForm.content.value = attrVal;
    markForm.submit();
}

function checkNum(str)
{
    var success = true;
    for (var i = 0; i < str.length; i++)
    {
        if (str.substring(i, i + 1) < '0' || str.substring(i, i + 1) > '9')
        {
            success = false;
            break;
        }
    }
    return success;
}

function AddRelatedArticleID(columnid) {
    rwin = window.open("../article/addRelatedArticle.jsp?column="+columnid, "createStyle", "font-family:Verdana;font-size:12;dialogWidth:560px;dialogHeight:390px;status:no");
    rwin.focus();
}

//以下是栏目列表
function activeArticle(activeflag)
{
    if (activeflag == 0)
    {
        markForm.urlname.disabled = true;
        markForm.linkArtNum.disabled = true;
        markForm.aid.disabled = true;
        markForm.cid.disabled = true;
        markForm.param.disabled = true;
    }
    if (activeflag == 1)
    {
        markForm.urlname.disabled = false;
        markForm.linkArtNum.disabled = true;
        markForm.aid.disabled = true;
        markForm.cid.disabled = false;
        markForm.param.disabled = false;
    }
    if (activeflag == 2)
    {
        markForm.urlname.disabled = true;
        markForm.linkArtNum.disabled = false;
        markForm.aid.disabled = false;
        markForm.cid.disabled = false;
        markForm.param.disabled = false;
    }
}

function createColumnList()
{
    if (markForm.selectColList[1].checked && markForm.colNumInPage.value == "")
    {
        alert("请选择要显示的栏目数目！");
        return;
    }
    if (!checkNum(markForm.colNumInPage.value))
    {
        alert("栏目数目应为整数！");
        return;
    }
    if (markForm.selectColList[1].checked && markForm.navPosition[0].checked && (markForm.navbar.length == 0 || markForm.navbar.value == 0))
    {
        alert("请选取导航条样式！");
        return;
    }
    if (markForm.listType.selectedIndex == 0)
    {
        alert("请选择栏目列表样式！");
        return;
    }
    if (markForm.linkradio[1].checked && markForm.urlname.value == "")
    {
        alert("请输入自定义URL名称！");
        return;
    }
    if (markForm.linkradio[2].checked && markForm.linkArtNum.value == "")
    {
        alert("请输入要连接的文章序号！");
        return;
    }
    if (markForm.linkradio[2].checked && !checkNum(markForm.linkArtNum.value))
    {
        alert("文章序号应为整数！");
        return;
    }
    if (markForm.chineseName.value == "")
    {
        alert("请输入标记中文名称！");
        return;
    }

    var attrVal = "[TAG][COLUMN_LIST]";
    columnlist = "[COLUMNS]";
    columnids = "[COLUMNIDS](";

    //选择使用那些的文章生成文章列表,如果没有选择栏目，则使用当前栏目的文章生成文章列表
    if (markForm.selectedColumn.length > 0)
    {
        for (var i = 0; i < markForm.selectedColumn.length - 1; i++)
        {
            columnlist = columnlist + markForm.selectedColumn.options[i].text + ",";
            columnids = columnids + markForm.selectedColumn.options[i].value + ",";
        }
        columnlist = columnlist + markForm.selectedColumn.options[markForm.selectedColumn.length - 1].text + "[/COLUMNS]";
        columnids = columnids + markForm.selectedColumn.options[markForm.selectedColumn.length - 1].value + ")[/COLUMNIDS]";
    }
    else
    {
        columnlist = columnlist + "*[/COLUMNS]";
        columnids = columnids + "0)[/COLUMNIDS]";
    }

    attrVal = attrVal + columnlist + columnids + "[LISTTYPE]" + markForm.listType.value + "[/LISTTYPE]";

    attrVal = attrVal + "[LINK]";
    if (markForm.linkradio[0].checked)
    {
        attrVal = attrVal + "[WAY]0[/WAY]";
    }
    if (markForm.linkradio[1].checked)
    {
        attrVal = attrVal + "[WAY]1[/WAY]";
        attrVal = attrVal + "[URL]" + markForm.urlname.value + "[/URL]";
        attrVal = attrVal + "[PARAM]" + markForm.param.value + "[/PARAM]";
        if (markForm.cid.checked)
            attrVal = attrVal + "[CID]1[/CID]";
        else
            attrVal = attrVal + "[CID]0[/CID]";
    }
    if (markForm.linkradio[2].checked)
    {
        attrVal = attrVal + "[WAY]2[/WAY]";
        attrVal = attrVal + "[LINKARTICLE]" + markForm.linkArtNum.value + "[/LINKARTICLE]";
        attrVal = attrVal + "[PARAM]" + markForm.param.value + "[/PARAM]";
        if (markForm.cid.checked)
            attrVal = attrVal + "[CID]1[/CID]";
        else
            attrVal = attrVal + "[CID]0[/CID]";
        if (markForm.aid.checked)
            attrVal = attrVal + "[AID]1[/AID]";
        else
            attrVal = attrVal + "[AID]0[/AID]";
    }
    attrVal = attrVal + "[/LINK]";

    //判断栏目列表选择的方式
    if (markForm.selectColList[0].checked)
    {
        attrVal = attrVal + "[SELECTWAY]0[/SELECTWAY]";
    }
    else
    {
        attrVal = attrVal + "[SELECTWAY]2[/SELECTWAY]";
        attrVal = attrVal + "[COLUMNNUM]" + markForm.colNumInPage.value + "[/COLUMNNUM]";
        if (markForm.navPosition[0].checked)
            attrVal = attrVal + "[NAVBAR]" + markForm.navbar.value + "[/NAVBAR]";
        else
            attrVal = attrVal + "[NAVBAR]0[/NAVBAR]";
    }

    if (markForm.innerFlag[0].checked)
        attrVal = attrVal + "[INNERHTMLFLAG]0[/INNERHTMLFLAG]";
    else
        attrVal = attrVal + "[INNERHTMLFLAG]1[/INNERHTMLFLAG]";

    attrVal = attrVal + "[CHINESENAME]" + markForm.chineseName.value + "[/CHINESENAME]";
    attrVal = attrVal + "[NOTES]" + markForm.notes.innerText + "[/NOTES]";
    attrVal = attrVal + "[/COLUMN_LIST][/TAG]";

    markForm.columnIDs.value = columnids;
    markForm.content.value = attrVal;
    markForm.submit();
}

function createSubColumnList()
{
    if (markForm.selectSubColList[1].checked && markForm.colNumInPage.value == "")
    {
        alert("请选择要显示的栏目数目！");
        return;
    }
    if (!checkNum(markForm.colNumInPage.value))
    {
        alert("栏目数目应为整数！");
        return;
    }
    if (markForm.selectSubColList[1].checked && markForm.navPosition[0].checked && (markForm.navbar.length == 0 || markForm.navbar.value == 0))
    {
        alert("请选取导航条样式！");
        return;
    }
    if (markForm.listType.selectedIndex == 0)
    {
        alert("请选择栏目列表样式！");
        return;
    }
    if (markForm.linkradio[1].checked && markForm.urlname.value == "")
    {
        alert("请输入自定义URL名称！");
        return;
    }
    if (markForm.linkradio[2].checked && markForm.linkArtNum.value == "")
    {
        alert("请输入要连接的文章序号！");
        return;
    }
    if (markForm.linkradio[2].checked && !checkNum(markForm.linkArtNum.value))
    {
        alert("文章序号应为整数！");
        return;
    }
    if ((markForm.selectedColumn.value == null) || (markForm.selectedColumn.value == ""))
    {
        alert("请选择栏目！");
        return;
    }

    var attrVal = "[TAG][SUBCOLUMN_LIST]";
    columnlist = "[COLUMNS]";
    columnids = "[COLUMNIDS](";

    //选择使用那些的文章生成文章列表,如果没有选择栏目，则使用当前栏目的文章生成文章列表
    if ((markForm.selectedColumn.value != null) && (markForm.selectedColumn.value != ""))
    {
        columnlist = columnlist + markForm.selectedColumn.value + "[/COLUMNS]";
        columnids = columnids + markForm.selectedColumnID.value + ")[/COLUMNIDS]";
    }
    else
    {
        columnlist = columnlist + "*[/COLUMNS]";
        columnids = columnids + "0)[/COLUMNIDS]";
    }

    attrVal = attrVal + columnlist + columnids + "[LISTTYPE]" + markForm.listType.value + "[/LISTTYPE]";

    attrVal = attrVal + "[LINK]";
    if (markForm.linkradio[0].checked)
    {
        attrVal = attrVal + "[WAY]0[/WAY]";
    }
    if (markForm.linkradio[1].checked)
    {
        attrVal = attrVal + "[WAY]1[/WAY]";
        attrVal = attrVal + "[URL]" + markForm.urlname.value + "[/URL]";
        attrVal = attrVal + "[PARAM]" + markForm.param.value + "[/PARAM]";
        if (markForm.cid.checked)
            attrVal = attrVal + "[CID]1[/CID]";
        else
            attrVal = attrVal + "[CID]0[/CID]";
    }
    if (markForm.linkradio[2].checked)
    {
        attrVal = attrVal + "[WAY]2[/WAY]";
        attrVal = attrVal + "[LINKARTICLE]" + markForm.linkArtNum.value + "[/LINKARTICLE]";
        attrVal = attrVal + "[PARAM]" + markForm.param.value + "[/PARAM]";
        if (markForm.cid.checked)
            attrVal = attrVal + "[CID]1[/CID]";
        else
            attrVal = attrVal + "[CID]0[/CID]";
        if (markForm.aid.checked)
            attrVal = attrVal + "[AID]1[/AID]";
        else
            attrVal = attrVal + "[AID]0[/AID]";
    }
    attrVal = attrVal + "[/LINK]";

    //判断栏目列表选择的方式
    if (markForm.selectSubColList[0].checked)
    {
        attrVal = attrVal + "[SELECTWAY]0[/SELECTWAY]";
    }
    else
    {
        attrVal = attrVal + "[SELECTWAY]2[/SELECTWAY]";
        attrVal = attrVal + "[COLUMNNUM]" + markForm.colNumInPage.value + "[/COLUMNNUM]";
        if (markForm.navPosition[0].checked)
            attrVal = attrVal + "[NAVBAR]" + markForm.navbar.value + "[/NAVBAR]";
        else
            attrVal = attrVal + "[NAVBAR]0[/NAVBAR]";
    }

    attrVal = attrVal + "[INNERHTMLFLAG]0[/INNERHTMLFLAG]";
    attrVal = attrVal + "[CHINESENAME]子栏目列表[/CHINESENAME]";
    attrVal = attrVal + "[NOTES][/NOTES]";
    attrVal = attrVal + "[/SUBCOLUMN_LIST][/TAG]";

    markForm.columnIDs.value = columnids;
    markForm.content.value = attrVal;
    markForm.submit();
}

//以下是相关文章列表
function selectArea(val)
{
    markForm.selectedColumn.disabled = val;
    markForm.deleteButton.disabled = val;
}

function createRelateList()
{
    if (markForm.keytype[1].checked && markForm.keyword.value == "")
    {
        alert("请填写要自定义的关键字！");
        return;
    }
    else if (markForm.artNum.value == "")
    {
        alert("请填写需要读取的相关文章数目！");
        return;
    }
    else if (!checkNum(markForm.artNum.value))
    {
        alert("请填写正确的相关文章数目！");
        return;
    }
    else if (markForm.letterNum.value == "")
    {
        alert("请填写标题需要显示的字数！");
        return;
    }
    else if (!checkNum(markForm.letterNum.value))
    {
        alert("请填写正确的标题显示字数！");
        return;
    }
    else if (markForm.listType.selectedIndex == 0)
    {
        alert("请选取相关文章列表样式文件！");
        return;
    }
    else if (markForm.chineseName.value == "")
    {
        alert("请填写列表中文名称！");
        return;
    }

    var attrVal = "[TAG][RELATED_ARTICLE]";
    columnlist = "[COLUMNS]";
    columnids = "[COLUMNIDS](";

    //选择使用那些的文章生成文章列表,如果没有选择栏目，则使用当前栏目的文章生成文章列表
    if (markForm.selectedColumn.length > 0 && markForm.area[1].checked)
    {
        for (var i = 0; i < markForm.selectedColumn.length - 1; i++)
        {
            var str = markForm.selectedColumn.options[i].text;
            var p = 0;
            if ((p = str.indexOf("-getAllSubArticle")) > -1)
            {
                str = str.substring(0, p);
                columnlist = columnlist + str + ",";
                columnids = columnids + markForm.selectedColumn.options[i].value + "-getAllSubArticle" + ",";
            }
            else
            {
                columnlist = columnlist + str + ",";
                columnids = columnids + markForm.selectedColumn.options[i].value + ",";
            }
        }

        var str = markForm.selectedColumn.options[markForm.selectedColumn.length - 1].text;
        var p = 0;
        if ((p = str.indexOf("-getAllSubArticle")) > -1)
        {
            str = str.substring(0, p);
            columnlist = columnlist + str + "[/COLUMNS]";
            columnids = columnids + markForm.selectedColumn.options[markForm.selectedColumn.length - 1].value + "-getAllSubArticle" + ")[/COLUMNIDS]";
        }
        else
        {
            columnlist = columnlist + str + "[/COLUMNS]";
            columnids = columnids + markForm.selectedColumn.options[markForm.selectedColumn.length - 1].value + ")[/COLUMNIDS]";
        }
    }
    else if (markForm.area[1].checked)
    {
        columnlist = columnlist + "*[/COLUMNS]";
        columnids = columnids + "0)[/COLUMNIDS]";
    }

    if (markForm.keytype[0].checked)
        attrVal = attrVal + "[KEYWORD][/KEYWORD]";
    else
        attrVal = attrVal + "[KEYWORD]" + markForm.keyword.value + "[/KEYWORD]";

    if (markForm.area[0].checked)
        attrVal = attrVal + "[AREA]0[/AREA]";
    else
        attrVal = attrVal + columnlist + columnids + "[AREA]1[/AREA]";

    if (markForm.matchType[0].checked)
        attrVal = attrVal + "[MATCHTYPE]0[/MATCHTYPE]";
    else
        attrVal = attrVal + "[MATCHTYPE]1[/MATCHTYPE]";
    attrVal = attrVal + "[LISTTYPE]" + markForm.listType.value + "[/LISTTYPE]";
    attrVal = attrVal + "[ARTICLENUM]" + markForm.artNum.value + "[/ARTICLENUM]";
    attrVal = attrVal + "[LETTERNUM]" + markForm.letterNum.value + "[/LETTERNUM]";
    attrVal = attrVal + "[CHINESENAME]" + markForm.chineseName.value + "[/CHINESENAME]";
    attrVal = attrVal + "[NOTES]" + markForm.notes.innerText + "[/NOTES]";
    attrVal = attrVal + "[/RELATED_ARTICLE][/TAG]";

    markForm.content.value = attrVal;
    markForm.submit();
}

//以下是热点文章
function createTopStories(type)
{
    if (type == 0 && markForm.selectedArticle.length == 0)
    {
        alert("请选择至少一篇热点文章！");
        return;
    }
    if (markForm.listType.selectedIndex == 0)
    {
        alert("请选择热点文章样式文件！");
        return;
    }
    if (type == 1 && markForm.articleNum.value == "")
    {
        alert("请输入要显示的文章条数！");
        return;
    }
    if (type == 1 && !checkNum(markForm.articleNum.value))
    {
        alert("文章条数应为整数！");
        return;
    }
    if (type == 1 && (markForm.beginNum.value == "" || !checkNum(markForm.beginNum.value)))
    {
        alert("开始文章数不能为空并为整数！");
        return;
    }
    if (type == 1 && markForm.power.checked && markForm.power1.value == "" && markForm.power2.value == "")
    {
        alert("权重不能都为空！");
        return;
    }
    if (type == 1 && markForm.power.checked && ((markForm.power1.value != "" && !checkNum(markForm.power1.value)) || (markForm.power2.value != "" && !checkNum(markForm.power2.value))))
    {
        alert("权重应为整数！");
        return;
    }
    if (markForm.maintitle.value == "" || !checkNum(markForm.maintitle.value) ||
        markForm.vicetitle.value == "" || !checkNum(markForm.vicetitle.value) ||
        markForm.content.value == "" || !checkNum(markForm.content.value) ||
        markForm.author.value == "" || !checkNum(markForm.author.value) ||
        markForm.summary.value == "" || !checkNum(markForm.summary.value) ||
        markForm.source.value == "" || !checkNum(markForm.source.value))
    {
        alert("所有属性的字数不能为空并为整数！");
        return;
    }
    if (markForm.chineseName.value == "")
    {
        alert("请输入标记中文名称！");
        return;
    }
    if (markForm.chineseName.value != "" && (markForm.chineseName.value.indexOf("]") > -1 || markForm.chineseName.value.indexOf("[") > -1))
    {
        alert("标记中文名称不能包含 [ ] 符号！");
        return;
    }
    if (markForm.notes.value != "" && (markForm.notes.value.indexOf("]") > -1 || markForm.notes.value.indexOf("[") > -1))
    {
        alert("标记描述不能包含 [ ] 符号！");
        return;
    }

    var attrVal = "[TAG][TOP_STORIES]";
    attrVal = attrVal + "[LISTTYPE]" + markForm.listType.value + "[/LISTTYPE]";

    //选中的文章
    if (type == 0)
    {
        attrVal = attrVal + "[ARTICLE][ID]";
        for (var i = 0; i < markForm.selectedArticle.length - 1; i++)
        {
            attrVal = attrVal + markForm.selectedArticle.options[i].value + ",";
        }
        attrVal = attrVal + markForm.selectedArticle.options[markForm.selectedArticle.length - 1].value + "[/ID][/ARTICLE]";

        if (markForm.order[0].checked)
            attrVal = attrVal + "[ORDER]0[/ORDER]";
        else
            attrVal = attrVal + "[ORDER]1[/ORDER]";
    }
    else
    {
        attrVal = attrVal + "[ARTICLE][ARTICLENUM]" + markForm.articleNum.value + "[/ARTICLENUM]";
        if (markForm.lastest.checked)
            attrVal = attrVal + "[LASTEST]1[/LASTEST]";
        else
            attrVal = attrVal + "[LASTEST]0[/LASTEST]";

        attrVal = attrVal + "[BEGINNUM]" + markForm.beginNum.value + "[/BEGINNUM]";

        if (markForm.power.checked)
            attrVal = attrVal + "[POWER]" + markForm.power1.value + "-" + markForm.power2.value + "[/POWER]"
        else
            attrVal = attrVal + "[POWER]-[/POWER]"
        attrVal = attrVal + "[/ARTICLE]";

        attrVal = attrVal + "[COLUMN][ID]";
        if (markForm.selectedColumn.length > 0)
        {
            for (var i = 0; i < markForm.selectedColumn.length - 1; i++)
                attrVal = attrVal + markForm.selectedColumn.options[i].value + ",";
            attrVal = attrVal + markForm.selectedColumn.options[markForm.selectedColumn.length - 1].value + "[/ID]";
        }
        else
        {
            attrVal = attrVal + "0[/ID]";
        }

        attrVal = attrVal + "[NAME]";
        if (markForm.selectedColumn.length > 0)
        {
            for (var i = 0; i < markForm.selectedColumn.length - 1; i++)
                attrVal = attrVal + markForm.selectedColumn.options[i].text + ",";
            attrVal = attrVal + markForm.selectedColumn.options[markForm.selectedColumn.length - 1].text + "[/NAME][/COLUMN]";
        }
        else
        {
            attrVal = attrVal + "*[/NAME][/COLUMN]";
        }
    }

    //字数
    attrVal = attrVal + "[ARTICLE_MAINTITLE]" + markForm.maintitle.value + "[/ARTICLE_MAINTITLE]";
    attrVal = attrVal + "[ARTICLE_VICETITLE]" + markForm.vicetitle.value + "[/ARTICLE_VICETITLE]";
    attrVal = attrVal + "[ARTICLE_CONTENT]" + markForm.content.value + "[/ARTICLE_CONTENT]";
    attrVal = attrVal + "[ARTICLE_SOURCE]" + markForm.source.value + "[/ARTICLE_SOURCE]";
    attrVal = attrVal + "[ARTICLE_SUMMARY]" + markForm.summary.value + "[/ARTICLE_SUMMARY]";
    attrVal = attrVal + "[ARTICLE_AUTHOR]" + markForm.author.value + "[/ARTICLE_AUTHOR]";
    attrVal = attrVal + "[ARTICLE_TIME]" + markForm.datestyle.value + "," + markForm.timestyle.value + "[/ARTICLE_TIME]";

    if (markForm.innerFlag[0].checked)
        attrVal = attrVal + "[INNERHTMLFLAG]0[/INNERHTMLFLAG]";
    else
        attrVal = attrVal + "[INNERHTMLFLAG]1[/INNERHTMLFLAG]";

    attrVal = attrVal + "[CHINESENAME]" + markForm.chineseName.value + "[/CHINESENAME][NOTES]" + markForm.notes.value + "[/NOTES]";
    attrVal = attrVal + "[/TOP_STORIES][/TAG]";

    alert(attrVal);

    markForm.contents.value = attrVal;
    markForm.submit();
}

//以下是子文章条数
function createArticleCountMark(type)
{
    if (markForm.time1.value != "" && markForm.time2.value != "")
    {
        var t1 = markForm.time1.value;
        var d1 = new Date();
        d1.setYear(t1.substring(0, 4));
        d1.setMonth(parseInt(t1.substring(5, 7)) - 1);
        d1.setDate(t1.substring(8, 10));

        var t2 = markForm.time2.value;
        var d2 = new Date();
        d2.setYear(t2.substring(0, 4));
        d2.setMonth(parseInt(t2.substring(5, 7)) - 1);
        d2.setDate(t2.substring(8, 10));

        if (d1.getTime() > d2.getTime())
        {
            alert("开始时间应比结束时间小！");
            return;
        }
    }
    if (markForm.power1.value != "" || markForm.power2.value != "")
    {
        if ((markForm.power1.value != "" && !checkNum(markForm.power1.value)) || (markForm.power2.value != "" && !checkNum(markForm.power2.value)))
        {
            alert("权重应为整数！");
            return;
        }
        if (markForm.power1.value != "" && markForm.power2.value != "" && parseInt(markForm.power1.value) > parseInt(markForm.power2.value))
        {
            alert("开始权重应比结束权重小！");
            return;
        }
    }
    if (markForm.num1.value != "" || markForm.num2.value != "")
    {
        if ((markForm.num1.value != "" && !checkNum(markForm.num1.value)) || (markForm.num2.value != "" && !checkNum(markForm.num2.value)))
        {
            alert("序号应为整数！");
            return;
        }
        if (markForm.num1.value != "" && markForm.num2.value != "" && parseInt(markForm.num1.value) > parseInt(markForm.num2.value))
        {
            alert("开始序号应比结束序号小！");
            return;
        }
    }

    var attrVal = "[TAG][ARTICLE_COUNT]";
    if (type == 1)  attrVal = "[TAG][SUBARTICLE_COUNT]";

    columnlist = "[COLUMNS]";
    columnids = "[COLUMNIDS](";

    if (markForm.selectedColumn.length > 0)
    {
        for (var i = 0; i < markForm.selectedColumn.length - 1; i++)
        {
            var str = markForm.selectedColumn.options[i].text;
            var p = 0;
            if ((p = str.indexOf("-getAllSubArticle")) > -1)
            {
                str = str.substring(0, p);
                columnlist = columnlist + str + ",";
                columnids = columnids + markForm.selectedColumn.options[i].value + "-getAllSubArticle" + ",";
            }
            else
            {
                columnlist = columnlist + str + ",";
                columnids = columnids + markForm.selectedColumn.options[i].value + ",";
            }
        }

        var str = markForm.selectedColumn.options[markForm.selectedColumn.length - 1].text;
        var p = 0;
        if ((p = str.indexOf("-getAllSubArticle")) > -1)
        {
            str = str.substring(0, p);
            columnlist = columnlist + str + "[/COLUMNS]";
            columnids = columnids + markForm.selectedColumn.options[markForm.selectedColumn.length - 1].value + "-getAllSubArticle" + ")[/COLUMNIDS]";
        }
        else
        {
            columnlist = columnlist + str + "[/COLUMNS]";
            columnids = columnids + markForm.selectedColumn.options[markForm.selectedColumn.length - 1].value + ")[/COLUMNIDS]";
        }
    }
    else
    {
        columnlist = columnlist + "*[/COLUMNS]";
        columnids = columnids + "0)[/COLUMNIDS]";
    }
    attrVal = attrVal + columnlist + columnids;

    attrVal = attrVal + "[TIME_RANGE]" + markForm.time1.value + "," + markForm.time2.value + "[/TIME_RANGE]";
    attrVal = attrVal + "[POWER_RANGE]" + markForm.power1.value + "," + markForm.power2.value + "[/POWER_RANGE]";
    attrVal = attrVal + "[ORDER_RANGE]" + markForm.num1.value + "," + markForm.num2.value + "[/ORDER_RANGE]";

    if (type == 1)
    {
        if (markForm.article.value == "")
            attrVal = attrVal + "[ARTICLEID]0[/ARTICLEID][/SUBARTICLE_COUNT][/TAG]";
        else
            attrVal = attrVal + "[ARTICLEID]" + markForm.article.value + "[/ARTICLEID][/SUBARTICLE_COUNT][/TAG]";
    }
    else
    {
        attrVal = attrVal + "[/ARTICLE_COUNT][/TAG]";
    }

    var markname = "";
    if (type == 0)
        markname = "文章条数";
    else
        markname = "子文章条数";

    var returnvalue = "<INPUT name='" + attrVal + "' type=button value='[" + markname + "]' style='BORDER-RIGHT: #808080 1px solid; BORDER-TOP: #808080 1px solid; FONT-SIZE: 12px; BORDER-LEFT: #808080 1px solid; BORDER-BOTTOM: #808080 1px solid; BACKGROUND-COLOR: #D6D3CE'>";
    window.parent.opener.InsertHTML(returnvalue);
    top.close();
}

function cal() {
    top.close();
}

//包含文件标记
function createInlucdeFile(type) {
    if (type == 0 && markForm.selectedArticle.length == 0) {
        alert("请选择至少一个包含文件！");
        return;
    }

    if (markForm.chineseName.value == "") {
        alert("请输入标记中文名称！");
        return;
    }
    if (markForm.chineseName.value != "" && (markForm.chineseName.value.indexOf("]") > -1 || markForm.chineseName.value.indexOf("[") > -1)) {
        alert("标记中文名称不能包含 [ ] 符号！");
        return;
    }
    if (markForm.notes.value != "" && (markForm.notes.value.indexOf("]") > -1 || markForm.notes.value.indexOf("[") > -1)) {
        alert("标记描述不能包含 [ ] 符号！");
        return;
    }

    var attrVal = "[TAG][INCLUDE_FILE]";

    //选中的文件
    if (type == 0) {
        attrVal = attrVal + "[INLUCDE][ID]";
        for (var i = 0; i < markForm.selectedArticle.length - 1; i++) {
            attrVal = attrVal + markForm.selectedArticle.options[i].value + ",";
        }
        attrVal = attrVal + markForm.selectedArticle.options[markForm.selectedArticle.length - 1].value + "[/ID][/INLUCDE]";

        if (markForm.order[0].checked)
            attrVal = attrVal + "[ORDER]0[/ORDER]";
        else if (markForm.order[1].checked)
            attrVal = attrVal + "[ORDER]1[/ORDER]";
        else if (markForm.order[2].checked)
            attrVal = attrVal + "[ORDER]2[/ORDER]";
        else if (markForm.order[3].checked)
            attrVal = attrVal + "[ORDER]3[/ORDER]";
        else if (markForm.order[4].checked)
            attrVal = attrVal + "[ORDER]4[/ORDER]";
    }

    attrVal = attrVal + "[CHINESENAME]" + markForm.chineseName.value + "[/CHINESENAME][NOTES]" + markForm.notes.value + "[/NOTES]";
    attrVal = attrVal + "[/INCLUDE_FILE][/TAG]";

    markForm.contents.value = attrVal;
    markForm.submit();
}

function createCommendArticle(type, columnid) {
    if ((markForm.selectArtList[0].checked && markForm.selectedArticle.length == 0)) {
        alert("至少选择一篇文章！");
        return;
    }
    if (markForm.selectArtList[0].checked && markForm.artNum.value == "") {
        alert("请选择文章数目！");
        return;
    }
    if (markForm.selectArtList[0].checked && !checkNum(markForm.artNum.value)) {
        alert("文章数目应为整数！");
        return;
    }
    if (markForm.listType.selectedIndex == 0) {
        alert("请选择推荐文章样式文件！");
        return;
    }

    var attrVal = "[TAG][COMMEND_ARTICLE]";
    attrVal = attrVal + "[LISTTYPE]" + markForm.listType.value + "[/LISTTYPE]";

    //判断文章选择的方式
    if (markForm.selectArtList[1].checked)
    {
        attrVal = attrVal + "[SELECTWAY]1[/SELECTWAY]";
        if (markForm.artNum.value != "") {
            attrVal = attrVal + "[ARTICLENUM]" + markForm.artNum.value + "[/ARTICLENUM]";
        }
        attrVal = attrVal + "[COLUMNID]" + columnid + "[/COLUMNID]";
        attrVal = attrVal + "[ORDER]" + markForm.order1.value + "," + markForm.order2.value + "[/ORDER]";
    }
    else//选中的文章
    {
        attrVal = attrVal + "[SELECTWAY]0[/SELECTWAY]";
        attrVal = attrVal + "[ARTICLE][ID]";
        for (var i = 0; i < markForm.selectedArticle.length - 1; i++)
        {
            attrVal = attrVal + markForm.selectedArticle.options[i].value + ",";
        }
        attrVal = attrVal + markForm.selectedArticle.options[markForm.selectedArticle.length - 1].value + "[/ID][/ARTICLE]";
        attrVal = attrVal + "[COLUMNID]" + columnid + "[/COLUMNID]";
    }

    //选中的文章
    attrVal = attrVal + "[INNERHTMLFLAG]0[/INNERHTMLFLAG]";
    attrVal = attrVal + "[CHINESENAME]推荐文章[/CHINESENAME][NOTES]null[/NOTES]";
    attrVal = attrVal + "[/COMMEND_ARTICLE][/TAG]";

    markForm.contents.value = attrVal;
    markForm.column.value = columnid;
    markForm.submit();
}
//调查表单
function createDefine()
{
    if (markForm.chineseName.value == "")
    {
        alert("请输入标记中文名称！");
        return;
    }

    if (markForm.chineseName.value != "" && (markForm.chineseName.value.indexOf("]") > -1 || markForm.chineseName.value.indexOf("[") > -1))
    {
        alert("标记中文名称不能包含 [ ] 符号！");
        return;
    }
    if (markForm.notes.value != "" && (markForm.notes.value.indexOf("]") > -1 || markForm.notes.value.indexOf("[") > -1))
    {
        alert("标记描述不能包含 [ ] 符号！");
        return;
    }

    var attrVal = "[TAG][DEFINEINFO]";


    attrVal = attrVal + "[DEFINE][ID]";
    //ID
    attrVal = attrVal + markForm.defineinfo.value + "[/ID][/DEFINE]";
    //问题样式
    attrVal = attrVal + "[WSTYTLE]" + markForm.wstytle.value +"[/WSTYTLE]";
    //答案样式
    attrVal = attrVal + "[ASTYTLE]" + markForm.astytle.value +"[/ASTYTLE]";
    //确认按钮
    attrVal = attrVal + "[SUBMITINFO]" + markForm.t24.value +"[/SUBMITINFO]";
    //确认按钮图片
    if(markForm.okimage.value != "")
    {
        attrVal = attrVal + "[SUBMITPICINFO]" +markForm.okimage.value +"[/SUBMITPICINFO]";
    }
    else
    {
        attrVal = attrVal + "[SUBMITPICINFO][/SUBMITPICINFO]";
    }
    if(markForm.fcheck25.checked) //查看结果按钮
    {
        attrVal = attrVal + "[RESULTINFO]" + markForm.t25.value +"[/RESULTINFO]";
        if(markForm.cancelimage.value != "")
        {
            attrVal = attrVal + "[RESULTPICINFO]" + markForm.cancelimage.value +"[/RESULTPICINFO]";
        }
        else
        {
            attrVal = attrVal + "[RESULTPICINFO][/RESULTPICINFO]";
        }
    }
    else
    {
        attrVal = attrVal + "[RESULTINFO][/RESULTINFO]";
        attrVal = attrVal + "[RESULTPICINFO][/RESULTPICINFO]";
    }

    if (markForm.yangshi[0].checked)
        attrVal = attrVal + "[YANGSHI]0[/YANGSHI]";
    else if (markForm.yangshi[1].checked)
        attrVal = attrVal + "[YANGSHI]1[/YANGSHI]";
    if(markForm.userinfo[0].checked)
        attrVal = attrVal + "[USERINFO]0[/USERINFO]";
    else if(markForm.userinfo[1].checked)
        attrVal = attrVal + "[USERINFO]1[/USERINFO]";
    attrVal = attrVal + "[CHINESENAME]" + markForm.chineseName.value + "[/CHINESENAME][NOTES]" + markForm.notes.value + "[/NOTES]";
    attrVal = attrVal + "[/DEFINEINFO][/TAG]";

    markForm.contents.value = attrVal;
    markForm.submit();
}