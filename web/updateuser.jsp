<%@ page import="java.sql.*" %><%--
  Created by IntelliJ IDEA.
  User: coldplay
  Date: 17-4-20
  Time: 上午7:26
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>修改信息</title>
    <link rel="stylesheet" type="text/css" href="mystyle.css">
</head>
<body>

    <table align="center" cellspacing="5px" style="color: #555555;">
        <tr>
            <td>用户名</td>
            <td>电话号码</td>
            <td>地址</td>
        </tr>
    <%
        // 设置字符集
        request.setCharacterEncoding("UTF-8");

        String username = request.getParameter("username");
        request.setAttribute("username", username);

        String password = request.getParameter("password");
        String new_password = request.getParameter("new_password");
        String phonenum = request.getParameter("phonenum");
        String address = request.getParameter("address");
        String old_password = "";

        final String JDBC_DRIVE = "com.mysql.jdbc.Driver";
        final String DB_URL = "jdbc:mysql://localhost:3306/coldplay";
        final String USER = "root";
        final String PASS = "liaozhou1998";

        boolean flag = true;

        Connection conn = null;
        Statement stmt = null;

        try {
            Class.forName(JDBC_DRIVE);

            conn = DriverManager.getConnection(DB_URL, USER, PASS);
            stmt = conn.createStatement();


            System.out.print(username);

            String sql = "SELECT * FROM user WHERE username='" + username + "';";
            ResultSet rs = stmt.executeQuery(sql);

            if (rs.next()) {
                out.print("<tr>" +
                        "<td>" + rs.getString("username") + "</td>" +
                        "<td>" + rs.getString("phonenum") + "</td>" +
                        "<td>" + rs.getString("address") + "</td>" +
                        "</tr>"
                );
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

        if (new_password != null || phonenum != null || address != null) {

            System.out.println(username);
            try {
                Class.forName(JDBC_DRIVE);

                conn = DriverManager.getConnection(DB_URL, USER, PASS);
                stmt = conn.createStatement();

                String sql = "SELECT * FROM user WHERE username='" + username + "';";
                ResultSet rs = stmt.executeQuery(sql);

                if (rs.next()) {
                    old_password = rs.getString("password");
                }
                if (old_password.compareTo(password) != 0) {
    %>
    <script type="text/javascript">
        alert("密码输入错误！请核对后更改");
    </script>
    <%
                    flag = false;
                }
                else {
                    if (new_password != "") {
                        sql = "UPDATE user SET password='" + new_password + "' WHERE username='" + username + "';";
                        stmt.execute(sql);
                    }
                    if (address != "") {
                        sql = "UPDATE user SET address='" + address + "' WHERE username='" + username + "';";
                        stmt.execute(sql);
                    }
                    if (phonenum != "") {
                        sql = "UPDATE user SET phonenum='" + phonenum + "' WHERE username='" + username + "';";
                        stmt.execute(sql);
                    }
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
        alert("修改信息成功！跳转起始页面");
        window.location.href = "index.jsp";
    </script>
    <%
//                request.setAttribute("username", username);
//                request.getServletContext().getRequestDispatcher("/user.jsp").forward(request, response);
            }
            else {
    %>
    <script type="text/javascript">
        alert("修改失败！请重新尝试");
    </script>
    <%
            }
        }
    %>
    </table>
    <div class="box">
        <form onsubmit="return checkall(this)" name="updateuser" action="updateuser.jsp" method="post">
            <input type="text" name="username" placeholder="用户名（不可更改）" value="${username}" hidden="hidden">
            <%--<hr class="line">--%>
            <input type="password" name="password" placeholder="原密码（必填）">
            <hr class="line">
            <input type="password" name="new_password" placeholder="新密码">
            <hr class="line">
            <input type="password" name="new_password_repeat" placeholder="再次输入">
            <hr class="line">
            <input type="text" name="phonenum" placeholder="新电话号码">
            <hr class="line">
            <input type="text" name="address" placeholder="新地址">
            <hr class="line">
            <input type="submit" value="修改">
        </form>
    </div>

    <script type="text/javascript">
        function checkall(f) {
            if (f.password.value == "") {
                alert("原密码必须填入！");
                return false;
            }
            else if (f.new_password.value == "" && f.phonenum.value == "" && f.address.value == "") {
                alert("请至少修改一项！");
                return false;
            }
            else if (f.new_password.value != f.new_password_repeat.value) {
                alert("两次输入的密码不一致！");
                return false;
            }
            else if (f.phonenum.value != "" && f.phonenum.value.length < 6) {
                alert("电话号码太短！");
                return false;
            }
            else if (f.phonenum.value != "" && isNaN(parseInt(f.phonenum.value))) {
                alert("电话号码必须为数字！");
                return false;
            }
            else if (f.new_password.value != "" && f.new_password.value.length < 8) {
                alert("密码至少八位！");
                return false;
            }
            return true;
        }
    </script>
</body>
</html>
