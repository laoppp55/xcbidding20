function Wa_SetImgAutoSize(img)
    {
        //var img=document.all.img1;//��ȡͼƬ
        var MaxWidth = 200;
        //����ͼƬ��Ƚ���
        var MaxHeight = 100;
        //����ͼƬ�߶Ƚ���
        var HeightWidth = img.offsetHeight / img.offsetWidth;
        //���ø߿��
        var WidthHeight = img.offsetWidth / img.offsetHeight;
        //���ÿ�߱�
        if (img.readyState != "complete") {
            return false;
            //ȷ��ͼƬ��ȫ����
        }

        if (img.offsetWidth > MaxWidth) {
            img.width = MaxWidth;
            img.height = MaxWidth * HeightWidth;
        }
        if (img.offsetHeight > MaxHeight) {
            img.height = MaxHeight;
            img.width = MaxHeight * WidthHeight;
        }
    }

    function CheckImg(img)
    {
        var message = "";
        var MaxWidth = 1;
        //����ͼƬ��Ƚ���
        var MaxHeight = 1;
        //����ͼƬ�߶Ƚ���

        if (img.readyState != "complete") {
            return false;
            //ȷ��ͼƬ��ȫ����
        }
        if (img.offsetHeight > MaxHeight) message += "\r�߶ȳ��" + img.offsetHeight;
        if (img.offsetWidth > MaxWidth) message += "\r��ȳ��" + img.offsetWidth;
    }

    function checkvideo()
    {
        var getvideopic = document.videoForm.videopic.value;
        if(getvideopic=="")
        {
            alert("��ѡ����Ƶ��ͼ��");
            return false
        }
        var getvideoname = document.videoForm.videoname.value;
        if(getvideoname=="")
        {
            alert("����д��Ƶ���ƣ�");
            document.videoForm.videoname.focus();
            return false;
        }
        var getschoolname = document.videoForm.myschool.value;
        if(getschoolname=="")
        {
            alert("����дѧУ���ƣ�");
            document.videoForm.myschool.focus();
            return false;
        }
        var getupvideo = document.videoForm.upvideo.value;
        if(getupvideo=="")
        {
            alert("���ϴ���Ƶ���ύ��");
            return false;
        }

        //document.videoForm.upsubmit.disabled = true;
    }