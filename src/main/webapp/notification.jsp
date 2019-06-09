<%@ page import="java.util.*" %>
<%@ page import="gl.model.Comment" %>
<%@ page import="gl.model.Alert" %>
<%@ page import="gl.model.University" %>
<%@ page import="gl.servlet.CommentServlet" %>

<%@ page contentType="text/html; charset=UTF-8" language="java" %>

<%
	List<University> allUni = new ArrayList();
	allUni = (List<University>) request.getAttribute("allUniversities");
	List<Comment> allComments = new ArrayList();
	allComments = (List<Comment>) request.getAttribute("allComments");
	List<Alert> allAlerts = new ArrayList();
	allAlerts = (List<Alert>) request.getAttribute("allAlerts");
	
	String tab = (String) request.getAttribute("currentTab");
	int currentTab = Integer.valueOf(tab);
%>

<!DOCTYPE html>
<html lang="fr">
    <head>
        <meta charset="utf-8" name="viewport" content="width=device-width, initial-scale=1">
        <title>Notification List</title>
        <link rel="stylesheet" href="Styling/style.css">
        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.8.1/css/all.css"
        integrity="sha384-50oBUHEmvpQ+1lW4y57PTFmhCaXp0ML5d60M1M7uH2+nqUivzIebhndOJK28anvf" crossorigin="anonymous">
        <script type="text/javascript" src="Scripts/destinationListScript.js"></script>
    </head>

    <body onload="loadingNotifications(<% out.println(currentTab); %>)">
        <h1>Liste des notifications</h1>

        <div class="searchBar">
            <form method="post" action="/GL/Admin" class="changebutton">
                <button class="studentListButton" type="submit">Liste des universités</button>
            </form>
        </div>

        <div class="navBar">
            <form method="post" action="/GL/Notification">
                <button name="currentTab" value="1" type="submit">Commentaires</button>
            </form>
            <span class="vertLine"></span>
            <form method="post" action="/GL/Notification">
                <button name="currentTab" value="2" type="submit">Signalements</button>
            </form>
        </div>

		<div id="submittedCommentTab">
			<% if (allComments != null) {
				for(Comment com: allComments) {
					if(!com.isAccepted()) { %>
						<div class="notifCommentList">
							<div class="notifComInfo">
								<% out.println("<span><b> Auteur : </b>" + com.getAuthor_firstname() + " " + com.getAuthor_lastname() + "</span>"); %>
								<% out.println("<span><b> Mail : </b>" + com.getAuthor_mail() + "</span>"); %>
								<% out.println("<span><b> Date de soumission : </b>" + com.getCreation_date() + "</span>"); %>
								}
							</div>
							<div class="notifComContent">
								<% out.println("<span><b> Content : </b>" + com.getContent() + "</span>"); %>
							</div>
							<div class="notifComButtons">
								<form method="post" action="/GL/Notification" class="changebutton">
									<div class="notifConfirmButton"><button name="acceptComment" value="<% out.println(com.getId()); %>"
									type="submit">Accepter</button></div>
									<div class="notifConfirmButton"><button name="rejectComment" value="<% out.println(com.getId()); %>"
									type="submit">Refuser</button></div>
								</form>
							</div>
						</div>
					<% }
				}
			} %>
		</div>
		
		<div id="reportTab">
			<% if (allAlerts != null) {
				for(Alert alert: allAlerts) {
					if(!alert.isTreated()) { %>
						<div class="notifCommentList">
							<div class="notifComInfo">
								<% out.println("<span><b> Mail : </b>" + alert.getAuthorMail() + "</span><br/>"); %>
								<% out.println("<span><b> Raison : </b>" + alert.getReason() + "</span><br/>"); %>
								<% out.println("<span><b> Date de soumission : </b>" + alert.getCreationDate() + "</span>"); %>
								<% for(University uni: allUni) {
									if (uni.getId() == alert.getIdUniversity()) {
										out.println("<br><span><b> Université concernée : </b>" + uni.getName() + ", " + uni.getCountry() + "</span>");
									}
								} %>
							</div>
							<div class="notifComContent">
								<% out.println("<span><b> Commentaire : </b>" + alert.getComment() + "</span>"); %>
							</div>
							<div class="notifComButtons">
								<form method="post" action="/GL/Notification" class="changebutton">
									<input type="hidden" name="currentTab" value="2">
									<div class="notifConfirmButton"><button name="confirmAlert" value="<% out.println(alert.getId()); %>"
									type="submit">Supprimer</button></div>
								</form>
							</div>
						</div>
					<% }
				}
			} %>
		</div>

    </body>
</html>