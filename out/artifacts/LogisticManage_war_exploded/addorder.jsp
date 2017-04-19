<%@ page import="java.sql.*" %><%--
  Created by IntelliJ IDEA.
  User: coldplay
  Date: 17-4-19
  Time: 下午4:22
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>添加订单</title>
    <link rel="stylesheet" type="text/css" href="mystyle.css">
</head>
<body>
    <%
//        String username = new String((request.getParameter("username")).getBytes("ISO8859-1"), "UTF-8");
        String username = request.getParameter("username");
        String address = "";
        String phonenum = "";

        System.out.println(username);

        request.setAttribute("username", username);

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

            String sql = "SELECT * FROM user WHERE username='" + username + "';";
            ResultSet rs = stmt.executeQuery(sql);

            if (rs.next()) {
                address = rs.getString("address");
                phonenum = rs.getString("phonenum");

                // 添加属性
                request.setAttribute("address", address);
                request.setAttribute("phonenum", phonenum);
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
    //
    //        boolean flag = true;
    //
    //        if (username != null && password != null && phonenum != null && address != null && password_repeat != null) {
    //            username = new String(username.getBytes("ISO8859-1"), "UTF-8");
    //            address = new String(address.getBytes("ISO8859-1"), "UTF-8");
    //
    //    //            System.out.println(username + "\n" + address);
    //            Connection conn = null;
    //            Statement stmt = null;
    //
//                try {
//                    Class.forName(JDBC_DRIVE);
//
//                    conn = DriverManager.getConnection(DB_URL, USER, PASS);
//                    stmt = conn.createStatement();
//
//                    String sql = "INSERT INTO user VALUE('" + username + "', '" + password + "', '" + phonenum + "', '" + address + "');";
//                    stmt.execute(sql);
//
//                    stmt.close();
//                    conn.close();
//                } catch (SQLException se) {
//                    flag = false;
//                    se.printStackTrace();
//                } catch (Exception e) {
//                    flag = false;
//                    e.printStackTrace();
//                } finally {
//                    try {
//                        if (stmt != null) stmt.close();
//                    } catch (SQLException se) {
//                        flag = false;
//                        se.printStackTrace();
//                    }
//                    try {
//                        if (conn != null) conn.close();
//                    } catch (SQLException se) {
//                        flag = false;
//                        se.printStackTrace();
//                    }
//                }

    %>
    <div class="box">
        <form onsubmit="return checkall(this)" name="addorder" action="addorder.jsp" method="post">
            <input type="text" name="fromuser" value="${username}">
            <hr class="line">
            <input type="text" name="fromaddress" value="${address}">
            <hr class="line">
            <input type="text" name="fromphonenum" value="${phonenum}">
            <hr class="line">
            <input type="text" name="touser" placeholder="发送到用户">
            <hr class="line">
            <input type="text" name="toaddress" placeholder="发送到地址">
            <hr class="line">
            <input type="text" name="tophonenum" placeholder="发送到电话">
            <hr class="line">
            <input type="submit" value="提交">
        </form>
    </div>

    <script type="text/javascript">
        var username = ${username};
        alert(username);
        function checkall(f) {
            if (f.fromuser.value == "" || f.fromaddress.value == "" || f.fromphonenum.value == "" || f.touser.value == "" || f.toaddress.value == "" || f.tophonenum == "") {
                alert("请填写完整！");
                return false;
            }
            else if (username != f.fromuser.value) {
                alert("必须使用您的用户名添加订单！");
                return false;
            }
            return true;
        }
    </script>
</body>
</html>
