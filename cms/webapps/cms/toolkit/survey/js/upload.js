function check()
{
    if (document.UploadFile.filename.value.ltrim().rtrim() == "")
    {
	alert("����ѡ���ϴ��ļ���");
	return false;
    }
    else
    {
    	var str = document.UploadFile.filename.value.ltrim().rtrim();
    	var ext = (str.substring(str.lastIndexOf(".")+1,str.length)).toLowerCase();
    	
    	if (ext != "htm" && ext != "html" && ext != "shtm" && 
    	    ext != "shtml" && ext != "asp" && ext != "jsp" && 
    	    ext != "php" && ext != "jpg" && ext != "jpeg" && 
    	    ext != "gif" && ext != "bmp" && ext != "png" && 
    	    ext != "pcx" && ext != "css" && ext != "js")
    	{
    	    alert("�ϴ��ļ�����ΪHTML��ʽ��ͼ���ʽ���ļ���");
    	    return false;
    	}
    }
    
    if (document.UploadFile.image.value.ltrim().rtrim() != "")
    {
    	var str = document.UploadFile.image.value.ltrim().rtrim();
    	var ext = (str.substring(str.lastIndexOf(".")+1,str.length)).toLowerCase();
    	
    	if (ext != "zip" && ext != "jpg" && ext != "jpeg" && 
    	    ext != "gif" && ext != "bmp" && ext != "png" && ext != "pcx")
    	{
    	    alert("ͼ�������ΪZIP��ʽ��ͼ���ʽ���ļ���");
    	    return false;
    	}
    	else
    	{
    	    return true;
    	}
    }
    else
    {
    	return true;
    }
}

function ltrim()
{
    return this.replace(/ +/,"");
}
String.prototype.ltrim = ltrim;

function rtrim()
{
    return this.replace(/ +$/,"");
}
String.prototype.rtrim = rtrim;
