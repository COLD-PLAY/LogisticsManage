<%@ page import="java.sql.*" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.*" %>
<%@ page import="java.util.Date" %>
<%--
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
        // 设置字符集
        request.setCharacterEncoding("UTF-8");

        String username = request.getParameter("username");
        request.setAttribute("username", username);

        String fromaddress = request.getParameter("fromaddress");
        String fromphonenum = request.getParameter("fromphonenum");
        String touser = request.getParameter("touser");
        String toaddress = request.getParameter("toaddress");
        String tophonenum = request.getParameter("tophonenum");

        final String JDBC_DRIVE = "com.mysql.jdbc.Driver";
        final String DB_URL = "jdbc:mysql://localhost:3306/coldplay";

        final String USER = "root";
        final String PASS = "liaozhou1998";

        Connection conn = null;
        Statement stmt = null;

        boolean flag = true;

//        System.out.println(username);

        // 添加订单
        if (username != null && fromaddress != null && fromphonenum != null && touser != null && toaddress != null && tophonenum != null) {
            try {
                Class.forName(JDBC_DRIVE);

                conn = DriverManager.getConnection(DB_URL, USER, PASS);
                stmt = conn.createStatement();

                // 得到当前时间，并作为订单号使用
                SimpleDateFormat sf = new SimpleDateFormat("yyyyMMddhhmm");
                Date now = new Date();
                String ordernum = sf.format(now).toString();

                String sql = "INSERT INTO orders VALUE('" + username + "', '" + fromphonenum + "', '" + fromaddress + "', '" + touser + "', '" + tophonenum + "', '" + toaddress + "', '" + ordernum + "', '" + fromaddress + "');";
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

            if (flag) {
    %>
    <script type="text/javascript">
        alert("添加成功！跳转用户页面");
    </script>
    <%
//                System.out.print("添加成功！");
//                request.getServletContext().getRequestDispatcher("/user.jsp?username=" + username);
                request.setAttribute("username", username);
                request.getServletContext().getRequestDispatcher("/user.jsp").forward(request, response);
            }
            else {
    %>
    <script type="text/javascript">
        alert("添加失败！请重新添加");
    </script>
    <%
            }
        }

        // 得到预放置的信息
        else {
            try {
                Class.forName(JDBC_DRIVE);

                conn = DriverManager.getConnection(DB_URL, USER, PASS);
                stmt = conn.createStatement();

                String sql = "SELECT * FROM user WHERE username='" + username + "';";
                ResultSet rs = stmt.executeQuery(sql);

                if (rs.next()) {
                    fromaddress = rs.getString("address");
                    fromphonenum = rs.getString("phonenum");

                    // 添加属性
                    request.setAttribute("address", fromaddress);
                    request.setAttribute("phonenum", fromphonenum);
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
    <div class="box">
        <p id="username" hidden="hidden">${username}</p>
        <form onsubmit="return checkall(this)" name="addorder" action="addorder.jsp?username=${username}" method="post">
            <input type="text" name="fromuser" value="${username}">
            <hr class="line">
            <input type="text" name="fromaddress" placeholder="当前地址" value="${address}">
            <hr class="line">
            <input type="text" name="fromphonenum" placeholder="当前电话" value="${phonenum}">
            <hr class="line">
            <input type="text" name="touser" placeholder="发送到用户">
            <hr class="line">
            <input type="text" name="toaddress" placeholder="发送到地址">
            <hr class="line">
            <input type="text" name="tophonenum" placeholder="发送到电话">
            <hr class="line">
            <input type="submit" value="添加">
        </form>
    </div>

    <script type="text/javascript">
        function checkall(f) {
            var username = document.getElementById("username").innerText;
            if (f.fromuser.value == "" || f.fromaddress.value == "" || f.fromphonenum.value == "" || f.touser.value == "" || f.toaddress.value == "" || f.tophonenum == "") {
                alert("请填写完整！");
                return false;
            }
            else if (username != f.fromuser.value) {
                alert("必须使用您的用户名添加订单！");
                return false;
            }
            else if (isNaN(parseInt(f.fromphonenum.value)) || isNaN(parseInt(f.tophonenum.value))) {
                alert("电话号码必须为数字！");
                return false;
            }
            return true;
        }
    </script>
</body>
</html>
