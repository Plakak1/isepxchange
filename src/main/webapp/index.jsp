<%@ page import="java.util.*" %>
<%@ page import="gl.model.University" %>

<%@ page contentType="text/html; charset=UTF-8" %>

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
  <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.8.1/css/all.css"
  integrity="sha384-50oBUHEmvpQ+1lW4y57PTFmhCaXp0ML5d60M1M7uH2+nqUivzIebhndOJK28anvf" crossorigin="anonymous">
  <script type="text/javascript" src="Scripts/destinationListScript.js"></script>
</head>

<body onload="loading(<% out.println(currentTab); %>)">
  <h2>Liste des destinations</h2>

  <div class="searchBar">
    <input type="text" placeholder="Rechercher...">
    <i class="fas fa-search"></i>
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
        <% 
		for(String myCountry: fullCountryList){
	      	 out.println("<option type='submit' value=" + "'" +  myCountry + "'" + ">");
	     }
         %>
    </datalist>
    </form>
    <form id="fieldForm" method="post" action="">
    <input name="currentTab" value="2" type="hidden">
    <input type="text" placeholder="Sélectionner un domaine" name="fieldParam" list="field">
    <datalist id="field">
        <% 
		for(String myField: allFields){
	      	 out.println("<option type='submit' value=" + "'" + myField + "'" + ">");
	     }
         %>
    </datalist>
    </form>
    <form id="languageForm" method="post" action="">
    <input name="currentTab" value="3" type="hidden">
    <input type="text" placeholder="Sélectionner une langue" name="languageParam" list="language">
    <datalist id="language">
        <% 
		for(String myLanguage: allLanguages){
	      	 out.println("<option type='submit' value=" + "'" +  myLanguage + "'" + ">");
	     }
         %>
    </datalist>
    </form>
  </div>
  
  <form method="post" action="/GL/Annuaire">
      <button class="studentListButton" type="submit">Annuaire des étudiants</button>
  </form>
  
  
  
  
  
  
  
  
    <div class="content" id="myContentCountry">
    <% 
	for(String myCountry: countryList){
		out.println("<span class='categoryTitle'>" + myCountry + "</span>"); %>
		<% for(University myUni: uniListFilteredByChoiceCountry) { 
			if (myUni.getCountry().equals(myCountry)) { %>
			<div class="contentCategory">
        		<div class="university">
            	<div class="universityName">
         			<% out.println("<span> Université " + myUni.getName() + "</span>");%>
                	<span class="horiLine"></span>
            	</div>
           		<div class="universityInfo">
            		<% out.println("<span> Localisation : " + myUni.getCountry() + ", " + myUni.getCity() + "</span>");%>
            		<% for(String language : myUni.getLanguage()) { 
            			out.println("<span> Langue : " + language + "</span>");
            		} %>
            		<% for(String field : myUni.getField()) { 
            			out.println("<span> Domaine : " + field + "</span>");
            		} %>
                	<% if (myUni.getDescription() != null) {
                    	out.println("<span> Informations : " + myUni.getDescription() + "</span>");
                	} %>
                	<span class="horiLine"></span>
            	</div>
            	<div class="commentSection">
                	<span>Commentaires</span>
                	<button onclick="shareComment(`<% out.println(myUni.getName()); %>`)">Partager mon expérience</button>
            	</div>
        	</div>
    	</div>
			<% } %>
		<% } %>
	<% } %>
    </div>
  
   <div class="content" id="myContentField">
    <% 
	for(String myField: fieldList){
		out.println("<span class='categoryTitle'>" + myField + "</span>"); %>
		<% for(University myUni: uniListFilteredByChoiceField) {
		if (myUni.getField().contains(myField)) { %>
			<div class="contentCategory">
        		<div class="university">
            	<div class="universityName">
         			<% out.println("<span> Université " + myUni.getName() + "</span>");%>
                	<span class="horiLine"></span>
            	</div>
           		<div class="universityInfo">
            		<% out.println("<span> Localisation : " + myUni.getCountry() + ", " + myUni.getCity() + "</span>");%>
            		<% out.println("<span> Langue : " + myUni.getLanguage() + "</span>");%>
            		<% if (myUni.getField() != null) {
                    	out.println("<span> Domaine : " + myUni.getField() + "</span>");
                	} %>
                	<% if (myUni.getDescription() != null) {
                    	out.println("<span> Informations : " + myUni.getDescription() + "</span>");
                	} %>
                	<span class="horiLine"></span>
            	</div>
            	<div class="commentSection">
                	<span>Commentaires</span>
                	<button onclick="shareComment(`<% out.println(myUni.getName()); %>`)">Partager mon expérience</button>
            	</div>
        	</div>
    	</div>
    	<% } %>
		<% } %>
	<% } %>
    </div>
  
  <div class="content" id="myContentLanguage">
    <% 
	for(String myLanguage: languageList){
		out.println("<span class='categoryTitle'>" + myLanguage + "</span>"); %>
		<% for(University myUni: uniListFilteredByChoiceLanguage) {
		if (myUni.getLanguage().contains(myLanguage)) { %>
			<div class="contentCategory">
        		<div class="university">
            	<div class="universityName">
         			<% out.println("<span> Université " + myUni.getName() + "</span>");%>
                	<span class="horiLine"></span>
            	</div>
           		<div class="universityInfo">
            		<% out.println("<span> Localisation : " + myUni.getCountry() + ", " + myUni.getCity() + "</span>");%>
            		<% out.println("<span> Langue : " + myUni.getLanguage() + "</span>");%>
            		<% if (myUni.getField() != null) {
                    	out.println("<span> Domaine : " + myUni.getField() + "</span>");
                	} %>
                	<% if (myUni.getDescription() != null) {
                    	out.println("<span> Informations : " + myUni.getDescription() + "</span>");
                	} %>
                	<span class="horiLine"></span>
            	</div>
            	<div class="commentSection">
                	<span>Commentaires</span>
                	<button onclick="shareComment(`<% out.println(myUni.getName()); %>`)">Partager mon expérience</button>
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
			<form  method="post" action="">
				<div class="comment">
					<span class="modalTitle2">Commentaire</span>
					<textarea id="commentTextArea" name="comContent" class="writtenCom" maxlength="255">Commentaire</textarea>
				</div>
				<div class="studentInfo">
					<span class="modalTitle2">Information</span>
					<div>
						<label for="lastName">Prénom*:</label> <input type="text" name="firstName"
							name="studentLastName" required maxlength="45">
					</div>
					<div>
						<label for="firstName">Nom*:</label> <input type="text" name="lastName"
							name="studentFirstName" required maxlength="45">
					</div>
					<div>
						<label for="mail">Mail*:</label> <input type="email" name="mail"
							name="studentMail" required maxlength="45">
					</div>
					<button id="sendButton" type="submit">Envoyer</button>
				</div>
			</form>
		</div>
	</div>


</body>
</html>