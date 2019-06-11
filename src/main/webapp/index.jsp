<%@ page import="java.util.*" %>
<%@ page import="gl.model.University" %>
<%@ page import="gl.model.Comment" %>
<%@ page import="gl.servlet.DbDao" %>
<%@ page import="gl.servlet.CommentServlet" %>
<%@ page import="org.apache.commons.lang3.StringUtils" %>

<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" language="java" %>

<%
	/* Full university lists */

	String errorMessage = (String) request.getAttribute("loginErrorMessage");

	List<University> uniListFilteredByCountry = new ArrayList();
	List<University> uniListFilteredByField = new ArrayList();
	List<University> uniListFilteredByLanguage = new ArrayList();

	List<String> allLanguages = new ArrayList();
	List<String> allFields = new ArrayList();

	List<Comment> allComments = new ArrayList();

	uniListFilteredByCountry = (List<University>) request.getAttribute("allUniversities");
	allLanguages = (List<String>) request.getAttribute("allLanguages");
	allFields = (List<String>) request.getAttribute("allFields");
	allComments = (List<Comment>) request.getAttribute("allComments");

	uniListFilteredByField.addAll(uniListFilteredByCountry);
	uniListFilteredByLanguage.addAll(uniListFilteredByCountry);

	List<String> fullCountryList = new ArrayList();
	for (int i = 0; i < uniListFilteredByCountry.size(); i++) {
		if (!fullCountryList.contains(uniListFilteredByCountry.get(i).getCountry())) {
			fullCountryList.add(uniListFilteredByCountry.get(i).getCountry());
		}
	}

	/* Separation beteween full university lists above, and filtered ones below */

	String tab = (String) request.getAttribute("currentTab");
	int currentTab = Integer.valueOf(tab);

	List<University> uniListFilteredByChoiceCountry = new ArrayList();
	uniListFilteredByChoiceCountry = (List<University>) request.getAttribute("filteredUniCountry");
	if (uniListFilteredByChoiceCountry == null) {
		uniListFilteredByChoiceCountry = uniListFilteredByCountry;
	}
	List<String> countryList = new ArrayList();
	for (int i = 0; i < uniListFilteredByChoiceCountry.size(); i++) {
		if (!countryList.contains(uniListFilteredByChoiceCountry.get(i).getCountry())) {
			countryList.add(uniListFilteredByChoiceCountry.get(i).getCountry());
		}
	}

	List<String> fieldList = new ArrayList();
	List<University> uniListFilteredByChoiceField = new ArrayList();
	uniListFilteredByChoiceField = (List<University>) request.getAttribute("filteredUniField");
	if (uniListFilteredByChoiceField == null) {
		uniListFilteredByChoiceField = uniListFilteredByField;
		for (int i = 0; i < uniListFilteredByChoiceField.size(); i++) {
			for (int j = 0; j < uniListFilteredByChoiceField.get(i).getField().size(); j++) {
				if (!fieldList.contains(uniListFilteredByChoiceField.get(i).getField().get(j))) {
					fieldList.add(uniListFilteredByChoiceField.get(i).getField().get(j));
				}
			}
		}
	} else {
		fieldList.add((String) request.getAttribute("selectedField"));
	}

	List<String> languageList = new ArrayList();
	List<University> uniListFilteredByChoiceLanguage = new ArrayList();
	uniListFilteredByChoiceLanguage = (List<University>) request.getAttribute("filteredUniLanguage");
	if (uniListFilteredByChoiceLanguage == null) {
		uniListFilteredByChoiceLanguage = uniListFilteredByLanguage;
		for (int i = 0; i < uniListFilteredByChoiceLanguage.size(); i++) {
			for (int j = 0; j < uniListFilteredByChoiceLanguage.get(i).getLanguage().size(); j++) {
				if (!languageList.contains(uniListFilteredByChoiceLanguage.get(i).getLanguage().get(j))) {
					languageList.add(uniListFilteredByChoiceLanguage.get(i).getLanguage().get(j));
				}
			}
		}
	} else {
		languageList.add((String) request.getAttribute("selectedLanguage"));
	}
%>

<!DOCTYPE html>
<html lang="fr">
	<head>
  		<meta charset="utf-8" name="viewport" content="width=device-width, initial-scale=1">
  		<title>Destination List</title>
		<link rel="stylesheet" href="css/style.css">
		<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.8.1/css/all.css" integrity="sha384-50oBUHEmvpQ+1lW4y57PTFmhCaXp0ML5d60M1M7uH2+nqUivzIebhndOJK28anvf" crossorigin="anonymous">
		<script type="text/javascript" src="js/destinationList.js"></script>
	</head>

	<body onload="loading(<% out.println(currentTab); %>)">
  		<h1>Liste des destinations</h1>

		<div class="searchBar">
			<form method="post" action="/Annuaire" class="changebutton">
                <button class="studentListButton" type="submit">Annuaire des étudiants</button>
			</form>
			<div class="searchbaricon">
				<input type="text" placeholder="Rechercher...">
				<i class="fas fa-search"></i>
			</div>
			<div class="changebutton">
                <button onclick="login()" class="studentListButton" class="changebutton">Connexion</button>
			</div>
		</div>

  		<div class="navBar">
  			<form method="post" action="">
  				<button name="currentTab" value="1" type="submit">Par pays</button>
    		</form>
    		<span class="vertLine"></span>
    		<form method="post" action="">
  				<button name="currentTab" value="2" type="submit">Par domaine</button>
    		</form>
    		<span class="vertLine"></span>
    		<form method="post" action="">
  				<button name="currentTab" value="3" type="submit">Par langue</button>
    		</form>
  		</div>

  		<div class="loginErrorMessage">
  			<% if (errorMessage != null) {
  				out.println(errorMessage);
  			} %>
  		</div>

  		<div class="dropDown" id="myDropdown">
    		<form id="countryForm" method="post" action="">
    			<input name="currentTab" value="1" type="hidden">
    			<input type="text" placeholder="Sélectionner un pays" name="countryParam" list="country">
    			<datalist id="country">
        			<% for(String myCountry: fullCountryList){ %>
						<option type="submit" value="<% out.println(myCountry); %>"> <% out.println(myCountry); %> </option>
	    			<% } %>
    			</datalist>
    		</form>
    		<form id="fieldForm" method="post" action="">
    			<input name="currentTab" value="2" type="hidden">
    			<input type="text" placeholder="Sélectionner un domaine" name="fieldParam" list="field">
    			<datalist id="field">
					<% for(String myField: allFields){ %>
						<option type="submit" value="<% out.println(myField); %>"> <% out.println(myField); %> </option>
					<% } %>
    			</datalist>
    		</form>
    		<form id="languageForm" method="post" action="">
    			<input name="currentTab" value="3" type="hidden">
    			<input type="text" placeholder="Sélectionner une langue" name="languageParam" list="language">
    			<datalist id="language">
    				<% for(String myLanguage: allLanguages){ %>
						<option type="submit" value="<% out.println(myLanguage); %>"> <% out.println(myLanguage); %> </option>
	    			<% } %>
    			</datalist>
    		</form>
  		</div>

  		<div class="content" id="myContentCountry">
    		<% for(String myCountry: countryList){
    			out.println("<h2 class='categorytitle'>" + myCountry + "</h2>"); %>
				<% for(University myUni: uniListFilteredByChoiceCountry) {
					if (myUni.getCountry().equals(myCountry)) { %>
						<div class="contentCategory">
							<div class="university">
								<div class="universityName">
                    				<% out.println("<h3><a href='"+ myUni.getUrl() +"' target='_blank'>"+ myUni.getName() + "</a></h3>");%>
									<span class="horiLine"></span>
								</div>
								<div class="universityInfo">
                                    <ul>
                                        <% out.println("<li><span><b> Localisation : </b>" + myUni.getCountry() + ", " + myUni.getCity() + "</span></li>");%>
										<% if (myUni.getLanguage() != null) {
											if (myUni.getLanguage().size() > 1){
												out.println("<li><span><b> Langues : </b>"+myUni.getListString(myUni.getLanguage())+"</span></li>");
											}
											else{
												out.println("<li><span><b> Langue : </b>"+myUni.getListString(myUni.getLanguage())+"</span></li>");
											}
										} %>
										<% if (myUni.getField() != null) {
											if(myUni.getField().size() > 1){
												out.println("<li><span><b> Domaines : </b>"+myUni.getListString(myUni.getField())+"</span></li>");
											}
											else{
												out.println("<li><span><b> Domaine : </b>"+myUni.getListString(myUni.getField())+"</span></li>");
											}
										} %>
                                        <% if(myUni.getQuota() != 0){
                                            out.println("<li><span><b> Quota : </b>" + myUni.getQuota() + "</span></li>");
                                        	}
                                        	else{
                                            	out.println("Il n'y a pas de quota pour cette univeritsé.");
										}%>
                                        <% if (myUni.getDescription() != null) {
                                            out.println("<li><span><b> Informations : </b>" + myUni.getDescription() + "</span></li>");
                                        } %>
                                    </ul>
                                    <span class="horiLine"></span>
								</div>
								<div class="commentSection">
									<span>Commentaires</span>
									<% if (allComments != null){
                                    	for(Comment com: allComments){
                                            if(com.getId_university()== myUni.getId() && com.isAccepted()){
                                                out.println(CommentServlet.displayComment(com));
                                            }
                                        }
                                    } %>
									<div class="uniButtons">
				                		<div class="invisibleButton"></div>
				                		<button onclick="shareComment(`<% out.println(myUni.getName()); %>`,`<% out.println(myUni.getId()); %>`)">Partager mon expérience</button>
				                		<button class="warningButton" onclick="sendWarning(`<% out.println(myUni.getName()); %>`,`<% out.println(myUni.getId()); %>`)">Signaler</button>
				                	</div>
								</div>
							</div>
						</div>
					<% } %>
				<% } %>
			<% } %>
    	</div>

		<div class="content" id="myContentField">
			<% for(String myField: fieldList){
				out.println("<h2 class='categorytitle'>" + myField + "</h2>"); %>
				<% for(University myUni: uniListFilteredByChoiceField) {
					if (myUni.getField().contains(myField)) { %>
						<div class="contentCategory">
        					<div class="university">
								<div class="universityName">
                    				<% out.println("<h3>"+ myUni.getName() + "</h3>");%>
                					<span class="horiLine"></span>
								</div>
           						<div class="universityInfo">
									<ul>
										<% out.println("<li><span><b> Localisation : </b>" + myUni.getCountry() + ", " + myUni.getCity() + "</span></li>");%>
										<% if (myUni.getLanguage() != null) {
											if (myUni.getLanguage().size() > 1){
												out.println("<li><span><b> Langues : </b>"+myUni.getListString(myUni.getLanguage())+"</span></li>");
											}
											else{
												out.println("<li><span><b> Langue : </b>"+myUni.getListString(myUni.getLanguage())+"</span></li>");
											}
										} %>
										<% if (myUni.getField() != null) {
											if(myUni.getField().size() > 1){
												out.println("<li><span><b> Domaines : </b>"+myUni.getListString(myUni.getField())+"</span></li>");
											}
											else{
												out.println("<li><span><b> Domaine : </b>"+myUni.getListString(myUni.getField())+"</span></li>");
											}
										} %>
										<% if(myUni.getQuota() != 0){
											out.println("<li><span><b> Quota : </b>" + myUni.getQuota() + "</span></li>");
										}
										else{
											out.println("<li>Il n'y a pas de quota pour cette univeritsé.</li>");
										}%>
										<% if (myUni.getDescription() != null) {
											out.println("<li><span><b> Informations : </b>" + myUni.getDescription() + "</span></li>");
										} %>
									</ul>
                					<span class="horiLine"></span>
            					</div>
            					<div class="commentSection">
                					<span>Commentaires</span>
                                    <% if (allComments != null){
                                    	for(Comment com: allComments){
                                            if(com.getId_university()== myUni.getId() && com.isAccepted()){
                                                out.println(CommentServlet.displayComment(com));
                                            }
                                        }
                                    } %>
                					<div class="uniButtons">
				                		<div class="invisibleButton"></div>
				                		<button onclick="shareComment(`<% out.println(myUni.getName()); %>`,`<% out.println(myUni.getId()); %>`)">Partager mon expérience</button>
				                		<button class="warningButton" onclick="sendWarning(`<% out.println(myUni.getName()); %>`,`<% out.println(myUni.getId()); %>`)">Signaler</button>
				                	</div>
            					</div>
        					</div>
    					</div>
    				<% } %>
				<% } %>
			<% } %>
    	</div>

  		<div class="content" id="myContentLanguage">
    		<% for(String myLanguage: languageList){
    			out.println("<h2 class='categorytitle'>" + myLanguage + "</h2>"); %>
				<% for(University myUni: uniListFilteredByChoiceLanguage) {
					if (myUni.getLanguage().contains(myLanguage)) { %>
						<div class="contentCategory">
        					<div class="university">
            					<div class="universityName">
                    				<% out.println("<h3>"+ myUni.getName() + "</h3>");%>
                					<span class="horiLine"></span>
            					</div>
           						<div class="universityInfo">
									<ul>
										<% out.println("<li><span><b> Localisation : </b>" + myUni.getCountry() + ", " + myUni.getCity() + "</span></li>");%>
										<% if (myUni.getLanguage() != null) {
											if (myUni.getLanguage().size() > 1){
												out.println("<li><span><b> Langues : </b>"+myUni.getListString(myUni.getLanguage())+"</span></li>");
											}
											else{
												out.println("<li><span><b> Langue : </b>"+myUni.getListString(myUni.getLanguage())+"</span></li>");
											}
										} %>
										<% if (myUni.getField() != null) {
											if(myUni.getField().size() > 1){
												out.println("<li><span><b> Domaines : </b>"+myUni.getListString(myUni.getField())+"</span></li>");
											}
											else{
												out.println("<li><span><b> Domaine : </b>"+myUni.getListString(myUni.getField())+"</span></li>");
											}
										} %>
										<% if(myUni.getQuota() != 0){
											out.println("<li><span><b> Quota : </b>" + myUni.getQuota() + "</span></li>");
										}
										else{
											out.println("<li>Il n'y a pas de quota pour cette univeritsé.</li>");
										}%>
										<% if (myUni.getDescription() != null) {
											out.println("<li><span><b> Informations : </b>" + myUni.getDescription() + "</span></li>");
										} %>
									</ul>
                					<span class="horiLine"></span>
            					</div>
            					<div class="commentSection">
                					<span>Commentaires</span>
                                    <% if (allComments != null){
                                    	for(Comment com: allComments){
                                            if(com.getId_university()== myUni.getId() && com.isAccepted()){
                                                out.println(CommentServlet.displayComment(com));
                                            }
                                        }
                                    } %>
                					<div class="uniButtons">
										<div id="buttonexpe">
				                			<button onclick="shareComment(`<% out.println(myUni.getName()); %>`,`<% out.println(myUni.getId()); %>`)">Partager mon expérience</button>
										</div>
										<div id="buttonalert">
				                			<button class="warningButton" onclick="sendWarning(`<% out.println(myUni.getName()); %>`,`<% out.println(myUni.getId()); %>`)">Signaler</button>
										</div>
				                	</div>
            					</div>
        					</div>
    					</div>
    				<% } %>
				<% } %>
			<% } %>
    	</div>

		<div id="commentModal" class="modal">
			<div class="modal-content">
				<span class="close-button" onclick="closeModal()">×</span>
				<span class="modalTitle">Partager mon expérience</span>
				<span id="modalUniversityTitle">Université</span>
				<form  method="post" action="CommentServlet" id="addComment">
					<div class="comment">
						<span class="modalTitle2">Commentaire</span>
						<textarea id="commentTextArea" name="comContent" form="addComment" class="writtenCom" maxlength="255">Commentaire</textarea>
					</div>
					<div class="studentInfo">
						<span class="modalTitle2">Information</span>
						<div>
							<label for="firstName">Prénom*:</label><input type="text" id="firstName" name="studentFirstName" required maxlength="45">
						</div>
						<div>
							<label for="lastName">Nom*:</label><input type="text" id="lastName" name="studentLastName" required maxlength="45">
						</div>
						<div>
							<label for="mail">Mail*:</label><input type="email" name="studentMail" required maxlength="45">
						</div>
						<input type="hidden" value="" id="id_uni" name="id_university">
						<button class="sendButton" type="submit">Envoyer</button>
					</div>
				</form>
			</div>
		</div>

		<div id="loginModal" class="modal">
			<div class="loginModal-content">
				<span class="close-button" onclick="closeLoginModal()">×</span>
				<span class="modalTitle">Connexion</span>
				<form  method="post" action="">
					<div class="studentInfo">
						<div>
							<label for="userName">Nom d'utilisateur:</label><input type="text" id="userName" name="userName" required maxlength="45">
						</div>
						<div>
							<label for="password">Mot de passe:</label><input type="password" id="password" name="password" required maxlength="45">
						</div>
						<button class="sendButton" type="submit">Envoyer</button>
					</div>
				</form>
			</div>
		</div>

		<div id="warningModal" class="modal">
			<div class="modal-content">
				<span class="close-button" onclick="closeWarning()">×</span>
				<span class="modalTitle">Signaler</span>
				<span id="warningUniversityTitle">Université</span>
				<form  method="post" action="AlertServlet">
					<div class="studentInfo">
					<span class="modalTitle2">Rapport</span><br/>
						<div>
							<label for="mail">Mail*:</label> <input type="email" name="studentMail" required maxlength="45">
						</div>
						<div>
							<label for="reason">Raison:</label>
							<select name="reason" id="reason">
								<option value="abscence">Manque d'information</option>
								<option value="fault">Information mauvaise ou erronée</option>
								<option value="other">Autre</option>
							</select>
						</div>
						<br/>
						<label for="comContent">Description du problème :</label>
						<textarea id="alertTextArea" name="alertContent" class="writtenCom" maxlength="255"></textarea>
					</div>
					<div class="studentInfo">
						<input type="hidden" value="" id="id_uni_alert" name="id_university">
						<button id="sendButton" type="submit">Envoyer</button>
					</div>
				</form>
			</div>
		</div>

	</body>
</html>