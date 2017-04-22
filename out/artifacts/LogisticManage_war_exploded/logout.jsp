<%@ page import="java.sql.*" %><%--
  Created by IntelliJ IDEA.
  User: coldplay
  Date: 17-4-20
  Time: 下午1:05
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>注销账户</title>
    <link rel="stylesheet" type="text/css" href="mystyle.css">
</head>
<body>
    <%
        String username = request.getParameter("username");
        request.setAttribute("username", username);

        // 此时得到的username 为乱码。
//        System.out.println(username);
        String password = request.getParameter("password");

        final String JDBC_DRIVE = "com.mysql.jdbc.Driver";
        final String DB_URL = "jdbc:mysql://localhost:3306/coldplay";

        final String USER = "root";
        final String PASS = "liaozhou1998";

        Connection conn = null;
        Statement stmt = null;

        if (password != null) {
            try {
                Class.forName(JDBC_DRIVE);

                conn = DriverManager.getConnection(DB_URL, USER, PASS);
                stmt = conn.createStatement();

                username = new String(username.getBytes("ISO8859-1"), "UTF-8");

                String sql = "SELECT * FROM user WHERE username='" + username + "';";
                ResultSet rs = stmt.executeQuery(sql);

                System.out.println(username);
                System.out.println(password);

                if (rs.next()) {
                    if (password.compareTo(rs.getString("password")) != 0) {
        %>
        <script type="text/javascript">
            alert("密码错误！请重试");
        </script>
        <%
                    }
                    else {
                        sql = "DELETE FROM user WHERE username='" + username + "';";
                        stmt.execute(sql);
        %>
        <script type="text/javascript">
            alert("注销成功！跳转到起始页面");
            window.location.href = "index.jsp";
        </script>
        <%
//                        request.getServletContext().getRequestDispatcher("/index.jsp").forward(request, response);
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
        <form onsubmit="return checkall(this)" action="logout.jsp" method="post">
            <input type="text" name="username" hidden="hidden" value="${username}">
            <input type="password" name="password" placeholder="密码">
            <hr class="line">
            <input type="submit" value="注销">
        </form>
    </div>
    <script type="text/javascript">
        function checkall(f) {
            if (f.password.value == "") {
                alert("请输入密码！");
                return false;
            }
            var qr = confirm("确定要注销么？");
            return qr;
        }
    </script>
</body>
</html>
