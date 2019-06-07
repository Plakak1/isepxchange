<%@ page import="java.util.*" %>
<%@ page import="gl.model.University" %>
<%@ page import="org.apache.commons.lang3.StringEscapeUtils" %>
<%@ page import="gl.servlet.DbDao" %>
<%@ page import="gl.model.Comment" %>
<%@ page import="gl.servlet.CommentServlet" %>
<%@ page import="org.apache.commons.lang3.StringUtils" %>

<%@ page contentType="text/html; charset=UTF-8" language="java" %>

<%
	Comparator<University> compareByCountry = (University o1, University o2) -> o1.getCountry().compareTo(o2.getCountry());
	// Comparator<University> compareByField = (University o1, University o2) -> o1.getField().compareTo(o2.getField());
	// Comparator<University> compareByLanguage = (University o1, University o2) -> o1.getLanguage().compareTo(o2.getLanguage());
	
	// *** Separation Comparators and the university lists ***
	
	List<University> uniListFilteredByCountry = new ArrayList();
	List<University> uniListFilteredByField = new ArrayList();
	List<University> uniListFilteredByLanguage = new ArrayList();
	
	List<String> allLanguages = new ArrayList();
	List<String> allFields = new ArrayList();

	uniListFilteredByCountry = (List<University>) request.getAttribute("allUniversities");
	allLanguages = (List<String>) request.getAttribute("allLanguages");
	allFields = (List<String>) request.getAttribute("allFields");
	
	uniListFilteredByField.addAll(uniListFilteredByCountry);
	uniListFilteredByLanguage.addAll(uniListFilteredByCountry);

	
	
	Collections.sort(uniListFilteredByCountry, compareByCountry);
	// Collections.sort(uniListFilteredByField, compareByField);
	// Collections.sort(uniListFilteredByLanguage, compareByLanguage);
	
	List<String> fullCountryList = new ArrayList();
	for (int i = 0; i < uniListFilteredByCountry.size(); i++) {
		if (!fullCountryList.contains(uniListFilteredByCountry.get(i).getCountry())) {
			fullCountryList.add(uniListFilteredByCountry.get(i).getCountry());
		}
	}

	// *** Separation beteween full university lists above, and filtered ones below ***
	
	String tab = (String) request.getAttribute("currentTab");;
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
		<link rel="stylesheet" href="Styling/style.css">
		<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.8.1/css/all.css" integrity="sha384-50oBUHEmvpQ+1lW4y57PTFmhCaXp0ML5d60M1M7uH2+nqUivzIebhndOJK28anvf" crossorigin="anonymous">
		<script type="text/javascript" src="Scripts/destinationListScript.js"></script>
	</head>

	<body onload="loading(<% out.println(currentTab); %>)">
  		<h1>Liste des destinations</h1>

  		<div class="searchBar">
            <form method="post" action="/GL/Annuaire" class="changebutton">
                <button class="studentListButton" type="submit">Annuaire des étudiants</button>
            </form>
			<div class="searchbaricon">
    			<input type="text" placeholder="Rechercher...">
    			<i class="fas fa-search"></i>
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
												out.println("<span><b> Langues : </b>"+myUni.getListString(myUni.getLanguage())+"</span><br/>");
											}
											else{
												out.println("<span><b> Langue : </b>"+myUni.getListString(myUni.getLanguage())+"</span><br/>");
											}
										} %>
										<% if (myUni.getField() != null) {
											if(myUni.getField().size() > 1){
												out.println("<span><b> Domaines : </b>"+myUni.getListString(myUni.getField())+"</span>");
											}
											else{
												out.println("<span><b> Domaine : </b>"+myUni.getListString(myUni.getField())+"</span>");
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
									<% for(Comment com: CommentServlet.getComment()){
										if(com.getId_university()== myUni.getId() && com.isAccepted()){
											out.println(CommentServlet.displayComment(com));
										}
									}%>
									<button onclick="shareComment(`<% out.println(myUni.getName()); %>`,`<% out.println(myUni.getId()); %>`)">Partager mon expérience</button>
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
            						<% out.println("<span><b> Localisation : </b>" + myUni.getCountry() + ", " + myUni.getCity() + "</span>");%>
									<% if (myUni.getLanguage() != null) {
										if (myUni.getLanguage().size() > 1){
											out.println("<span><b> Langues : </b>"+myUni.getListString(myUni.getLanguage())+"</span><br/>");
										}
										else{
											out.println("<span><b> Langue : </b>"+myUni.getListString(myUni.getLanguage())+"</span><br/>");
										}
									} %>
									<% if (myUni.getField() != null) {
										if(myUni.getField().size() > 1){
											out.println("<span><b> Domaines : </b>"+myUni.getListString(myUni.getField())+"</span>");
										}
										else{
											out.println("<span><b> Domaine : </b>"+myUni.getListString(myUni.getField())+"</span>");
										}
            						} %>
                                    <% if(myUni.getQuota() != 0){
                                        out.println("<span><b> Quota : </b>" + myUni.getQuota() + "</span>");
                                    }
                                    else{
                                        out.println("Il n'y a pas de quota pour cette univeritsé.");
                                    }%>
                					<% if (myUni.getDescription() != null) {
                    					out.println("<span> Informations : " + myUni.getDescription() + "</span>");
                					} %>
                					<span class="horiLine"></span>
            					</div>
            					<div class="commentSection">
                					<span>Commentaires</span>
                                    <% for(Comment com: CommentServlet.getComment()){
                                        if(com.getId_university()== myUni.getId() && com.isAccepted()){
											out.println(CommentServlet.displayComment(com));
                                        }
                                    }%>
                					<button onclick="shareComment(`<% out.println(myUni.getName()); %>`,`<% out.println(myUni.getId()); %>`)">Partager mon expérience</button>
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
            						<% out.println("<span><b> Localisation : </b>" + myUni.getCountry() + ", " + myUni.getCity() + "</span>");%>
									<% if (myUni.getLanguage() != null) {
										if (myUni.getLanguage().size() > 1){
											out.println("<span><b> Langues : </b>"+myUni.getListString(myUni.getLanguage())+"</span><br/>");
										}
										else{
											out.println("<span><b> Langue : </b>"+myUni.getListString(myUni.getLanguage())+"</span><br/>");
										}
									} %>
									<% if (myUni.getField() != null) {
										if(myUni.getField().size() > 1){
											out.println("<span><b> Domaines : </b>"+myUni.getListString(myUni.getField())+"</span>");
										}
										else{
											out.println("<span><b> Domaine : </b>"+myUni.getListString(myUni.getField())+"</span>");
										}
									} %>
									<% if(myUni.getQuota() != 0){
									    out.println("<span><b> Quota : </b>" + myUni.getQuota() + "</span>");
                                    }
                                    else{
                                        out.println("Il n'y a pas de quota pour cette univeritsé.");
                                    }%>
                					<% if (myUni.getDescription() != null) {
                    					out.println("<span><b> Informations : </b>" + myUni.getDescription() + "</span>");
                					} %>
                					<span class="horiLine"></span>
            					</div>
            					<div class="commentSection">
                					<span>Commentaires</span>
                                    <% for(Comment com: CommentServlet.getComment()){
                                        if(com.getId_university()== myUni.getId() && com.isAccepted()){
                                            out.println(CommentServlet.displayComment(com));
                                        }
                                    }%>
                					<button onclick="shareComment(`<% out.println(myUni.getName()); %>`,`<% out.println(myUni.getId()); %>`)">Partager mon expérience</button>
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
							<label for="mail">Mail*:</label><input type="email" id="mail" name="studentMail" required maxlength="45">
						</div>
						<input type="hidden" value="" id="id_uni" name="id_university">
						<button id="sendButton" type="submit">Envoyer</button>
					</div>
				</form>
			</div>
		</div>

	</body>
</html>