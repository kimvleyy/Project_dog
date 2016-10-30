<%@page import="java.util.regex.Pattern"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>본격! 게시판 - 게시글 리스트</title>
<style type="text/css">
	table, td, th
{
	border:1px solid green;
}
	th
{
	background-color:green;
	color:white;
}
</style>
<!-- jquery -->
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7/jquery.js"></script>
</head>
<body>											
	<h1>게시글 리스트</h1>						
	<table>										
		<tr>									
			<th>번호</th>						
			<th>제목</th>						
			<th>작성자</th>
			<th>날짜</th>
			<th>조회수</th>
		</tr>
		<c:forEach items="${articleList}" var="article">
			<tr>
				<td>${article.idx}</td>
				<td><a href='count.do?idx=${article.idx}'>${article.title} </a></td>
				<td>${article.writer}</td>
				<td>${article.regdate}</td>
				<td>${article.count}</td> 
			</tr>
		</c:forEach>
	</table> 
	<input type="hidden" name="page" id="page" value="${page}">
	<a herf="#" onclick="loadNextPage()">더 보기</a>
	<script>
		function loadNextPage() {
			var page = $("#page").val();
			page = parseInt(page);
			page += 10;
			$.ajax({
				type:'post',
				url:'ajaxList.do',
				data:({page:page}),
				success:function(data){
					$('table').append(data);
					$('#page').val(page);
				}
			});
		}
	</script>
		
	<br/><a href="write.jsp">글쓰기</a>
</body>
</html>