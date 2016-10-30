<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title></title>
	<script>
	function formCheck() { 
		var title = document.forms[0].title;       
		var writer = document.forms[0].writer;
		var regdate = document.forms[0].regdate;
		var content = document.forms[0].content;

		if (title.value == null || title.value == ""){                                   
			alert('insert title.');                                  
			document.forms[0].title.focus();                          
			return false;                                                     
		}
		
		if (writer.value == null ||  writer.value  == ""){           
			alert('insert writer');  
			document.forms[0].writer.focus();                       
			return false;                
		}else if(writer.value.match(/^(\w+)@(\w+)[.](\w+)$/ig) == null){
			alert('wrong fomat. please E-mail format');  
			document.forms[0].writer.focus();                       
			return false;  
		}
		
		if (content.value == null || content.value == ""){                                   
			alert('insert content.');                                  
			document.forms[0].content.focus();                          
			return false;                                                     
		}
		/*
		if (regdate.value == null || regdate.value == "" ){                             
			alert('insert date');    
			document.forms[0].regdate.focus();                       
			return false;             
		}else if(regdate.value.match(/^\d\d\d\d\d\d+$/ig)   == null){
			alert('wrong format. please insert Number(6)');  
			document.forms[0].regdate.focus();                       
			return false;  
		}
		*/
	}
	</script>
</head>
<body>
	<form action="insert.do" method="post" enctype="multipart/form-data" onsubmit="">
		title : <input type="text" name="title" /><br/>
		writer : <input type="text" name="writer" /><br/>
		content : <textarea rows="10" cols="20" name="content"></textarea><br/>
		file : <input type="file" name="filename"><br/>
		<input type="submit"/>
	</form> 

</body> 
</html>   