(function(){ 
    //Section 1 : 按下自定义按钮时执行的代码 
    var a= { 
        exec:function(editor){ 
            //alert("这是FormatHtml自定义按钮"+createForm.column.value); 
			var editor = CKEDITOR.instances.content;
			var buf = CKEDITOR.instances.content.getData();
			var editBody = editor.document.getBody(); 
            var nodes = editBody.getChildren().toArray() ;
 
			for(var intLoop=0;intLoop<nodes.length;intLoop++){
                el=nodes[intLoop];
                el.removeAttribute("className","",0);
                el.removeAttribute("style","",0);
                el.removeAttribute("font"," ",0);
            }

            var html = editBody.getHtml();
            html=html.replace(/<o:p>[/s/S]*<\/o:p>/gi,"");
            html=html.replace(/o:/gi,"");
            html=html.replace(/<FONT[^>]*>/gi,"");
            html=html.replace(/<\/FONT>/gi,"");
            html=html.replace(/<SPAN[^>]*>/gi,"");
            html=html.replace(/<\/SPAN>/gi,"");
            html=html.replace(/<p>[/s]*<\/p>/gi,"");
            html=html.replace(/<P>[/s]*<\/P>/gi,"");
            html=html.replace(/<p>[/s|&nbsp;]*<\/p>/gi,"");
            html=html.replace(/<P>[/s|&nbsp;]*<\/P>/gi,"");
            html=html.replace(/<\?xml[^>]*>/gi,"");    
            var s_info = html;
            alert("清除WORD格式成功！！！");
			editBody.setHtml(s_info);
		} 
    }, 
    //Section 2 : 创建自定义按钮、绑定方法 
    b='FormatHtml';
    CKEDITOR.plugins.add(b,{ 
        init:function(editor){ 
            editor.addCommand(b,a); 
            editor.ui.addButton('FormatHtml',{ 
                label:'FormatHtml', 
                icon: this.path + 'formathtml.gif', 
                command:b 
            }); 
        } 
    }); 
})(); 