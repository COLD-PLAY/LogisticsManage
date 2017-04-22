<%@ page import="java.sql.*" %><%--
  Created by IntelliJ IDEA.
  User: coldplay
  Date: 17-4-19
  Time: 下午11:31
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>搜索订单</title>
    <link rel="stylesheet" type="text/css" href="mystyle.css">
</head>
<body>
    <div class="box">
        <form onsubmit="return checkall(this)" name="searchorder" action="searchorder.jsp" method="post">
            <input type="text" name="phonenum" placeholder="电话号码">
            <hr class="line">
            <input type="text" name="ordernum" placeholder="订单号">
            <hr class="line">
            <input type="text" name="username" placeholder="用户名">
            <hr class="line">
            <input type="submit" value="搜索">
        </form>
    </div>
    <table align="center" style="color: #555555;" cellspacing="5px">
        <tr>
            <th>发送用户</th>
            <th>电话号码</th>
            <th>地址</th>
            <th>接收用户</th>
            <th>电话号码</th>
            <th>地址</th>
            <th>订单号</th>
            <th>当前状态</th>
        </tr>

    <%
        // 设置字符集
        request.setCharacterEncoding("UTF-8");

        String username = request.getParameter("username");
        String ordernum = request.getParameter("ordernum");
        String phonenum = request.getParameter("phonenum");

        final String JDBC_DRIVE = "com.mysql.jdbc.Driver";
        final String DB_URL = "jdbc:mysql://localhost:3306/coldplay";
        final String USER = "root";
        final String PASS = "liaozhou1998";

        Connection conn = null;
        Statement stmt = null;

        if (username != null || ordernum != null || phonenum != null) {

            try {
                Class.forName(JDBC_DRIVE);

                conn = DriverManager.getConnection(DB_URL, USER, PASS);
                stmt = conn.createStatement();

                String sql = "SELECT * FROM orders WHERE fromuser='" + username + "' OR touser='" + username + "' OR fromphonenum='" + phonenum + "' OR tophonenum='" + phonenum + "' OR ordernum='" + ordernum + "';";
                ResultSet rs = stmt.executeQuery(sql);

                if (!rs.next()) {
                    // 判空
                    out.print("<tr><td>当前没有订单</td></tr>");
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
        }
    %>
    </table>
    <a href="index.jsp" class="ba">back</a>

    <script type="text/javascript">
        function checkall(f) {
            if (f.phonenum.value == "" && f.ordernum.value == "" && f.username.value == "") {
                alert("请至少填写一项搜索项！");
                return false;
            }
            else if (f.phonenum.value != "" && isNaN(parseInt(f.phonenum.value)) || f.ordernum.value != "" && isNaN(parseInt(f.ordernum.value))) {
                alert("电话号码或者 订单号必须为数字！");
                return false;
            }
            return true;
        }
    </script>

</body>
</html>