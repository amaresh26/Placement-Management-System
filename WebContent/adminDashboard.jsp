<%@ page import="model.DatabaseConnector"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
	String userFullName = "";
	session = request.getSession(false);
	if (session != null && session.getAttribute("user_type_id") != null) {
		String user_type = session.getAttribute("user_type_id").toString();
		userFullName = session.getAttribute("full_name").toString();
		System.out.print(user_type);
		if (user_type.equals("2")) {
			response.sendRedirect("studentDashboard.jsp");
		} else if (user_type.equals("3")) {
			response.sendRedirect("companyDashboard.jsp");
		}
	}

	ResultSet mResult = null;

	mResult = (ResultSet) DatabaseConnector.getResultSet("select name from user where user_type_id = '3';", 1);
	ArrayList<String> skills = new ArrayList<String>();
	while (mResult.next()) {
		skills.add(mResult.getString("name"));
	}
	//getting the count of total querires 
	String queriesCount = "";
	mResult = (ResultSet) DatabaseConnector.getResultSet("SELECT COUNT(*) FROM queries where query_to = 1;", 1);
	if (mResult.next()) {
		queriesCount = mResult.getString("COUNT(*)");
	}

	mResult.close();
	DatabaseConnector.closeConnection();

	//getting the total companies in the system
	String companyCount = "";
	mResult = (ResultSet) DatabaseConnector.getResultSet("SELECT COUNT(*) FROM user where user_type_id = '3';",
			1);
	if (mResult.next()) {
		companyCount = mResult.getString("COUNT(*)");
	}

	mResult.close();
	DatabaseConnector.closeConnection();

	//getting the count of total jobs posted 
	String jobsPostedCount = "";
	mResult = (ResultSet) DatabaseConnector.getResultSet("SELECT COUNT(*) FROM post_job_td;", 1);
	if (mResult.next()) {
		jobsPostedCount = mResult.getString("COUNT(*)");
	}

	mResult.close();
	DatabaseConnector.closeConnection();

	//getting the count of total students 
	String studentsCount = "";
	mResult = (ResultSet) DatabaseConnector.getResultSet("SELECT COUNT(*) FROM user where user_type_id = '2';",
			1);
	if (mResult.next()) {
		studentsCount = mResult.getString("COUNT(*)");
	}

	mResult.close();
	DatabaseConnector.closeConnection();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Admin Dashboard</title>

<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">


<!-- Latest compiled and minified CSS -->
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css"
	integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u"
	crossorigin="anonymous">

<!-- Optional theme -->
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css"
	integrity="sha384-rHyoN1iRsVXV4nD0JutlnGaslCJuC7uwjduW9SVrLvRYooPp2bWYgmgJQIXwl/Sp"
	crossorigin="anonymous">

<!-- Latest compiled and minified JavaScript -->
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"
	integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa"
	crossorigin="anonymous"></script>


<link rel="stylesheet" href="http://www.w3schools.com/lib/w3.css">
<link rel="stylesheet"
	href="https://fonts.googleapis.com/css?family=Raleway">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<style>
html, body, h1, h2, h3, h4, h5 {
	font-family: "Raleway", sans-serif
}

.light:hover {
	background: white;
	color: black;
}
</style>

<script type="text/javascript" src="js/dashboards.js"></script>
</head>
<body>


	<!-- Top container -->
	<div class="w3-container w3-top w3-black w3-large w3-padding"
		style="z-index: 4">
		<button class="w3-btn w3-hide-large w3-padding-0 w3-hover-text-grey"
			onclick="w3_open();">
			<i class="fa fa-bars"></i>  Menu
		</button>
		<span class="w3-left" style="display: inline-block;">JNTUH
			Student Placements Portal</span> <a href="Logout" class="w3-right light">Logout</a>
	</div>

	<!-- Sidenav/menu -->
	<nav class="w3-sidenav w3-collapse w3-white w3-animate-left"
		style="z-index:3;width:300px;" id="mySidenav"> <br>
	<div class="w3-container w3-row">
		<div class="w3-col s4">
			<img src="/w3images/avatar2.png" class="w3-circle w3-margin-right"
				style="width: 46px">
		</div>
		<div class="w3-col s8">
			<span>Welcome, <strong><%=userFullName%></strong></span><br> <a
				href="adminListOfQueries.jsp"
				class="w3-hover-none w3-hover-text-red w3-show-inline-block"><i
				class="fa fa-envelope"></i></a> <a href="#"
				class="w3-hover-none w3-hover-text-blue w3-show-inline-block"><i
				class="fa fa-cog"></i></a>
		</div>
	</div>
	<hr>
	<div class="w3-container">
		<h3>Menu</h3>
	</div>
	<a href="#" class="w3-padding w3-blue"><i class="fa fa-users fa-fw"></i> 
		Dashboard</a> <a href="adminListOfQueries.jsp" class="w3-padding"><i
		class="fa fa-eye fa-fw"></i>  Check Queries</a> <a href="addStudent.jsp"
		class="w3-padding"><i class="fa fa-history fa-fw"></i> Add Student</a>
	<a href="listOfCompanies.jsp" class="w3-padding"><i
		class="fa fa-history fa-fw"></i> List of Companies</a> <br>
	<br>
	</nav>

	<!-- Overlay effect when opening sidenav on small screens -->
	<div class="w3-overlay w3-hide-large w3-animate-opacity"
		onclick="w3_close()" style="cursor: pointer" title="close side menu"
		id="myOverlay"></div>

	<!-- !PAGE CONTENT! -->
	<div class="w3-main" style="margin-left: 300px; margin-top: 43px;">


		<header class="w3-container" style="padding-top:22px">
		<h5>
			<b> My Dashboard</b>
		</h5>
		</header>
		<div class="w3-row-padding w3-margin-bottom">
			<div class="w3-quarter">
				<div class="w3-container w3-red w3-padding-16">
					<div class="w3-left">
						<i class="fa fa-comment w3-xxxlarge"></i>
					</div>
					<div class="w3-right">
						<h3><%=queriesCount%></h3>
					</div>
					<div class="w3-clear"></div>
					<a href="adminListOfQueries.jsp">Queries</a>
				</div>
			</div>
			<div class="w3-quarter">
				<div class="w3-container w3-blue w3-padding-16">
					<div class="w3-left">
						<i class="fa fa-eye w3-xxxlarge"></i>
					</div>
					<div class="w3-right">
						<h3><%=companyCount%></h3>
					</div>
					<div class="w3-clear"></div>
					<a href="listOfCompanies.jsp">Total Companies</a>
				</div>
			</div>
			<div class="w3-quarter">
				<div class="w3-container w3-teal w3-padding-16">
					<div class="w3-left">
						<i class="fa fa-share-alt w3-xxxlarge"></i>
					</div>
					<div class="w3-right">
						<h3><%=jobsPostedCount%></h3>
					</div>
					<div class="w3-clear"></div>
					<a href="#">Total Jobs Posted</a>
				</div>
			</div>
			<div class="w3-quarter">
				<div class="w3-container w3-orange w3-text-white w3-padding-16">
					<div class="w3-left">
						<i class="fa fa-users w3-xxxlarge"></i>
					</div>
					<div class="w3-right">
						<h3><%=studentsCount%></h3>
					</div>
					<div class="w3-clear"></div>
					<a href="#">Total Students</a>
				</div>
			</div>
		</div>

		<div class="col-md-11">
			<table class="table">
				<thead>
					<th>COMPANY NAME</th>
				</thead>
				<tbody>
					<%
						for (int i = 0; i < skills.size(); i++) {
					%>
					<tr>
						<td class="txt"><%=skills.get(i)%></td>
						<td>
							<form action="ViewCompanyProfile" method="post">
								<input type="hidden" name="company_name"
									value="<%=skills.get(i)%>">
								<button type="submit" style="float: right;"
									class="btn btn-primary">View Profile</button>
							</form>
						</td>
					</tr>
					<%
						}
					%>
				</tbody>
			</table>
		</div>
	</div>

	<script>
		// Get the Sidenav
		var mySidenav = document.getElementById("mySidenav");

		// Get the DIV with overlay effect
		var overlayBg = document.getElementById("myOverlay");

		// Toggle between showing and hiding the sidenav, and add overlay effect
		function w3_open() {
			if (mySidenav.style.display === 'block') {
				mySidenav.style.display = 'none';
				overlayBg.style.display = "none";
			} else {
				mySidenav.style.display = 'block';
				overlayBg.style.display = "block";
			}
		}

		// Close the sidenav with the close button
		function w3_close() {
			mySidenav.style.display = "none";
			overlayBg.style.display = "none";
		}
	</script>

</body>
</html>

