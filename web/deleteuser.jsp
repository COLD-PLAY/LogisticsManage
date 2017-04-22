<%@ page import="java.sql.*" %><%--
  Created by IntelliJ IDEA.
  User: coldplay
  Date: 17-4-20
  Time: 下午4:18
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>删除用户</title>
    <link rel="stylesheet" type="text/css" href="mystyle.css">
</head>
<body>
    <%
        // 设置字符集
        request.setCharacterEncoding("UTF-8");

        String username = request.getParameter("username");
        String password = request.getParameter("password");

        // 此时得到的username 为乱码。
    //        System.out.println(username);

        final String JDBC_DRIVE = "com.mysql.jdbc.Driver";
        final String DB_URL = "jdbc:mysql://localhost:3306/coldplay";

        final String USER = "root";
        final String PASS = "liaozhou1998";

        Connection conn = null;
        Statement stmt = null;

        if (username != null && password != null) {
            try {
                Class.forName(JDBC_DRIVE);

                conn = DriverManager.getConnection(DB_URL, USER, PASS);
                stmt = conn.createStatement();

                String sql = "SELECT * FROM user WHERE username='" + username + "';";
                ResultSet rs = stmt.executeQuery(sql);

                if (!rs.next()) {
    %>
    <script type="text/javascript">
        alert("用户名不存在！请核对后再次尝试");
    </script>
    <%
                }

                else {
                    sql = "SELECT * FROM user WHERE username='root';";
                    rs = stmt.executeQuery(sql);

                    if (rs.next()) {
                        String root_password = rs.getString("password");
                        if (password.compareTo(root_password) != 0) {
        %>
        <script type="text/javascript">
            alert("管理员密码错误！请核对后再次尝试");
        </script>
        <%
                        }
                        else {
                            sql = "DELETE FROM user WHERE username='" + username + "';";
                            stmt.execute(sql);
        %>
        <script type="text/javascript">
            alert("删除用户成功！跳转用户页面");
        </script>
        <%
                            request.setAttribute("username", "root");
                            request.getServletContext().getRequestDispatcher("/user.jsp").forward(request, response);
                        }
                    }
                    else {
        %>
        <script type="text/javascript">
            alert("删除失败！请重试");
        </script>
        <%
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
    <div class="box">
        <form onsubmit="return checkall(this)" name="deleteuser" action="deleteuser.jsp" method="post">
            <input type="text" name="username" placeholder="输入待删除的用户名">
            <hr class="line">
            <input type="password" name="password" placeholder="输入管理员密码">
            <hr class="line">
            <input type="submit" value="删除">
        </form>
    </div>

    <script type="text/javascript">
        function checkall(f) {
            if (f.username.value == "" || f.password.value == "") {
                alert("请输入完整！");
                return false;
            }
            else if (f.username.value == "root") {
                alert("不能删除root 用户！");
                return false;
            }
            return true;
        }
    </script>
</body>
</html>
