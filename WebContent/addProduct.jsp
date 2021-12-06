<%@ include file="auth.jsp"%>
<%@ page import="java.text.NumberFormat" %>
<%@ include file="jdbc.jsp" %>
<!DOCTYPE html>
<html>
<head>
	<title>Add Product</title>
</head>
<body>
<%
try
{	// Load driver class
	Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
}
catch (java.lang.ClassNotFoundException e)
{
	out.println("ClassNotFoundException: " +e);
}


// Make connection
String url = "jdbc:sqlserver://db:1433;DatabaseName=tempdb;";
String uid = "SA";
String pw = "YourStrong@Passw0rd";

// Write query to retrieve all order summary records
try (Connection con = DriverManager.getConnection(url, uid, pw);
		Statement stmt = con.createStatement();)
{
	String prodName = request.getParameter("productName");
	double prodPrice = Double.parseDouble(request.getParameter("productPrice"));
	String prodDesc = request.getParameter("productDesc");
	int categoryId = Integer.parseInt(request.getParameter("categoryId"));

	String SQL = "INSERT INTO product (productName, productPrice, productDesc, categoryId) VALUES (?,?,?,?)";

	PreparedStatement pst = con.prepareStatement(SQL);
	pst.setString(1,prodName);
	pst.setDouble(2,prodPrice);
	pst.setString(3,prodDesc);
	pst.setInt(4,categoryId);

	int check = pst.executeUpdate();

	if(check >0) out.println("new product added");
	else out.println("failed to add product");
}
catch (Exception e)
{
    out.print(e);
}



// Close connection
%>

</body>
</html>
