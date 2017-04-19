<%@ page import="javax.print.DocFlavor" %>
<%@ page import="com.sun.corba.se.spi.monitoring.StatisticMonitoredAttribute" %>
<%@ page import="java.security.spec.PSSParameterSpec" %>
<%@ page import="java.sql.*" %><%--
  Created by IntelliJ IDEA.
  User: coldplay
  Date: 17-4-19
  Time: 下午8:17
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>显示所有订单</title>
    <link rel="stylesheet" type="text/css" href="mystyle.css">
</head>
<body>
    <div class="box">
        <table>
            <tr style="position: absolute;">
                <th>发送用户</th>
                <th>发送用户电话号码</th>
                <th>发送用户地址</th>
                <th>接收用户</th>
                <th>接收用户电话号码</th>
                <th>接收用户地址</th>
                <th>订单号</th>
                <th>当前状态</th>
            </tr>
        <%
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

                String sql = "SELECT * FROM orders;";
                ResultSet rs = stmt.executeQuery(sql);

                if (!rs.next()) {
                    // 判空
                    out.print("<td>当前没有订单</td>");
                }
                // 打印到网页上
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
        %>
            </tr>
        </table>
    </div>
</body>
</html>
