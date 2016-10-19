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
<title> ����! �Խ��� - �Խñ� ����Ʈ</title>
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
		out.println("Oracle Database DB�� ���������� �����߽��ϴ�.");

		Statement stmt = con.createStatement();
		String sql = "select * from board order by idx desc";
		rs = stmt.executeQuery(sql);
		
		ArrayList<Board> articleList = new ArrayList<Board>();
		
		while(rs.next()) {
			Board article = new Board();
			
			article.setIdx(rs.getInt("idx")); // Integer.parseInt�� String���� int�������� ����ȯ
			article.setTitle(rs.getString("title"));
			article.setWriter(rs.getString("writer"));
			article.setRegdate(rs.getString("regdate"));
			article.setCount(rs.getInt("count"));
			articleList.add(article); // ���õ� ���� ����Ʈ�� �߰��մϴ�.
		}
		request.setAttribute("articleList", articleList);	// ���õ� ����Ʈ�� �信 ������
		con.close();
		} catch(Exception e) {
			out.println("Oracle Database DB ���ӿ� ������ �ֽ��ϴ�. <hr>");
			out.println(e.getMessage());
			e.printStackTrace();
		}
%>
<body>
<h1> �Խñ� ����Ʈ </h1>
	<table>
		<tr>
			<th>��ȣ</th>
			<th>����</th>
			<th>�ۼ���</th>
			<th>��¥</th>
			<th>��ȸ��</th>
		</tr>
		<c:forEach items="${articleList}" var="article">
			<tr>
				<td>${article.idx}</td><!-- jstl�� ǥ������ ��ũ��Ʈ���� �Ӽ��� ���Ƽ� ��𿡾��� �켱�� -->
				<td><a href='content.jsp?idx=${article.idx}'>${article.title}</a></td>
				<td>${article.writer}</td>
				<td>${article.regdate}</td>
				<td>${article.count}</td>
			</tr>
		</c:forEach>
	</table>
	
	${fn:length( articleList )}
	<c:if test="${page > 0}">
		<a href="list.do?page=${page-10}">����������</a>
	</c:if>
	<c:if test="${page == 0}">
		<a href="#">����������</a>
	</c:if>  
	
	<fmt:parseNumber value="${page/10+1}" type="number" integerOnly="true"/> ������
		
	<c:if test="${fn:length(articleList) < 10}">
		<a href="#">����������</a>
	</c:if>
	<c:if test="${fn:length(articleList) == 10}">
		<a href="list.do?page=${page+10}">����������</a>
	</c:if>
	<br/> <a href="write.jsp">�۾���</a>	
</body>
</html>