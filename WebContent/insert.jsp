<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.util.regex.Pattern" %>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert</title>
</head>
<%
	String title = request.getParameter("title");
	String writer = request.getParameter("writer");
	String regdate = request.getParameter("regdate");
	String content = request.getParameter("content");
	int count = 50000;
	
	// 유효성 검증
	if(title == "" || title == null) out.println("title 이 null 입니다.");
	
	if(writer == "" || writer == null) out.println("writer 가 null 입니다.");
	else if(!Pattern.matches("^[a-zA-Z0-9]+@[a-zA-Z0-9]+(.[_0-9a-zA-Z-]+)*$", writer)) out.println("이메일형식이 아닙니다.");
	
	if(regdate == "" || regdate == null) out.println("regdate 가 null 입니다.");
	else if(!Pattern.matches("^[0-9]*$", regdate)) out.println("숫자형식이 아닙니다.");
	
	if(content == "" || content == null) out.println("content 가 null 입니다.");
	
	// jdbc 
	try {
		String driverName = "oracle.jdbc.driver.OracleDriver";
		String url = "jdbc:oracle:thin:@localhost:1521:XE";
		
		Class.forName(driverName);
		Connection con = DriverManager.getConnection(url,"system","oracle");
		out.println("Oracle Database DB에 성공적으로 접속했습니다.");
		Statement stmt = con.createStatement();
		String sql = "INSERT INTO BOARD" +
					 "(IDX, TITLE, WRITER, REGDATE, COUNT, CONTENT)" +
				     "VALUES (board_seq.nextval, '" + title + "', '" + writer + "', sysdate, " + count +", '" + content + "')";
		stmt.executeUpdate(sql);
		
		con.close();
	} catch(Exception e) {
		out.println("Oracle Database DB 접속에 문제가 있습니다. <hr>");
		out.println(e.getMessage());
		e.printStackTrace();
	} finally {
		out.print("<script>location.href='list.jsp';</script>");
	}
%>
<body>
	
</body>
</html>