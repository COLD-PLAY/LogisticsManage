<%@ page import="java.sql.*" %><%--
  Created by IntelliJ IDEA.
  User: coldplay
  Date: 17-4-19
  Time: 下午8:44
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>删除订单</title>
    <link rel="stylesheet" type="text/css" href="mystyle.css">
</head>
<body>
    <table align="center" cellspacing="5px" style="color: #555555;">
        <tr>
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

            String ordernum = request.getParameter("ordernum");
            boolean flag = true;

            if (ordernum != null) {
                try {
                    Class.forName(JDBC_DRIVE);

                    conn = DriverManager.getConnection(DB_URL, USER, PASS);
                    stmt = conn.createStatement();

                    String sql = "SELECT * FROM orders WHERE ordernum='" + ordernum + "';";
                    ResultSet rs = stmt.executeQuery(sql);

                    if (!rs.next()) {
        %>
        <script type="text/javascript">
            alert("没有此订单！请核对仔细");
        </script>
        <%
        }
        else {
            sql = "DELETE FROM orders WHERE ordernum='" + ordernum + "';";
            stmt.execute(sql);
        %>
        <script type="text/javascript">
            alert("删除成功！跳转用户页面");
        </script>
        <%
                        request.setAttribute("username", "root");
                        request.getServletContext().getRequestDispatcher("/user.jsp").forward(request, response);
                    }

                    stmt.close();
                    conn.close();
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
            else {
                try {
                    Class.forName(JDBC_DRIVE);

                    conn = DriverManager.getConnection(DB_URL, USER, PASS);
                    stmt = conn.createStatement();

                    String sql = "SELECT * FROM user WHERE username='root';";
                    ResultSet rs = stmt.executeQuery(sql);

                    if (rs.next()) {
                        String password = rs.getString("password");
                        request.setAttribute("password", password);
                    }

                    stmt.close();
                    conn.close();
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
    <div class="box">
        <p id="password" hidden="hidden">${password}</p>
        <form onsubmit="return checkall(this)" action="deleteorder.jsp" name="deleteorder" method="post">
            <input type="text" name="ordernum" placeholder="订单号">
            <hr class="line">
            <input type="submit" value="删除">
        </form>
    </div>

    <%
    %>
    <script type="text/javascript">
        function checkall(f) {
            if (f.ordernum.value == "") {
                alert("请填写完整！");
                return false;
            }
            var pass = prompt("输入管理员密码进行此项操作：");
            var password = document.getElementById("password").innerText;
            if (pass != password) {
                alert("密码错误！");
                return false;
            }
            return true;
        }
    </script>
</body>
</html>
