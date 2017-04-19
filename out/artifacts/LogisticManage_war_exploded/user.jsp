<%@ page import="com.sun.corba.se.spi.monitoring.StatisticMonitoredAttribute" %>
<%@ page import="java.sql.*" %>
<%@ page import="javax.swing.plaf.basic.BasicInternalFrameTitlePane" %><%--
  Created by IntelliJ IDEA.
  User: coldplay
  Date: 17-4-19
  Time: 下午2:27
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>用户</title>
    <link rel="stylesheet" type="text/css" href="mystyle.css">
</head>
<body>
    <div style="color: #555555;">
        <table align="center" cellspacing="5px">
            <tr>
                <td>发送用户</td>
                <td>发送用户电话号码</td>
                <td>发送用户地址</td>
                <td>接收用户</td>
                <td>接收用户电话号码</td>
                <td>接收用户地址</td>
                <td>订单号</td>
            </tr>
            <%
                String username = new String((request.getParameter("username")).getBytes("ISO8859-1"), "UTF-8");
                System.out.println(username);

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

                    String sql = "SELECT * FROM orders WHERE fromuser='" + username + "' OR touser='" + username + "';";
                    ResultSet rs = stmt.executeQuery(sql);

                    if (!rs.next()) {
                        // 判空
                        System.out.println("没有订单");
                    }
                    else {
                        rs.previous();
                        while (rs.next()) {
                            out.print("<tr>" +
                                    "<td>" + rs.getString("fromuser") + "</td>" +
                                    "<td>" + rs.getString("fromphonenum") + "</td>" +
                                    "<td>" + rs.getString("fromaddress") + "</td>" +
                                    "<td>" + rs.getString("touser") + "</td>" +
                                    "<td>" + rs.getString("tophonenum") + "</td>" +
                                    "<td>" + rs.getString("toaddress") + "</td>" +
                                    "<td>" + rs.getString("ordernum") + "</td>" +
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
    </div>
    <div class="box">
        <h1>欢迎， ${username}</h1>
        <hr class="line">

        <div>
            <a href="addorder.jsp?username=${username}" class="jump">添加订单</a>
        </div>
    </div>
    <%

    %>
</body>
</html>
