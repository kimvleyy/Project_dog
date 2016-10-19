<%@ page import="com.board.beans.Board"%>
<%@ page import="java.util.ArrayList" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.regex.Pattern" %>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title> 본격! 게시판 - 게시글 리스트</title>
<style type="text/css">
	table, td, th {
		border: 1px solid green;
	}	
	th {
		background-color: green;
		color: white;
	}
</style>
</head>
<%
	try {
		String driverName = "oracle.jdbc.driver.OracleDriver";
		String url = "jdbc:oracle:thin:@localhost:1521:XE";
		ResultSet rs = null;

		Class.forName(driverName);
		Connection con = DriverManager.getConnection(url, "system", "oracle");
		out.println("Oracle Database DB에 성공적으로 접속했습니다.");

		Statement stmt = con.createStatement();
		String sql = "select * from board order by idx desc";
		rs = stmt.executeQuery(sql);
		
		ArrayList<Board> articleList = new ArrayList<Board>();
		
		while(rs.next()) {
			Board article = new Board();
			
			article.setIdx(rs.getInt("idx")); // Integer.parseInt는 String형을 int형식으로 형변환
			article.setTitle(rs.getString("title"));
			article.setWriter(rs.getString("writer"));
			article.setRegdate(rs.getString("regdate"));
			article.setCount(rs.getInt("count"));
			articleList.add(article); // 셋팅된 빈을 리스트에 추가합니다.
		}
		request.setAttribute("articleList", articleList);	// 셋팅된 리스트를 뷰에 포워드
		con.close();
		} catch(Exception e) {
			out.println("Oracle Database DB 접속에 문제가 있습니다. <hr>");
			out.println(e.getMessage());
			e.printStackTrace();
		}
%>
<body>
<h1> 게시글 리스트 </h1>
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
				<td>${article.idx}</td><!-- jstl의 표현식은 스크립트릿과 속성이 같아서 어디에쓰나 우선됨 -->
				<td><a href='content.jsp?idx=${article.idx}'>${article.title}</a></td>
				<td>${article.writer}</td>
				<td>${article.regdate}</td>
				<td>${article.count}</td>
			</tr>
		</c:forEach>
	</table>
	
	${fn:length( articleList )}
	<c:if test="${page > 0}">
		<a href="list.do?page=${page-10}">이전페이지</a>
	</c:if>
	<c:if test="${page == 0}">
		<a href="#">이전페이지</a>
	</c:if>  
	
	<fmt:parseNumber value="${page/10+1}" type="number" integerOnly="true"/> 페이지
		
	<c:if test="${fn:length(articleList) < 10}">
		<a href="#">다음페이지</a>
	</c:if>
	<c:if test="${fn:length(articleList) == 10}">
		<a href="list.do?page=${page+10}">다음페이지</a>
	</c:if>
	<br/> <a href="write.jsp">글쓰기</a>	
</body>
</html>