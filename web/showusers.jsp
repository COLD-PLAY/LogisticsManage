<%@ page import="java.sql.*" %><%--
  Created by IntelliJ IDEA.
  User: coldplay
  Date: 17-4-20
  Time: 下午8:52
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>所有用户</title>
    <link rel="stylesheet" type="text/css" href="mystyle.css">
</head>
<body>
    <table align="center" cellspacing="5px" style="color: #555555;">
        <tr>
            <td>用户名</td>
            <td>电话号码</td>
            <td>地址</td>
        </tr>
        <%
            // 设置字符集
            request.setCharacterEncoding("UTF-8");

            final String JDBC_DRIVE = "com.mysql.jdbc.Driver";
            final String DB_URL = "jdbc:mysql://localhost:3306/coldplay";
            final String USER = "root";
            final String PASS = "liaozhou1998";

            Connection conn = null;
            Statement stmt = null;

            try {
                Class.forName(JDBC_DRIVE);

                conn = DriverManager.getConnection(DB_URL, USER, PASS);
                stmt = conn.createStatement();

                String sql = "SELECT * FROM user;";
                ResultSet rs = stmt.executeQuery(sql);

                if (!rs.next()) {
                    // 判空
                    out.print("<tr><td>当前没有用户</td></tr>");
                }
                // 打印到网页上
                else {
                    rs.previous();
                    while (rs.next()) {
                        out.print("<tr>" +
                                "<td>" + rs.getString("username") + "</td>" +
                                "<td>" + rs.getString("phonenum") + "</td>" +
                                "<td>" + rs.getString("address") + "</td>" +
                                "</tr>"
                        );
                    }
                }
            } catch (SQLException se) {
                se.printStackTrace();
            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                try {
                    if (stmt != null) stmt.close();
                } catch (SQLException se) {
                    se.printStackTrace();
                }
                try {
                    if (conn != null) conn.close();
                } catch (SQLException se) {
                    se.printStackTrace();
                }
            }
        %>
    </table>
</body>
</html>
