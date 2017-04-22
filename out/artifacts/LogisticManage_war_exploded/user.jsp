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
                <td>当前状态</td>
            </tr>
            <%
//                String username = new String((request.getParameter("username")).getBytes("ISO8859-1"), "UTF-8");
//                String username = request.getParameter("username");
                // 以这种方式获取用户名不会出现乱码
                String username = request.getAttribute("username").toString();
                System.out.println(username);

                final String JDBC_DRIVE = "com.mysql.jdbc.Driver";
                final String DB_URL = "jdbc:mysql://localhost:3306/coldplay";

                final String USER = "root";
                final String PASS = "liaozhou1998";

                Connection conn = null;
                Statement stmt = null;

                if (username.compareTo("root") == 0) {
                    out.print("<tr><td>当前在root 管理员用户下</td></tr>");
                }

                else {
                    try {
                        Class.forName(JDBC_DRIVE);

                        conn = DriverManager.getConnection(DB_URL, USER, PASS);
                        stmt = conn.createStatement();

                        String sql = "SELECT * FROM orders WHERE fromuser='" + username + "' OR touser='" + username + "';";
                        ResultSet rs = stmt.executeQuery(sql);

                        if (!rs.next()) {
                            // 判空
                            out.print("<tr><td>当前没有订单</td></tr>");
                        } else {
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
                                        "<td>" + rs.getString("status") + "</td>" +
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
                }
            %>
        </table>
    </div>
    <div class="box">
        <h1>欢迎， ${username}</h1>
        <hr class="line">

        <div>
            <a href="addorder.jsp?username=${username}" class="jump">添加订单</a>
            <hr class="line">
            <a href="searchorder.jsp?username=${username}" class="jump" target="_blank">搜索订单</a>
            <hr class="line">
            <a href="updateuser.jsp?username=${username}" class="jump" target="_blank">修改信息</a>
            <hr class="line">
            <%
                if (username.compareTo("root") == 0) {
                    out.print("<a class=\"jump\" href=\"updateorder.jsp\" target=\"_blank\">更新订单</a><hr class=\"line\">");
                    out.print("<a class=\"jump\" href=\"deleteorder.jsp\" target=\"_blank\">删除订单</a><hr class=\"line\">");
                    out.print("<a class=\"jump\" href=\"showorders.jsp\" target=\"_blank\">查看订单</a><hr class=\"line\">");
                    out.print("<a class=\"jump\" href=\"deleteuser.jsp\" target=\"_blank\">删除用户</a><hr class=\"line\">");
                    out.print("<a class=\"jump\" href=\"showusers.jsp\" target=\"_blank\">查看用户</a><hr class=\"line\">");
                }
                else {
                    out.print("<a class=\"jump\" href=\"logout.jsp?username=" + username + "\" target=\"_blank\">注销账户</a><hr class=\"line\">");
                }
            %>
        </div>
    </div>
    <a href="index.jsp" class="backhome">back</a>
</body>
</html>
