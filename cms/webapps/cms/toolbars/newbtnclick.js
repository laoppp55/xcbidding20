function edit_src(formname)
{
    if (eval(formname).cname.value == "")
    {
        alert("������ģ���������ƣ�");
        return;
    }
    if (eval(formname).modelname.value == "")
    {
        alert("������ģ���ļ�����");
        return;
    }
    eval(formname).content1.value = wmp.GetDocumentHtml();
    eval(formname).submit();
    return true;
}

function MarkName_Add(columnID,sitename)
{
    
    var returnvalue = "";
    var marksname = "";
    var isButton = "";

    var isMSIE = (navigator.appName == "Microsoft Internet Explorer");
    //�ж������
    var buf = document.createForm.MarkName.value;
    var mark_type=0;
    var mark_value="";
    posi = buf.lastIndexOf("-");
    if (posi > -1)  {
        mark_value = buf.substring(0,posi);
        mark_type = buf.substring(posi+1);
    } else {
        mark_value = buf;
    }

    if (mark_value == "ARTICLE_LIST") {
        marksname = "�����б�";
        winStr = "addArticleList.jsp?column=" + columnID;
        if (isMSIE) {
            returnvalue = showModalDialog(winStr, "", "font-family:Verdana; font-size:12; dialogWidth:72em; dialogHeight:54em;status:no");
        } else {
            win = window.open(winStr, "�����б�", "font-family=Verdana,font-size=12,width=880,height=600,status=no");
            win.focus();
        }
    }
    else if (mark_value == "COMMEND_ARTICLE") {
        marksname = "�Ƽ������б�";
        winStr = "commendarticle.jsp?column="+columnID;
        if (isMSIE) {
            returnvalue = showModalDialog(winStr,"","font-family:Verdana; font-size:12; dialogWidth:70em; dialogHeight:55em;status:no");
        } else {
            win = window.open(winStr, "�Ƽ������б�", "font-family=Verdana,font-size=12,width=880,height=600,status=no");
            win.focus();
        }
    }
    else if (mark_value == "SUBARTICLE_LIST") {
        marksname = "�������б�";
        winStr = "addArticleList.jsp?type=1&column=" + columnID;
        if (isMSIE) {
            returnvalue = showModalDialog(winStr, "", "font-family:Verdana; font-size:12; dialogWidth:72em; dialogHeight:54em;status:no");
        } else {
            win = window.open(winStr, "�������б�", "font-family=Verdana,font-size=12,width=880,height=600,status=no");
            win.focus();
        }
    }
    else if (mark_value == "BROTHER_LIST") {
        marksname = "�ֵ������б�";
        winStr = "addArticleList.jsp?type=2&column=" + columnID;
        if (isMSIE) {
            returnvalue = showModalDialog(winStr, "", "font-family:Verdana; font-size:12; dialogWidth:72em; dialogHeight:54em;status:no");
        } else {
            win = window.open(winStr, "�ֵ������б�", "font-family=Verdana,font-size=12,width=880,height=600,status=no");
            win.focus();
        }
    }
    else if (mark_value == "ARTICLE_COUNT") {
        marksname = "��������";
        winStr = "addArticleCountList.jsp";
        if (isMSIE) {
            returnvalue = showModalDialog(winStr, "", "font-family:Verdana; font-size:12; dialogWidth:50em; dialogHeight:35em;status:no");
        } else {
            win = window.open(winStr, "��������", "font-family=Verdana,font-size=12,width=600,height=350,status=no");
            win.focus();
        }
    }
    else if (mark_value == "SUBARTICLE_COUNT") {
        marksname = "����������";
        winStr = "addSubArticleCountList.jsp?column="+columnID;
        if (isMSIE) {
            returnvalue = showModalDialog(winStr, "", "font-family:Verdana; font-size:12; dialogWidth:50em; dialogHeight:35em;status:no");
        } else {
            win = window.open(winStr, "����������", "font-family=Verdana,font-size=12,width=600,height=350,status=no");
            win.focus();
        }
    }
    else if (mark_value == "COLUMN_LIST") {
        marksname = "��Ŀ�б�";
        winStr = "addColumnList.jsp?column=" + columnID;
        if (isMSIE) {
            returnvalue = showModalDialog(winStr, "", "font-family:Verdana; font-size:12; dialogWidth:780px;dialogHeight:550px;status:no");
        } else {
            win = window.open(winStr, "��Ŀ�б�", "font-family=Verdana,font-size=12,width=800,height=600,status=no");
            win.focus();
        }
    }
    else if (mark_value == "SUBCOLUMN_LIST") {
        marksname = "����Ŀ�б�";
        winStr = "addSubColumnList.jsp?type=1&column=" + columnID;
        if (isMSIE) {
            returnvalue = showModalDialog(winStr, "", "font-family:Verdana; font-size:12; dialogWidth:56em; dialogHeight:35em;status:no");
        } else {
            win = window.open(winStr, "����Ŀ�б�", "font-family=Verdana,font-size=12,width=800,height=600,status=no");
            win.focus();
        }
    }
    else if(mark_value == "INCLUDE_FILE"){
         marksname = "�����ļ�";
        winStr = "add_include.jsp?column="+columnID;
        if (isMSIE) {
            returnvalue = showModalDialog(winStr, "", "font-family:Verdana; font-size:12; dialogWidth:56em; dialogHeight:35em;status:no");
        } else {
            win = window.open(winStr, "", "font-family=Verdana,font-size=12,width=800,height=600,status=no");
            win.focus();
        }
    }
    else if (mark_value == "CHINESE_PATH") {
        marksname = "����·��";
        winStr = "addPath.jsp?type=0";
        if (isMSIE) {
            returnvalue = showModalDialog(winStr, "", "font-family:Verdana; font-size:12; dialogWidth:32em; dialogHeight:18em; status:no");
            if (returnvalue != "" && returnvalue != "0")
                returnvalue = "[TAG][CHINESE_PATH]" + returnvalue + "[/CHINESE_PATH][/TAG]";
        } else {
            win = window.open(winStr, "", "font-family=Verdana,font-size=12,width=360px,height=180px,status=no");
            win.focus();
        }
    }
    //ǰ̨ͼƬ�����������
     else if (mark_value == "IMGZUHECONTENT") {
        marksname = "ǰ̨ͼƬ�������";


         var oEditor1 = window.parent.FCKeditorAPI.GetInstance("content");
         var content= oEditor1.GetXHTML(true);
         var forms=content.split("[IMGZUHECONTENT]");
         
          winStr = "imgzuhecontent.jsp?order="+forms.length;
        if (isMSIE) {
            returnvalue = showModalDialog(winStr, window, "font-family:Verdana; font-size:12; dialogWidth:32em; dialogHeight:18sem; status:no");
            if (returnvalue != "" && returnvalue != "0")
                returnvalue = "[TAGA][IMGZUHECONTENT]" + returnvalue + "[/IMGZUHECONTENT][/TAGA]";
        } else {
            win = window.open(winStr, "ǰ̨ͼƬ�������", "font-family=Verdana,font-size=12,width=360px,height=180px,status=no");
            win.focus();
        }
    }
     else if (mark_value == "TEXTZUHECONTENT") {
        marksname = "ǰ̨�����������";

         var oEditor1 = window.parent.FCKeditorAPI.GetInstance("content");
         var content= oEditor1.GetXHTML(true);
        
         var formsf=content.split("[TEXTZUHECONTENT]");                         
         winStr = "textzuhecontent.jsp?order="+formsf.length;
        if (isMSIE) {
            returnvalue = showModalDialog(winStr, window, "font-family:Verdana; font-size:12; dialogWidth:56em; dialogHeight:35em; status:no");
            if (returnvalue != "" && returnvalue != "0")
                returnvalue = "[TAGA][TEXTZUHECONTENT]" + returnvalue + "[/TEXTZUHECONTENT][/TAGA]";
        } else {
            win = window.open(winStr, "ǰ̨�����������", "font-family=Verdana,font-size=12,width=360px,height=180px,status=no");
            win.focus();
        }
    }
    else if (mark_value == "SEECOOKIE") {
        marksname = "������";
         winStr = "addSeeCookietag.jsp";
        if (isMSIE) {
            returnvalue = showModalDialog(winStr, window, "font-family:Verdana; font-size:12; dialogWidth:56em; dialogHeight:35em; status:no");
            if (returnvalue != "" && returnvalue != "0")
                returnvalue =returnvalue;
        } else {
            win = window.open(winStr, "������", "font-family=Verdana,font-size=12,width=360px,height=180px,status=no");
            win.focus();
        }
    }
    //---------------------
    else if (mark_value == "ENGLISH_PATH") {
        marksname = "Ӣ��·��";
        winStr = "addPath.jsp?type=1";
        if (isMSIE) {
            returnvalue = showModalDialog(winStr, "", "font-family:Verdana; font-size:12; dialogWidth:32em; dialogHeight:18em; status:no");
            if (returnvalue != "" && returnvalue != "0")
                returnvalue = "[TAG][ENGLISH_PATH]" + returnvalue + "[/ENGLISH_PATH][/TAG]";
        } else {
            win = window.open(winStr, "Ӣ��·��", "font-family=Verdana,font-size=12,width=360px,height=180px,status=no");
            win.focus();
        }
    }
    else if (mark_value == "PREV_ARTICLE") {
        marksname = "��һƪ";
        var winStr = "addNextArticle.jsp?type=0";
        if (isMSIE) {
            returnvalue = showModalDialog(winStr, "", "font-family:Verdana;font-size:12;dialogWidth:32em;dialogHeight:18em;status:no");
            if (returnvalue != "" && returnvalue != "0")
                returnvalue = "[TAG][PREV_ARTICLE]" + returnvalue + "[/PREV_ARTICLE][/TAG]";
        } else {
            win = window.open(winStr, "��һƪ", "font-family=Verdana,font-size=12,width=360px,height=180px,status=no");
            win.focus();
        }
    }
    else if (mark_value == "NEXT_ARTICLE") {
        marksname = "��һƪ";
        var winStr = "addNextArticle.jsp?type=1";
        if (isMSIE) {
            returnvalue = showModalDialog(winStr, "", "font-family:Verdana;font-size:12;dialogWidth:32em;dialogHeight:18em;status:no");
            if (returnvalue != "" && returnvalue != "0")
                returnvalue = "[TAG][NEXT_ARTICLE]" + returnvalue + "[/NEXT_ARTICLE][/TAG]";
        } else {
            win = window.open(winStr, "��һƪ", "font-family=Verdana,font-size=12,width=360px,height=180px,status=no");
            win.focus();
        }
    }
    else if (mark_value == "RELATED_ARTICLE") {
        marksname = "�������";
        winStr = "addRelateList.jsp?column=" + columnID;
        if (isMSIE) {
            returnvalue = showModalDialog(winStr, "", "font-family:Verdana; font-size:12; dialogWidth:578px;dialogHeight:385px;status:no");
        } else {
            win = window.open(winStr, "�������", "font-family=Verdana,font-size=12,width=600px,height=400px,status=no");
            win.focus();
        }
    }
    else if (mark_value == "TOP_STORIES") {
        marksname = "�ȵ�����";
        winStr = "../templatex/topStories.jsp?column=" + columnID;
        if (isMSIE) {
            returnvalue = showModalDialog(winStr, "", "font-family:Verdana; font-size:12; dialogWidth:70em; dialogHeight:55em;status:no");
        } else {
            win = window.open(winStr, "�ȵ�����", "font-family=Verdana,font-size=12,width=800px,height=550px,status=no");
            win.focus();
        }
    }
    else if (mark_value == "ARTICLE_CONTENT") {
        marksname = "��������";
        isButton = "1";
        returnvalue = "[TAG][ARTICLE_CONTENT][/ARTICLE_CONTENT][/TAG]";
    }
    else if (mark_value == "ARTICLE_MAINTITLE") {
        marksname = "���±���";
        isButton = "1";
        returnvalue = "[TAG][ARTICLE_MAINTITLE][/ARTICLE_MAINTITLE][/TAG]";
    }
    else if (mark_value == "ARTICLE_VICETITLE") {
        marksname = "���¸�����";
        isButton = "1";
        returnvalue = "[TAG][ARTICLE_VICETITLE][/ARTICLE_VICETITLE][/TAG]";
    }
    else if (mark_value == "ARTICLE_KEYWORD") {
        marksname = "���¹ؼ���";
        isButton = "1";
        returnvalue = "[TAG][ARTICLE_KEYWORD][/ARTICLE_KEYWORD][/TAG]";
    }
    else if (mark_value == "ARTICLE_PT") {
        marksname = "����ʱ��";
        winStr = "addArticlePt.jsp";
        if (isMSIE) {
            returnvalue = showModalDialog(winStr, "", "font-family:Verdana; font-size:12; dialogWidth:300px;dialogHeight:120px;status:no");
        } else {
            win = window.open(winStr, "����ʱ��", "font-family=Verdana,font-size=12,width=300px,height=120px,status=no");
            win.focus();
        }
    }
    else if (mark_value == "ARTICLE_AUTHOR") {
        marksname = "��������";
        isButton = "1";
        returnvalue = "[TAG][ARTICLE_AUTHOR][/ARTICLE_AUTHOR][/TAG]";
    }
    else if (mark_value == "ARTICLE_SUMMARY") {
        marksname = "���¸���";
        isButton = "1";
        returnvalue = "[TAG][ARTICLE_SUMMARY][/ARTICLE_SUMMARY][/TAG]";
    }
    else if (mark_value == "ARTICLE_SOURCE") {
        marksname = "������Դ";
        isButton = "1";
        returnvalue = "[TAG][ARTICLE_SOURCE][/ARTICLE_SOURCE][/TAG]";
    }
    else if (mark_value == "COLUMNNAME") {
        marksname = "��Ŀ����";
        isButton = "1";
        returnvalue = "[TAG][COLUMNNAME][/COLUMNNAME][/TAG]";
    }
    else if (mark_value == "PARENT_COLUMNNAME") {
        marksname = "����Ŀ����";
        isButton = "1";
        returnvalue = "[TAG][PARENT_COLUMNNAME][/PARENT_COLUMNNAME][/TAG]";
    }
    else if (mark_value == "NAVBAR")
    {
        marksname = "������";
        winStr = "addNavBar.jsp?type=0";
        if (isMSIE) {
            returnvalue = showModalDialog(winStr, "", "font-family:Verdana; font-size:12; dialogWidth:32em; dialogHeight:18em; status:no");
            if (returnvalue != "" && returnvalue != "0")
                returnvalue = "[TAG][NAVBAR]" + returnvalue + "[/NAVBAR][/TAG]";
        } else {
            win = window.open(winStr, "������", "font-family=Verdana,font-size=12,width=380px,height=180px,status=no");
            win.focus();
        }
    }
    else if (mark_value == "PAGINATION")
    {
        marksname = "��ҳ���";
        winStr = "addNavBar.jsp?type=1";
        if (isMSIE) {
            returnvalue = showModalDialog(winStr, "", "font-family:Verdana; font-size:12; dialogWidth:32em; dialogHeight:18em; status:no");
            if (returnvalue != "" && returnvalue != "0")
                returnvalue = "[TAG][PAGINATION]" + returnvalue + "[/PAGINATION][/TAG]";
        } else {
            win = window.open(winStr, "��ҳ���", "font-family=Verdana,font-size=12,width=360px,height=180px,status=no");
            win.focus();
        }
    }
    else if (mark_value == 'ARTICLE_TYPE')
    {
        marksname = "���·�����";
        winStr = "addArticleType.jsp?column="+columnID;
        if (isMSIE) {
            returnvalue = showModalDialog(winStr, "", "font-family:Verdana; font-size:12; dialogWidth:32em; dialogHeight:18em; status:no");
        } else {
            win = window.open(winStr, "���·�����", "font-family=Verdana,font-size=12,width=360px,height=180px,status=no");
            win.focus();
        }
        isButton = "1";
    }  else if (mark_value == 'XUAN_IMAGES') {
        marksname = "ͼƬ��Ч";
        winStr = "addXuanImagesFrame.jsp?column="+columnID;
        if (isMSIE) {
            returnvalue = showModalDialog(winStr, "", "font-family:Verdana; font-size:12; dialogWidth:70em; dialogHeight:40em; status:no");
        } else {
            win = window.open(winStr, "ͼƬ��Ч", "font-family=Verdana,font-size=12,width=360px,height=180px,status=no");
            win.focus();
        }
    } else if (mark_value == 'TURN_PIC') {
        marksname = "����ͼƬ��Ч";
        winStr = "addArticleXuanImagesFrame.jsp?column="+columnID;
        if (isMSIE) {
            returnvalue = showModalDialog(winStr, "", "font-family:Verdana; font-size:12; dialogWidth:70em; dialogHeight:40em; status:no");
        } else {
            win = window.open(winStr, "����ͼƬ��Ч", "font-family=Verdana,font-size=12,width=360px,height=180px,status=no");
            win.focus();
        }
    } else if (mark_value == 'SEARCH_FORM') {
        marksname = "��ѯ��";
        returnvalue = "<table border=\"0\">" +
                      "<form action=\"/" + sitename + "/_prog/search.jsp\" method=\"post\" name=\"searchForm\">" +
                      "<tr>" +
                      "<td><input name=\"searchcontent\" /></td>" +
                      "<td><input type=\"image\" alt=\"\" src=\"/images/button-search.gif\" border=\"0\" /></td>" +
                      "</tr>" +
                      "</form>" +
                      "</table>";
        isButton = "1";
    } else if (mark_value == 'LOGIN_FORM') {
        marksname = "��¼��";
        winStr = "addUserLoginFormFrame.jsp?column="+columnID;
        if (isMSIE) {
            returnvalue = showModalDialog(winStr, "", "font-family:Verdana; font-size:12; dialogWidth:80em; dialogHeight:40em; status:no");
        } else {
            win = window.open(winStr, "��¼��", "font-family=Verdana,font-size=12,width=560px,height=180px,status=no");
            win.focus();
        }
    }
    else if (mark_value == 'PROGRRAMLOGIN_FORM') {
        marksname = "����ģ���¼��";
        winStr = "addUserProgramLoginFormFrame.jsp?column="+columnID;
        if (isMSIE) {
            returnvalue = showModalDialog(winStr, "", "font-family:Verdana; font-size:12; dialogWidth:80em; dialogHeight:40em; status:no");
        } else {
            win = window.open(winStr, "����ģ���¼��", "font-family=Verdana,font-size=12,width=560px,height=180px,status=no");
            win.focus();
        }
    }else if (mark_value == 'USER_LOGIN_DISPLAY') {
        marksname = "�û���¼��ʾ";
        winStr = "addUserLoginFrame.jsp?column="+columnID;
        if (isMSIE) {
            returnvalue = showModalDialog(winStr, "", "font-family:Verdana; font-size:12; dialogWidth:60em; dialogHeight:40em; status:no");
           if (returnvalue==undefined) document.createForm.MarkName.value = "NO_SELECT";
        } else {
            win = window.open(winStr, "�û���¼��ʾ", "font-family=Verdana,font-size=12,width=560px,height=180px,status=no");
            win.focus();
        }
    }
    else if (mark_value == 'DEFINEINFO_FORM') {
        marksname = "�����";
        winStr = "addUserDefinenFormFrame.jsp?column="+columnID;
        if (isMSIE) {
            returnvalue = showModalDialog(winStr, "", "font-family:Verdana; font-size:12; dialogWidth:40em; dialogHeight:40em; status:no");
        } else {
            win = window.open(winStr, "�����", "font-family=Verdana,font-size=12,width=560px,height=180px,status=no");
            win.focus();
        }
    }
    else if (mark_value == 'LEAVEMESSAGE') {
        marksname = "�û����Ա�";
        winStr = "addUserLeavemessageFormFrame.jsp?column="+columnID;
        if (isMSIE) {
            returnvalue = showModalDialog(winStr, "", "font-family:Verdana; font-size:12; dialogWidth:80em; dialogHeight:60em; status:no");
           if (returnvalue==undefined) document.createForm.MarkName.value = "NO_SELECT";
        } else {
            win = window.open(winStr, "�û����Ա�", "font-family=Verdana,font-size=12,width=560px,height=180px,status=no");
            win.focus();
        }
    }
    else if (mark_value == 'LEAVEMESSAGELIST') {
        marksname = "�û������б�";
        winStr = "addUserLeavemessageListFormFrame.jsp?column="+columnID;
        if (isMSIE) {
            returnvalue = showModalDialog(winStr, "", "font-family:Verdana; font-size:12; dialogWidth:80em; dialogHeight:60em; status:no");
           if (returnvalue==undefined) document.createForm.MarkName.value = "NO_SELECT";
        } else {
            win = window.open(winStr, "�û������б�", "font-family=Verdana,font-size=12,width=560px,height=180px,status=no");
            win.focus();
        }
    }
    else if (mark_value == 'ARTICLE_COMMENT') {
        //�ж���ҳ�����Ƿ��Ѿ������г����ǣ�������û��Ƿ�Ҫ�滻���еĳ����ǣ��û�ѡ���滻�������³������滻�ϵĳ����ǣ������˳�
        marksname = "��������";
        var mname_in_thepage = includeTheProgramTag(marksname);
        if (mname_in_thepage == "[" + marksname + "]")
            alert(mname_in_thepage + "����Ѿ����ڣ������Ҫ�޸ģ���༭�ñ��");
        else if (mname_in_thepage == ""){
            winStr = "addArticleCommentFrame.jsp?column="+columnID;
            if (isMSIE) {
                returnvalue = showModalDialog(winStr, "", "font-family:Verdana; font-size:12; dialogWidth:80em; dialogHeight:40em; status:no");
            } else {
                win = window.open(winStr, "��������", "font-family=Verdana,font-size=12,width=560px,height=180px,status=no");
                win.focus();
            }
        } else {
            alert("��ҳ�Ѿ����ڳ�����" + mname_in_thepage + "������ɾ���Ѿ����ڵĳ����ǣ�Ȼ��������µĳ�����");
        }
    } else if (mark_value == 'FEEDBACK') {
        //�ж���ҳ�����Ƿ��Ѿ������г����ǣ�������û��Ƿ�Ҫ�滻���еĳ����ǣ��û�ѡ���滻�������³������滻�ϵĳ����ǣ������˳�
        marksname = "��Ϣ����";
        var mname_in_thepage = includeTheProgramTag(marksname);
        if (mname_in_thepage == "[" + marksname + "]")
            alert(mname_in_thepage + "����Ѿ����ڣ������Ҫ�޸ģ���༭�ñ��");
        else if (mname_in_thepage == ""){
            winStr = "addFeedbackFrame.jsp?column="+columnID;
            if (isMSIE) {
                returnvalue = showModalDialog(winStr, "", "font-family:Verdana; font-size:12; dialogWidth:80em; dialogHeight:40em; status:no");
            } else {
                win = window.open(winStr, "��Ϣ����", "font-family=Verdana,font-size=12,width=560px,height=180px,status=no");
                win.focus();
            }
        } else {
            alert("��ҳ�Ѿ����ڳ�����" + mname_in_thepage + "������ɾ���Ѿ����ڵĳ����ǣ�Ȼ��������µĳ�����");
        }
    } else if (mark_value == 'LEAVE_MESSAGE') {
        //�ж���ҳ�����Ƿ��Ѿ������г����ǣ�������û��Ƿ�Ҫ�滻���еĳ����ǣ��û�ѡ���滻�������³������滻�ϵĳ����ǣ������˳�
        marksname = "�û�����";
        var mname_in_thepage = includeTheProgramTag(marksname);
        if (mname_in_thepage == "[" + marksname + "]")
            alert(mname_in_thepage + "����Ѿ����ڣ������Ҫ�޸ģ���༭�ñ��");
        else if (mname_in_thepage == ""){
            winStr = "addLeaveMessageFrame.jsp?column="+columnID;
            if (isMSIE) {
                returnvalue = showModalDialog(winStr, "", "font-family:Verdana; font-size:12; dialogWidth:80em; dialogHeight:40em; status:no");
            } else {
                win = window.open(winStr, "�û�����", "font-family=Verdana,font-size=12,width=560px,height=180px,status=no");
                win.focus();
            }
        } else {
            alert("��ҳ�Ѿ����ڳ�����" + mname_in_thepage + "������ɾ���Ѿ����ڵĳ����ǣ�Ȼ��������µĳ�����");
        }
    } else if (mark_value == 'REGISTER_RESULT') {
        //�ж���ҳ�����Ƿ��Ѿ������г����ǣ�������û��Ƿ�Ҫ�滻���еĳ����ǣ��û�ѡ���滻�������³������滻�ϵĳ����ǣ������˳�
        marksname = "�û�ע��";
        var mname_in_thepage = includeTheProgramTag(marksname);
        if (mname_in_thepage == "[" + marksname + "]")
            alert(mname_in_thepage + "����Ѿ����ڣ������Ҫ�޸ģ���༭�ñ��");
        else if (mname_in_thepage == ""){
            winStr = "addUserRegisterFrame.jsp?column="+columnID;
            if (isMSIE) {
                returnvalue = showModalDialog(winStr, "", "font-family:Verdana; font-size:12; dialogWidth:80em; dialogHeight:40em; status:no");
            } else {
                win = window.open(winStr, "�û�ע��", "font-family=Verdana,font-size=12,width=560px,height=180px,status=no");
                win.focus();
            }
        } else {
            alert("��ҳ�Ѿ����ڳ�����" + mname_in_thepage + "������ɾ���Ѿ����ڵĳ����ǣ�Ȼ��������µĳ�����");
        }
    } else if (mark_value == 'USER_LOGIN_DISPLAY') {
        //�ж���ҳ�����Ƿ��Ѿ������г����ǣ�������û��Ƿ�Ҫ�滻���еĳ����ǣ��û�ѡ���滻�������³������滻�ϵĳ����ǣ������˳�
        marksname = "�û���¼��ʾ";
        /*var mname_in_thepage = includeTheProgramTag(marksname);
        if (mname_in_thepage == "[" + marksname + "]")
            alert(mname_in_thepage + "����Ѿ����ڣ������Ҫ�޸ģ���༭�ñ��");
        else if (mname_in_thepage == ""){*/
            winStr = "addUserLoginFrame.jsp?column="+columnID;
            if (isMSIE) {
                returnvalue = showModalDialog(winStr, "", "font-family:Verdana; font-size:12; dialogWidth:80em; dialogHeight:40em; status:no");
            } else {
                win = window.open(winStr, "�û���¼��ʾ", "font-family=Verdana,font-size=12,width=560px,height=180px,status=no");
                win.focus();
            }
        /*} else {
            alert("��ҳ�Ѿ����ڳ�����" + mname_in_thepage + "������ɾ���Ѿ����ڵĳ����ǣ�Ȼ��������µĳ�����");
        }*/
    } else if (mark_value == 'UPDATEREG') {
        //�ж���ҳ�����Ƿ��Ѿ������г����ǣ�������û��Ƿ�Ҫ�滻���еĳ����ǣ��û�ѡ���滻�������³������滻�ϵĳ����ǣ������˳�
        marksname = "�޸�ע��";
        var mname_in_thepage = includeTheProgramTag(marksname);
        if (mname_in_thepage == "[" + marksname + "]")
            alert(mname_in_thepage + "����Ѿ����ڣ������Ҫ�޸ģ���༭�ñ��");
        else if (mname_in_thepage == ""){
            winStr = "addUpdateRegFrame.jsp?column="+columnID;
            if (isMSIE) {
                returnvalue = showModalDialog(winStr, "", "font-family:Verdana; font-size:12; dialogWidth:80em; dialogHeight:40em; status:no");
            } else {
                win = window.open(winStr, "�޸�ע��", "font-family=Verdana,font-size=12,width=560px,height=180px,status=no");
                win.focus();
            }
        } else {
            alert("��ҳ�Ѿ����ڳ�����" + mname_in_thepage + "������ɾ���Ѿ����ڵĳ����ǣ�Ȼ��������µĳ�����");
        }
    } else if (mark_value == 'SEARCH_RESULT') {
        //�ж���ҳ�����Ƿ��Ѿ������г����ǣ�������û��Ƿ�Ҫ�滻���еĳ����ǣ��û�ѡ���滻�������³������滻�ϵĳ����ǣ������˳�
        marksname = "��Ϣ����";
        var mname_in_thepage = includeTheProgramTag(marksname);
        if (mname_in_thepage == "[" + marksname + "]")
            alert(mname_in_thepage + "����Ѿ����ڣ������Ҫ�޸ģ���༭�ñ��");
        else if (mname_in_thepage == ""){
            winStr = "addSearchFrame.jsp?column="+columnID;
            if (isMSIE) {
                returnvalue = showModalDialog(winStr, "", "font-family:Verdana; font-size:12; dialogWidth:80em; dialogHeight:40em; status:no");
            } else {
                win = window.open(winStr, "��Ϣ����", "font-family=Verdana,font-size=12,width=560px,height=180px,status=no");
                win.focus();
            }
        } else {
            alert("��ҳ�Ѿ����ڳ�����" + mname_in_thepage + "������ɾ���Ѿ����ڵĳ����ǣ�Ȼ��������µĳ�����");
        }
    } else if (mark_value == 'SHOPPINGCAR_RESULT') {
        //�ж���ҳ�����Ƿ��Ѿ������г����ǣ�������û��Ƿ�Ҫ�滻���еĳ����ǣ��û�ѡ���滻�������³������滻�ϵĳ����ǣ������˳�
        marksname = "���ﳵ";
        var mname_in_thepage = includeTheProgramTag(marksname);
        if (mname_in_thepage == "[" + marksname + "]")
            alert(mname_in_thepage + "����Ѿ����ڣ������Ҫ�޸ģ���༭�ñ��");
        else if (mname_in_thepage == ""){
            winStr = "addShoppingcarFrame.jsp?column="+columnID;
            if (isMSIE) {
                returnvalue = showModalDialog(winStr, "", "font-family:Verdana; font-size:12; dialogWidth:80em; dialogHeight:40em; status:no");
            } else {
                win = window.open(winStr, "���ﳵ", "font-family=Verdana,font-size=12,width=560px,height=180px,status=no");
                win.focus();
            }
        } else {
            alert("��ҳ�Ѿ����ڳ�����" + mname_in_thepage + "������ɾ���Ѿ����ڵĳ����ǣ�Ȼ��������µĳ�����");
        }
    } else if (mark_value == 'ORDER_RESULT') {
        //�ж���ҳ�����Ƿ��Ѿ������г����ǣ�������û��Ƿ�Ҫ�滻���еĳ����ǣ��û�ѡ���滻�������³������滻�ϵĳ����ǣ������˳�
        marksname = "��������";
        var mname_in_thepage = includeTheProgramTag(marksname);
        if (mname_in_thepage == "[" + marksname + "]")
            alert(mname_in_thepage + "����Ѿ����ڣ������Ҫ�޸ģ���༭�ñ��");
        else if (mname_in_thepage == ""){
            winStr = "addOrderGenerateFrame.jsp?column="+columnID;
            if (isMSIE) {
                returnvalue = showModalDialog(winStr, "", "font-family:Verdana; font-size:12; dialogWidth:80em; dialogHeight:50em; status:no");
            } else {
                win = window.open(winStr, "��������", "font-family=Verdana,font-size=12,width=600px,height=200px,status=no");
                win.focus();
            }
        } else {
            alert("��ҳ�Ѿ����ڳ�����" + mname_in_thepage + "������ɾ���Ѿ����ڵĳ����ǣ�Ȼ��������µĳ�����");
        }
    } else if (mark_value == 'ORDER_REDISPLAY') {
        //�ж���ҳ�����Ƿ��Ѿ������г����ǣ�������û��Ƿ�Ҫ�滻���еĳ����ǣ��û�ѡ���滻�������³������滻�ϵĳ����ǣ������˳�
        marksname = "��������";
        var mname_in_thepage = includeTheProgramTag(marksname);
        if (mname_in_thepage == "[" + marksname + "]")
            alert(mname_in_thepage + "����Ѿ����ڣ������Ҫ�޸ģ���༭�ñ��");
        else if (mname_in_thepage == ""){
            winStr = "addOrderDisplayFrame.jsp?column="+columnID;
            if (isMSIE) {
                returnvalue = showModalDialog(winStr, "", "font-family:Verdana; font-size:12; dialogWidth:80em; dialogHeight:40em; status:no");
            } else {
                win = window.open(winStr, "��������", "font-family=Verdana,font-size=12,width=560px,height=180px,status=no");
                win.focus();
            }
        } else {
            alert("��ҳ�Ѿ����ڳ�����" + mname_in_thepage + "������ɾ���Ѿ����ڵĳ����ǣ�Ȼ��������µĳ�����");
        }
    } else if (mark_value == 'ORDERSEARCH_RESULT') {
        //�ж���ҳ�����Ƿ��Ѿ������г����ǣ�������û��Ƿ�Ҫ�滻���еĳ����ǣ��û�ѡ���滻�������³������滻�ϵĳ����ǣ������˳�
        marksname = "������ѯ";
        var mname_in_thepage = includeTheProgramTag(marksname);
        if (mname_in_thepage == "[" + marksname + "]")
            alert(mname_in_thepage + "����Ѿ����ڣ������Ҫ�޸ģ���༭�ñ��");
        else if (mname_in_thepage == ""){
            winStr = "addOrderSearchFrame.jsp?column="+columnID;
            if (isMSIE) {
                returnvalue = showModalDialog(winStr, "", "font-family:Verdana; font-size:12; dialogWidth:80em; dialogHeight:40em; status:no");
            } else {
                win = window.open(winStr, "������ѯ", "font-family=Verdana,font-size=12,width=560px,height=180px,status=no");
                win.focus();
            }
        } else {
            alert("��ҳ�Ѿ����ڳ�����" + mname_in_thepage + "������ɾ���Ѿ����ڵĳ����ǣ�Ȼ��������µĳ�����");
        }
    } else if (mark_value == 'ORDERSEARCH_DETAIL') {
        //�ж���ҳ�����Ƿ��Ѿ������г����ǣ�������û��Ƿ�Ҫ�滻���еĳ����ǣ��û�ѡ���滻�������³������滻�ϵĳ����ǣ������˳�
        marksname = "������ϸ��ѯ";
        var mname_in_thepage = includeTheProgramTag(marksname);
        if (mname_in_thepage == "[" + marksname + "]")
            alert(mname_in_thepage + "����Ѿ����ڣ������Ҫ�޸ģ���༭�ñ��");
        else if (mname_in_thepage == ""){
            winStr = "addOrderDetailSearchFrame.jsp?column="+columnID;
            if (isMSIE) {
                returnvalue = showModalDialog(winStr, "", "font-family:Verdana; font-size:12; dialogWidth:80em; dialogHeight:40em; status:no");
            } else {
                win = window.open(winStr, "������ϸ��ѯ", "font-family=Verdana,font-size=12,width=560px,height=180px,status=no");
                win.focus();
            }
        } else {
            alert("��ҳ�Ѿ����ڳ�����" + mname_in_thepage + "������ɾ���Ѿ����ڵĳ����ǣ�Ȼ��������µĳ�����");
        }
    }  else if (mark_value == 'SELF_DEFINE_FORM') {
        //�ж���ҳ�����Ƿ��Ѿ������г����ǣ�������û��Ƿ�Ҫ�滻���еĳ����ǣ��û�ѡ���滻�������³������滻�ϵĳ����ǣ������˳�
        marksname = "�Զ����";
        //var mname_in_thepage = includeTheProgramTag(marksname);
        winStr = "selfdefineform.jsp?column="+columnID;
        if (isMSIE) {
            isButton = "1";                          //�����밴ť��ʽ�����ǲ���HTMLԴ����
            returnvalue = showModalDialog(winStr, "", "font-family:Verdana; font-size:12; dialogWidth:70em; dialogHeight:40em; status:no");
            returnvalue = "<form name='myform' action='my.jsp' method='post'>" +
                          "<input type='hidden' name='doCreate' value='true'>" +
                          "</form>"
            document.createForm.textvalues.value = returnvalue;
        } else {
            win = window.open(winStr, "�Զ����", "font-family=Verdana,font-size=12,width=360px,height=180px,status=no");
            win.focus();
        }
    } else if (mark_value == 'USED_MARK') {
        winStr = "selectmark.jsp?column=" + columnID;
        if (isMSIE) {
            returnvalue = showModalDialog(winStr, "", "font-family:Verdana; font-size:12; dialogWidth:52em; dialogHeight:24em; status:no");
            alert(returnvalue);
            if (returnvalue != undefined && returnvalue.indexOf('MARKID') != -1) {
                var retmarkid = returnvalue.substring(returnvalue.indexOf('[TAG]'), returnvalue.indexOf('[/TAG]') + 6);
                var marktype = returnvalue.substring(returnvalue.indexOf('[TYPE]') + 6, returnvalue.indexOf('[/TYPE]'));
                returnvalue = retmarkid;
                alert(marktype);
                alert(returnvalue);
                if (marktype == '1') {
                    marksname = "�����б�";
                } else if (marktype == '2') {
                    marksname = "��Ŀ�б�";
                } else if (marktype == '3') {
                    marksname = "�ȵ�����";
                } else if (marktype == '4') {
                    marksname = "�������";
                } else if (marktype == '5') {
                    marksname = "�������б�";
                } else if (marktype == '6') {
                    marksname = "HTML��Ƭ";
                } else if (marktype == '7') {
                    marksname = "�ֵ������б�";
                } else {
                    document.createForm.MarkName.value = "NO_SELECT";
                    return;
                }
            } else {
                document.createForm.MarkName.value = "NO_SELECT";
                return;
            }
        } else {
            win = window.open(winStr, "", "font-family=Verdana,font-size=12,width=600px,height=340px,status=no");
            win.focus();
        }
    } else {
        returnvalue = "[TAG][" + mark_value + "]" + document.createForm.MarkName[document.createForm.MarkName.selectedIndex].text + "[/" + mark_value + "][/TAG]";
        isButton = "1";
    }

    if (returnvalue != "" && returnvalue != null && returnvalue != "0" && returnvalue != undefined) {
        if (isButton == "")
            returnvalue = "<INPUT name='" + returnvalue + "' type=button value='[" + marksname + "]' style='BORDER-RIGHT: #808080 1px solid; BORDER-TOP: #808080 1px solid; FONT-SIZE: 12px; BORDER-LEFT: #808080 1px solid; BORDER-BOTTOM: #808080 1px solid; BACKGROUND-COLOR: #D6D3CE'>";
        var addMark = returnvalue;
        if ( mark_type == 11) {          //��Ϣ����
            document.createForm.cname.value="��Ϣ����";
            document.createForm.modelname.value="search";
            document.createForm.modelType.value=mark_type;
        } else if (mark_type == 12) {          //���ﳵ
            document.createForm.cname.value="���ﳵ";
            document.createForm.modelname.value="shoppingcar";
            document.createForm.modelType.value=mark_type;
        } else if (mark_type == 13) {      //��������
            document.createForm.cname.value="��������";
            document.createForm.modelname.value="ordergenerate";
            document.createForm.modelType.value=mark_type;
        } else if (mark_type == 14) {          //��������
            document.createForm.cname.value="��������";
            document.createForm.modelname.value="orderdisplay";
            document.createForm.modelType.value=mark_type;
        } else if (mark_type == 15) {          //������ѯ
            document.createForm.cname.value="������ѯ";
            document.createForm.modelname.value="ordersearch";
            document.createForm.modelType.value=mark_type;
        } else if (mark_type == 16) {          //��Ϣ����
            document.createForm.cname.value="��Ϣ����";
            document.createForm.modelname.value="feedback";
            document.createForm.modelType.value=mark_type;
        } else if (mark_type == 17) {          //�û�����
            document.createForm.cname.value="�û�����";
            document.createForm.modelname.value="comment";
            document.createForm.modelType.value=mark_type;
        } else if (mark_type == 18) {          //�û�ע��
            document.createForm.cname.value="�û�ע��";
            document.createForm.modelname.value="register";
            document.createForm.modelType.value=mark_type;
        } else if (mark_type == 19) {          //�û���¼
            document.createForm.cname.value="�û���¼";
            document.createForm.modelname.value="login";
            document.createForm.modelType.value=mark_type;
        } else if (mark_type == 20) {          //�ջ���ַ
            document.createForm.cname.value="������ϸ��ѯ";
            document.createForm.modelname.value="orderdetailsearch";
            document.createForm.modelType.value=mark_type;
        } else if (mark_type == 21) {          //�û�����
            document.createForm.cname.value="�û�����";
            document.createForm.modelname.value="leavemessage";
            document.createForm.modelType.value=mark_type;
        } else if (mark_type == 22) {          //�޸�ע��
            document.createForm.cname.value="�޸�ע��";
            document.createForm.modelname.value="updatereg";
            document.createForm.modelType.value=mark_type;
        }

        document.createForm.MarkName.value = "NO_SELECT";
        InsertHTML('content', addMark);
    }
}

function includeTheProgramTag(tagname) {
    //��������  ��Ϣ����  �û�����  �û�ע��  �û���¼ �޸�ע�� ��Ϣ����  ���ﳵ  �������� ��������  ������ѯ ������ϸ��ѯ �Զ���� ���ϵ���
    //��ҵ��Ƹ  ��ý��  ȫ��չʾ  VOIP
    var oEditor = FCKeditorAPI.GetInstance("content");
    var buf = oEditor.GetXHTML(true);
    var regexp = /name=\"\[TAG\]\[MARKID\][0-9_\-]*\[\/MARKID\]\[\/TAG\]\" value=\"\[[^\[\]]*\]\"/g;
    var rtnAry = buf.match(regexp);
    if (rtnAry != null)
    {
        var findflag = false;
        var len = rtnAry.length;
        var i = 0;
        var name = "";
        while (i < len)
        {
            var tempbuf = rtnAry[i];
            posi = tempbuf.indexOf("value=\"");
            if (posi>-1) name = tempbuf.substring(posi+7);
            posi = name.indexOf("\"");
            if (posi > -1) name=name.substring(0,posi);
            if (name=="[��������]" || name=="[��Ϣ����]" || name=="[�û�����]" || name=="[�û�ע��]" || name=="[�û���¼]" ||
                name=="[�޸�ע��]" || name=="[��Ϣ����]" || name=="[���ﳵ]" || name=="[��������]" || name=="[��������]" ||
                name=="[������ѯ]" || name=="[������ϸ��ѯ]") {
                findflag = true;
                break;
            }
            i++;
        }
    }

    //����ҵ������ǣ��򷵻س��������ƣ����򷵻ؿ�
    if (findflag == true)
        return name;
    else
        return "";
}

function InsertHTML(e, inStr)
{
    var wmp=document.getElementById("UserControl1");
    wmp.SetTagHTML(inStr);
}

function selectSpecialChar(agri)
{
    var winStr = "/webbuilder/template/specialchar.jsp";
    returnvalue = showModalDialog(winStr,"","font-family:Verdana;font-size:12;dialogWidth:72em;dialogHeight:54em;status:no");
}

function InsertSpecialChar(e, inStr)
{
    var wmp=document.getElementById("UserControl1");
    wmp.SetTagHTML(inStr);
}

function UpdateHTML(e, inStr)
{
    var oEditor = FCKeditorAPI.GetInstance(e) ;
    var oActiveEl = oEditor.Selection.GetSelectedElement();
    oActiveEl.setAttribute('name', inStr);
}

function Add_Template_onclick(par) {
    returnvalue = showModalDialog("../template/selectModel.jsp?column=" + par, "","font-family=Verdana,font-size=12,width=600,height=300,status=no");

    if (returnvalue != undefined && returnvalue != "")
    {
        createForm.modelfilename.value = returnvalue;
        createForm.doCreate.value = false;
        createForm.submit();
    }
}

function OnScaned(files,agri)
{
    var winStr = "/webbuilder/template/addArticleList.jsp?column=28708&mark=30881";
    returnvalue = showModalDialog(winStr,"","font-family:Verdana;font-size:12;dialogWidth:72em;dialogHeight:54em;status:no");
}

function DECMD_EDITATTR_onclick(bname,bval)
{
    //alert(bname);
    //alert(bval);
    var returnvalue = "";
    var str = bname;
    if (bname.indexOf("[ARTICLE_COUNT]") > -1)
    {
        var winStr = "/webbuilder/template/addArticleCountList.jsp?str="+str;
        returnvalue = showModalDialog(winStr,"","font-family:Verdana;font-size:12;dialogWidth:50em;dialogHeight:35em;status:no");
    }
    else if (bname.indexOf("[SUBARTICLE_COUNT]") > -1)
    {
        var winStr = "/webbuilder/template/addSubArticleCountList.jsp?str="+str;
        returnvalue = showModalDialog(winStr,"","font-family:Verdana;font-size:12;dialogWidth:50em;dialogHeight:35em;status:no");
    }
    else if (bname.indexOf("[CHINESE_PATH]") > -1)
    {
        var winStr = "/webbuilder/template/addPath.jsp?str="+str;
        returnvalue = showModalDialog(winStr,"","font-family:Verdana;font-size:12;dialogWidth:32em;dialogHeight:18em;status:no");
        if (returnvalue != "" && returnvalue != "0")
            returnvalue = "[TAG][CHINESE_PATH]"+returnvalue+"[/CHINESE_PATH][/TAG]";
    }
    else if (bname.indexOf("[ENGLISH_PATH]") > -1)
    {
        var winStr = "/webbuilder/template/addPath.jsp?str="+str;
        returnvalue = showModalDialog(winStr,"","font-family:Verdana;font-size:12;dialogWidth:32em;dialogHeight:18em;status:no");
        if (returnvalue != "" && returnvalue != "0")
            returnvalue = "[TAG][ENGLISH_PATH]"+returnvalue+"[/ENGLISH_PATH][/TAG]";
    }
    else if (bname.indexOf("[NAVBAR]") > -1)
    {
        var winStr = "/webbuilder/template/addNavBar.jsp?str="+str;
        returnvalue = showModalDialog(winStr,"","font-family:Verdana;font-size:12;dialogWidth:32em;dialogHeight:18em;status:no");
        if (returnvalue != "" && returnvalue != "0")
            returnvalue = "[TAG][NAVBAR]"+returnvalue+"[/NAVBAR][/TAG]";
    }
    else if (bname.indexOf("[PREV_ARTICLE]") > -1)
    {
        var winStr = "/webbuilder/template/addNextArticle.jsp?str="+str;
        returnvalue = showModalDialog(winStr,"","font-family:Verdana;font-size:12;dialogWidth:32em;dialogHeight:18em;status:no");
        if (returnvalue != "" && returnvalue != "0")
            returnvalue = "[TAG][PREV_ARTICLE]"+returnvalue+"[/PREV_ARTICLE][/TAG]";
    }
    else if (bname.indexOf("[NEXT_ARTICLE]") > -1)
    {
        var winStr = "/webbuilder/template/addNextArticle.jsp?str="+str;
        returnvalue = showModalDialog(winStr,"","font-family:Verdana;font-size:12;dialogWidth:32em;dialogHeight:18em;status:no");
        if (returnvalue != "" && returnvalue != "0")
            returnvalue = "[TAG][NEXT_ARTICLE]"+returnvalue+"[/NEXT_ARTICLE][/TAG]";
    }
    else if (bname.indexOf("[ADV_POSITION]") > -1)
    {
        var winStr = "/webbuilder/template/addADV.jsp?str="+str;
        returnvalue = showModalDialog(winStr,"","font-family:Verdana;font-size:12;dialogWidth:50em;dialogHeight:30em;status:no");
        if (returnvalue != "" && returnvalue != "0")
            returnvalue = "[TAG][ADV_POSITION]"+returnvalue+"[/ADV_POSITION][/TAG]";
    }
    else if(bname.indexOf("[PAGINATION]") > -1)
    {
        var winStr = "/webbuilder/template/addNavBar.jsp?str="+str;
        returnvalue = showModalDialog(winStr,"","font-family:Verdana;font-size:12;dialogWidth:32em;dialogHeight:18em;status:no;");
        if (returnvalue != "" && returnvalue != "0")
            returnvalue = "[TAG][PAGINATION]"+returnvalue+"[/PAGINATION][/TAG]";
    }
    else if(bname.indexOf("[ARTICLE_PT]") > -1)
    {
        returnvalue = showModalDialog("/webbuilder/template/addArticlePt.jsp?str="+str,"","font-family:Verdana; font-size:12; dialogWidth:300px;dialogHeight:120px;status:no");
    }
    else if(bname.indexOf("[ARTICLE_TYPE]") > -1)
    {
        returnvalue = showModalDialog("/webbuilder/template/addArticleType.jsp?str="+str,"","font-family:Verdana;font-size:12;dialogWidth:32em;dialogHeight:18em;status:no");
    }
    else if (bname.indexOf("[MARKID]") > -1)
    {
        var markID = str.substring(str.indexOf("[MARKID]")+8,str.indexOf("_"));
        var columnID = str.substring(str.indexOf("_")+1,str.indexOf("[/MARKID]"));
        //alert(markID);

        if (bval == "[�����б�]")
        {
            var winStr = "/webbuilder/template/addArticleList.jsp?column="+columnID+"&mark="+markID;
            returnvalue = showModalDialog(winStr,"","font-family:Verdana;font-size:12;dialogWidth:72em;dialogHeight:54em;status:no");
            //alert(returnvalue);
        }
        if (bval == "[�Ƽ������б�]")
        {
            var winStr = "/webbuilder/template/commendarticle.jsp?column="+columnID+"&mark="+markID;
            returnvalue = showModalDialog(winStr,"","font-family:Verdana;font-size:12;dialogWidth:70em; dialogHeight:55em;status:no");
        }
        if (bval == "[�������б�]")
        {
            var winStr = "/webbuilder/template/addArticleList.jsp?type=1&column="+columnID+"&mark="+markID;
            returnvalue = showModalDialog(winStr,"","font-family:Verdana;font-size:12;dialogWidth:72em;dialogHeight:54em;status:no");
        }
        if (bval == "[�ֵ������б�]")
        {
            var winStr = "/webbuilder/template/addArticleList.jsp?type=2&column="+columnID+"&mark="+markID;
            returnvalue = showModalDialog(winStr,"","font-family:Verdana;font-size:12;dialogWidth:72em;dialogHeight:54em;status:no");
        }
        if (bval == "[��Ŀ�б�]")
        {
            var winStr = "/webbuilder/template/addColumnList.jsp?column="+columnID+"&mark="+markID;
            returnvalue = showModalDialog(winStr,"","font-family:Verdana;font-size:12;dialogWidth:780px;dialogHeight:550px;status:no");
        }
        if (bval == "[����Ŀ�б�]")
        {
            var winStr = "/webbuilder/template/addSubColumnList.jsp?column="+columnID+"&mark="+markID;
            returnvalue = showModalDialog(winStr,"","font-family:Verdana;font-size:12;dialogWidth:56em;dialogHeight:35em;status:no");
        }
        if (bval == "[�ȵ�����]")
        {
            var winStr = "/webbuilder/templatex/topStories.jsp?column="+columnID+"&mark="+markID;
            returnvalue = showModalDialog(winStr,"","font-family:Verdana;font-size:12;dialogWidth:70em; dialogHeight:55em;status:no");
        }
        if (bval == "[�������]")
        {
            var winStr = "/webbuilder/template/addRelateList.jsp?column="+columnID+"&mark="+markID;
            returnvalue = showModalDialog(winStr,"","font-family:Verdana;font-size:12;dialogWidth:578px;dialogHeight:385px;status:no");
        }
        if (bval == "[��ҳƬ��]")
        {
            var winStr = "/webbuilder/template/editHtmlcodeMarkFrame.jsp?column="+columnID+"&mark="+markID;
            returnvalue = showModalDialog(winStr,"htmlcode","dialogWidth:950px; dialogHeight:600px");
        }
        if(bval=="[�޸�ע��]")
        {
            var winStr = "/webbuilder/template/addUpdateRegFrame.jsp?column="+columnID+"&mark="+markID;
            returnvalue = showModalDialog(winStr,"","font-family:Verdana;font-size:12;dialogWidth:900px; dialogHeight:400px;status:no");
        }
        if(bval=="[�û�ע��]")
        {
            var winStr = "/webbuilder/template/addUserRegisterFrame.jsp?column="+columnID+"&mark="+markID;
            returnvalue = showModalDialog(winStr,"","font-family:Verdana;font-size:12;dialogWidth:900px; dialogHeight:400px;status:no");
        }
        if(bval=="[�û���¼��ʾ]")
        {
            
            var winStr = "/webbuilder/template/addUserLoginFrame.jsp?column="+columnID+"&mark="+markID;
            returnvalue = showModalDialog(winStr,"","font-family:Verdana;font-size:12;dialogWidth:900px; dialogHeight:400px;status:no");
        }
        if(bval=="[��¼��]")
        {
            var winStr = "/webbuilder/template/addUserLoginFormFrame.jsp?column="+columnID+"&mark="+markID;
            returnvalue = showModalDialog(winStr,"","font-family:Verdana;font-size:12;dialogWidth:900px; dialogHeight:400px;status:no");
        }
        if(bval=="[�����]")
        {
            var winStr = "/webbuilder/template/addUserDefineFormFrame.jsp?column="+columnID+"&mark="+markID;
            returnvalue = showModalDialog(winStr,"","font-family:Verdana;font-size:12;dialogWidth:900px; dialogHeight:400px;status:no");
        }
        if(bval=="[�û����Ա�]")
        {
            var winStr = "/webbuilder/template/addUserLeavemessageFormFrame.jsp?column="+columnID+"&mark="+markID;
            returnvalue = showModalDialog(winStr,"","font-family:Verdana;font-size:12;dialogWidth:900px; dialogHeight:400px;status:no");
        }
        if(bval=="[�û������б�]")
        {
            var winStr = "/webbuilder/template/addUserLeavemessageListFormFrame.jsp?column="+columnID+"&mark="+markID;
            returnvalue = showModalDialog(winStr,"","font-family:Verdana;font-size:12;dialogWidth:900px; dialogHeight:400px;status:no");
        }
        if(bval=="[��Ϣ����]")
        {
            var winStr = "/webbuilder/template/addFeedbackFrame.jsp?column="+columnID+"&mark="+markID;
            returnvalue = showModalDialog(winStr,"","font-family:Verdana;font-size:12;dialogWidth:900px; dialogHeight:400px;status:no");
        }
        if(bval=="[�û�����]")
        {
            var winStr = "/webbuilder/template/addLeaveMessageFrame.jsp?column="+columnID+"&mark="+markID;
            returnvalue = showModalDialog(winStr,"","font-family:Verdana;font-size:12;dialogWidth:900px; dialogHeight:400px;status:no");
        }
        if(bval=="[��������]")
        {
            var winStr = "/webbuilder/template/addArticleCommentFrame.jsp?column="+columnID+"&mark="+markID;
            returnvalue = showModalDialog(winStr,"","font-family:Verdana;font-size:12;dialogWidth:900px; dialogHeight:400px;status:no");
        }
        if(bval=="[���ﳵ]")
        {
            var winStr = "/webbuilder/template/addShoppingcarFrame.jsp?column="+columnID+"&mark="+markID;
            returnvalue = showModalDialog(winStr,"","font-family:Verdana;font-size:12;dialogWidth:900px; dialogHeight:400px;status:no");
        }
        if(bval=="[��������]")
        {
            var winStr = "/webbuilder/template/addOrderGenerateFrame.jsp?column="+columnID+"&mark="+markID;
            returnvalue = showModalDialog(winStr,"","font-family:Verdana;font-size:12;dialogWidth:800px; dialogHeight:400px;status:no");
        }
        if(bval=="[��������]")
        {
            var winStr = "/webbuilder/template/addOrderDisplayFrame.jsp?column="+columnID+"&mark="+markID;
            returnvalue = showModalDialog(winStr,"","font-family:Verdana;font-size:12;dialogWidth:900px; dialogHeight:400px;status:no");
        }
        if(bval=="[������ϸ��ѯ]")
        {
            var winStr = "/webbuilder/template/addOrderDetailSearchFrame.jsp?column="+columnID+"&mark="+markID;
            returnvalue = showModalDialog(winStr,"","font-family:Verdana;font-size:12;dialogWidth:900px; dialogHeight:400px;status:no");
        }
        if(bval=="[������ѯ]")
        {
            var winStr = "/webbuilder/template/addOrderSearchFrame.jsp?column="+columnID+"&mark="+markID;
            returnvalue = showModalDialog(winStr,"","font-family:Verdana;font-size:12;dialogWidth:900px; dialogHeight:400px;status:no");
        }
        if(bval=="[��Ϣ����]")
        {
            //alert(columnID);
            var winStr = "/webbuilder/template/addSearchFrame.jsp?column="+columnID+"&mark="+markID + "&doaction=e";
            returnvalue = showModalDialog(winStr,"","font-family:Verdana;font-size:12;dialogWidth:900px; dialogHeight:600px;status:no");
        }
        if(bval=="[ͼƬ��Ч]")
        {
            //alert(columnID);
            var winStr = "/webbuilder/template/addXuanImagesFrame.jsp?column="+columnID+"&mark="+markID + "&doaction=e";
            returnvalue = showModalDialog(winStr,"","font-family:Verdana;font-size:12;dialogWidth:800px; dialogHeight:600px;status:no");
        }
        if(bval=="[����ͼƬ��Ч]")
        {
            //alert(columnID);
            var winStr = "/webbuilder/template/addArticleXuanImagesFrame.jsp?column="+columnID+"&mark="+markID + "&doaction=e";
            returnvalue = showModalDialog(winStr,"","font-family:Verdana;font-size:12;dialogWidth:800px; dialogHeight:600px;status:no");
        }
        if(bval=="[�����ļ�]")
        {
            //alert(columnID+"   markID="+markID);
            var winStr = "/webbuilder/template/add_include.jsp?column="+columnID+"&mark="+markID + "&doaction=e";
            returnvalue = showModalDialog(winStr,"","font-family:Verdana;font-size:12;dialogWidth:800px; dialogHeight:600px;status:no");
        }
        if(bval=="[������]")
        {
            //alert(columnID+"   markID="+markID);
            var winStr = "/webbuilder/template/addSeeCookietag.jsp?column="+columnID+"&mark="+markID + "&doaction=e";
            returnvalue = showModalDialog(winStr,"","font-family:Verdana;font-size:12;dialogWidth:800px; dialogHeight:600px;status:no");
        }
        //alert(bval);
    }
    if((returnvalue != null)&&(returnvalue != "")){
        oActiveEl.name = returnvalue;
    }
    return returnvalue;
}