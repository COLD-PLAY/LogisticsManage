<%@ page import="javax.swing.plaf.basic.BasicInternalFrameTitlePane" %>
<%@ page import="java.sql.*" %><%--
  Created by IntelliJ IDEA.
  User: coldplay
  Date: 17-4-19
  Time: 下午12:30
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>注册</title>
    <link rel="stylesheet" type="text/css" href="mystyle.css">
</head>
<body>
    <div class="box">
        <h1>注册</h1>
        <form onsubmit="return checkall(this)" name="signup" action="signup.jsp" method="post">
            <input type="text" name="username" placeholder="用户名">
            <hr class="line">
            <input type="password" name="password" placeholder="密码">
            <hr class="line">
            <input type="password" name="password_repeat" placeholder="再次输入">
            <hr class="line">
            <input type="text" name="phonenum" placeholder="电话号码">
            <hr class="line">
            <input type="text" name="address" placeholder="地址">
            <hr class="line">
            <input type="submit" value="注册">
        </form>
    </div>
    <a href="index.jsp" class="backhome">back</a>

    <%
        // 设置字符集
        request.setCharacterEncoding("UTF-8");

        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String phonenum = request.getParameter("phonenum");
        String address = request.getParameter("address");
        String password_repeat = request.getParameter("password_repeat");

        final String JDBC_DRIVE = "com.mysql.jdbc.Driver";
        final String DB_URL = "jdbc:mysql://localhost:3306/coldplay";

        final String USER = "root";
        final String PASS = "liaozhou1998";

        boolean flag = true;

        if (username != null && password != null && phonenum != null && address != null && password_repeat != null) {

//            System.out.println(username + "\n" + address);
            Connection conn = null;
            Statement stmt = null;

            try {
                Class.forName(JDBC_DRIVE);

                conn = DriverManager.getConnection(DB_URL, USER, PASS);
                stmt = conn.createStatement();

                String sql = "SELECT * FROM user WHERE username='" + username + "';";
                ResultSet rs = stmt.executeQuery(sql);

                if (rs.next()) {
    %>
    <script type="text/javascript">
        alert("用户名已被占用！请重新输入");
    </script>
    <%
                    flag = false;
                }
                else {
                    sql = "INSERT INTO user VALUE('" + username + "', '" + password + "', '" + phonenum + "', '" + address + "');";
                    stmt.execute(sql);
                }

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

            if (flag) {
    %>
    <script type="text/javascript">
        alert("注册成功！跳转登录页面");
    </script>
    <%
//                request.removeAttribute("username");
                request.getServletContext().getRequestDispatcher("/signin.jsp").forward(request, response);
            }
            else {
    %>
    <script type="text/javascript">
        alert("注册失败！请重新注册");
    </script>
    <%
            }
        }
    %>

    <script type="text/javascript">
        function checkall(f) {
            if (f.username.value == "" || f.password.value == "" || f.password_repeat.value == "" || f.phonenum.value == "" || f.address.value == "") {
                alert("请填写完整！");
                return false;
            }
            else if (f.password.value != f.password_repeat.value) {
                alert("两次输入的密码不一致！");
                return false;
            }
            else if (f.phonenum.value.length < 6) {
                alert("电话号码太短！")
                return false;
            }
            else if (isNaN(parseInt(f.phonenum.value))) {
                alert("电话号码必须为数字！");
                return false;
            }
            else if (f.password.value.length < 8) {
                alert("密码至少八位！");
                return false;
            }
            return true;
        }
    </script>
</body>
</html>
