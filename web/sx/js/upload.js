function onchange_select(columnID){
    $("#column").val(columnID);
    $("#mySelect").val(columnID);
    if(columnID == 65677 || columnID== -1){
        $("#model").hide();
        $("#model a").attr("href","");
    }
    if(columnID == 65654){

        $("#model").show();
        $("#model a").attr("href","/images/out-case.docx");
    }
    if(columnID == 65655){
        $("#model").show();
        $("#model a").attr("href","/images/in-case.docx");
    }
    if(columnID == 65657){
        $("#model").show();
        $("#model a").attr("href","/images/solve.docx");
    }
    $.ajax({
        type: "post",
        url: "/sitesearch/Upload.action",
        data: {"getColumn": "","columnID":columnID },
        async: false,    // 使用同步操作
        success: function (data) {
            if (data!==null){
               $("#isDefine").val(data.isDefineAttr);
               $("#fileDir").val(data.dirName);
            }
        }
    });


    $.ajax({
        type: "post",
        url: "/sitesearch/Upload.action",
        data: {"getExtendAttrForArticle": "","columnID":columnID },
        async: false,    // 使用同步操作
        success: function (data) {
            if (data!==null){
                var html = data;
                //alert(html);
                $("#AttrList").html(html);
            }
        }
    });
}

function doSelect(ename){
    var selectval="";
    $.each($('#check'+ename+' input:checkbox:checked'),function(){
        selectval = selectval + $(this).val() +",";
       /* window.alert("你选了："+
            $('input[type=checkbox]:checked').length+"个，其中有："+$(this).val());*/
    });
    if (selectval.length>1)
        selectval = selectval.substring(0,selectval.length-1);
    $("#"+ename).val(selectval);
    //alert(selectval);
 }
