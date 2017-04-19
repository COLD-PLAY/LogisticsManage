<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.SQLException" %><%--
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
    <div class="box">
        <form onsubmit="return checkall(this)" name="udpateorder" action="updateorder.jsp" method="post">
            // 如何实现批量更改状态
            <input type="text" name="ordernum" placeholder="订单号">
            <%--<hr class="line">--%>
            <%--<input type="text" name="fromphonenum" placeholder="发送方电话号码">--%>
            <hr class="line">
            <input type="text" name="status" placeholder="修改当前状态">
            <hr class="line">
            <input type="submit" value="提交">
        </form>
    </div>

    <%
        String ordernum = request.getParameter("ordrenum");
        String status = request.getParameter("status");

        final String JDBC_DRIVE = "com.mysql.jdbc.Driver";
        final String DB_URL = "jdbc:mysql://localhost:3306/coldplay";
        final String USER = "root";
        final String PASS = "liaozhou1998";

        boolean flag = true;

        Connection conn = null;
        Statement stmt = null;

        if (ordernum != null && status != null) {
            try {
                Class.forName(JDBC_DRIVE);

                conn = DriverManager.getConnection(DB_URL, USER, PASS);
                stmt = conn.createStatement();

                String sql = "UPDATE orders SET status='" + status + "' WHERE ordernum='" + ordernum + "';";
                stmt.execute(sql);

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
</body>
</html>
