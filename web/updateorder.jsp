<%@ page import="java.sql.*" %><%--
  Created by IntelliJ IDEA.
  User: coldplay
  Date: 17-4-19
  Time: 下午7:15
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>更新订单</title>
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
            // 设置字符集
            request.setCharacterEncoding("UTF-8");

            final String JDBC_DRIVE = "com.mysql.jdbc.Driver";
            final String DB_URL = "jdbc:mysql://localhost:3306/coldplay";

            final String USER = "root";
            final String PASS = "liaozhou1998";

            String ordernum = request.getParameter("ordernum");
            String status = request.getParameter("status");

//            System.out.println(ordernum + "\n" + status);

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

            boolean flag = true;

            if (ordernum != null && status != null) {
                System.out.println("我到了这一步");
                try {
                    Class.forName(JDBC_DRIVE);

                    conn = DriverManager.getConnection(DB_URL, USER, PASS);
                    stmt = conn.createStatement();

                    String sql = "UPDATE orders SET status='" + status + "' WHERE ordernum='" + ordernum + "';";
                    stmt.execute(sql);

                    System.out.println("我应该已经修改了");

                    stmt.close();
                    conn.close();
                } catch (SQLException se) {
                    flag = false;
                    se.printStackTrace();
                } catch (Exception e) {
                    flag = false;
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

                // 更新成功
                if (flag) {
        %>
        <script type="text/javascript">
            alert("更新成功！跳转操作页面");
        </script>
        <%
                    request.setAttribute("username", "root");
                    request.getServletContext().getRequestDispatcher("/user.jsp").forward(request, response);
                }
                else {
        %>
        <script type="text/javascript">
            alert("更新失败！请重新更新");
        </script>
        <%
                }
            }
        %>
    </table>
    <div class="box">
        <form onsubmit="return checkall(this)" name="udpateorder" action="updateorder.jsp" method="post">
            <%--如何实现批量更改状态--%>
            <input type="text" name="ordernum" placeholder="订单号">
            <%--<hr class="line">--%>
            <%--<input type="text" name="fromphonenum" placeholder="发送方电话号码">--%>
            <hr class="line">
            <input type="text" name="status" placeholder="修改当前状态">
            <hr class="line">
            <input type="submit" value="修改">
        </form>
    </div>

    <script type="text/javascript">
        function checkall(f) {
            if (f.ordernum.value == "" || f.status.value == "") {
                alert("请填写完整后提交！");
                return false;
            }
            return true;
        }
    </script>
</body>
</html>