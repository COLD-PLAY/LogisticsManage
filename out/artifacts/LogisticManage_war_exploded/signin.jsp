<%@ page import="java.sql.*" %><%--
  Created by IntelliJ IDEA.
  User: coldplay
  Date: 17-4-19
  Time: 上午8:54
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>登录</title>
    <link rel="stylesheet" type="text/css" href="mystyle.css">
</head>
<body>
    <div class="box">
        <h1>登录</h1>
        <form onsubmit="return checkall(this)" action="signin.jsp" name="signin" method="post">
            <input type="text" name="username" placeholder="用户名">
            <hr class="line">
            <input type="password" name="password" placeholder="密码">
            <hr class="line">
            <input type="submit" value="登录" style="width: 110%;">
        </form>
    </div>
    <a href="index.jsp" class="backhome">back</a>

    <%
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        if (username != null && password != null) {
            // 中文
            username = new String(username.getBytes("ISO8859-1"), "UTF-8");
            System.out.println(username);

            final String JDBC_DRIVE = "com.mysql.jdbc.Driver";
            final String DB_URL = "jdbc:mysql://localhost:3306/coldplay";

            final String USER = "root";
            final String PASS = "liaozhou1998";

            boolean flag = false;

            Connection conn = null;
            Statement stmt = null;

            try {

                Class.forName(JDBC_DRIVE);

                conn = DriverManager.getConnection(DB_URL, USER, PASS);
                stmt = conn.createStatement();

                String sql = "SELECT * FROM user WHERE username='" + username + "';";
                ResultSet rs = stmt.executeQuery(sql);

                if (rs.next()) {
                    if (password.compareTo(rs.getString("password")) == 0) {
                        flag = true;
                    }
                }
                else {
                    // 空
                    System.out.println("用户名不存在");
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

            if (flag) {
    //            if (username.compareTo("root") == 0)
                // 把用户信息放到request 中
                request.setAttribute("username", username);
//                request.setAttribute("password", password);
//                request.setAttribute("phonenum", phonenum);
//                request.setAttribute("address", address);
                request.getServletContext().getRequestDispatcher("/user.jsp").forward(request, response);
            }
            else {
    %>
    <script>
        alert("用户名或密码错误！");
    </script>
    <%
            }
        }
    %>

    <script type="text/javascript">
        function checkall(f) {
            if (f.username.value == "" || f.password.value == "") {
                alert("请填写完整！");
                return false;
            }
            return true;
        }
    </script>
</body>
</html>
