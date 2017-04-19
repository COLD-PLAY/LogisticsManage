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
    <div class="box">
        <form onsubmit="return checkall(this)" action="deleteorder.jsp" name="deleteorder" method="post">
            <input type="text" name="ordernum" placeholder="订单号">
            <hr class="line">
            <input type="submit" value="删除">
        </form>
    </div>
    <%
        final String JDBC_DRIVE = "com.mysql.jdbc.Driver";
        final String DB_URL = "jdbc:mysql://localhost:3306/coldplay";

        final String USER = "root";
        final String PASS = "liaozhou1998";

        String ordernum = request.getParameter("ordernum");
        boolean flag = true;

        Connection conn = null;
        Statement stmt = null;

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
    <script type="text/javascript">
        function checkall(f) {
            if (f.ordernum.value == "") {
                alert("请填写完整！");
                return false;
            }
            var pass = prompt("输入管理员密码进行此项操作：");
            var password = ${password};
            if (pass != password) {
                alert("密码错误！");
                return false;
            }
            return true;
        }
    </script>
</body>
</html>
