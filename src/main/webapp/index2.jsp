<%@ page import="java.util.*" %>
<%@ page import="gl.model.University" %>

<%@ page contentType="text/html; charset=UTF-8" %>

<%
	List<University> universityList = new ArrayList();
	universityList = (List<University>) request.getAttribute("allUniversities");
	
	String filter = (String) request.getAttribute("filter");
	filter = filter.replaceAll("\\s+","");
	
	List<String> uniList = new ArrayList();
	if (filter.equals("country")) {
		for (int i = 0; i < universityList.size(); i++) {
			if (!uniList.contains(universityList.get(i).getCountry())) {
				uniList.add(universityList.get(i).getCountry());
			}
		}
	}
	if (filter.equals("domain")) {
		for (int i = 0; i < universityList.size(); i++) {
			if (!uniList.contains(universityList.get(i).getField())) {
				uniList.add(universityList.get(i).getField());
			}
		}
	}
	
	
	List<String> filteredUniList = new ArrayList();
	
	List<University> filteredUniversityList = new ArrayList();
	filteredUniversityList = (List<University>) request.getAttribute("filteredUniversities");
	if (filteredUniversityList == null) {
		filteredUniversityList = universityList;
		filteredUniList = uniList;
	} else {
		if (filter.equals("country")) {
			for (int i = 0; i < filteredUniversityList.size(); i++) {
				if (!filteredUniList.contains(filteredUniversityList.get(i).getCountry())) {
					filteredUniList.add(filteredUniversityList.get(i).getCountry());
				}
			}
		}
		if (filter.equals("domain")) {
			for (int i = 0; i < filteredUniversityList.size(); i++) {
				if (!filteredUniList.contains(filteredUniversityList.get(i).getField())) {
					filteredUniList.add(filteredUniversityList.get(i).getField());
				}
			}
		}
	}
	System.out.println(filteredUniList);
	
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

<body>
  <h2>Liste des destinations</h2>

  <div class="searchBar">
    <input type="text" placeholder="Rechercher...">
    <i class="fas fa-search"></i>
  </div>

  <div class="navBar">
  	<form class="resetForm" method="post" action="">
  	<input type="hidden" name="columnParam" value="country" />
 	<button type="submit" name="resetList" value="country">Par pays</button>
    </form>
    <form class="resetForm" method="post" action="">
    <input type="hidden" name="columnParam" value="domain" />
 	<button type="submit" name="resetList" value="domain">Par domaine</button>
    </form>
    <form class="resetForm" method="post" action="">
    <input type="hidden" name="columnParam" value="language" />
 	<button type="submit" name="resetList" value="language">Par langue</button>
    </form>
    <form class="resetForm" method="post" action="">
 	<button type="submit" name="resetList" value="exchange">Par type d'échange</button>
    </form>
  </div>
  

  <div class="dropDown" id="myDropdown">
    <form id="countryForm" method="post" action="">
    <input type="text" placeholder="Sélectionner un pays" name="filterParam" list="university">
    <datalist id="university">
        <% 
		for(String uni : uniList){
	      	 out.println("<option type='submit' value=" + "'" +  uni + "'" + ">");
	     }
         %>
    </datalist>
    <input type="hidden" name="columnParam" value="<% out.println(filter); %>" />
    </form>
  </div>
  
  <form method="post" action="/GL/Annuaire">
      <button class="studentListButton" type="submit">Annuaire des étudiants</button>
  </form>
  
  
  
  
  
  
  
  
    <div class="content" id="myContentCountry">
    <% 
	for(String filterName: filteredUniList){
		out.println("<span class='categoryTitle'>" + filterName + "</span>"); %>
		<% for(University myUni: filteredUniversityList) {
			if (myUni.getCountry().equals(filterName)) { %>
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
					<textarea id="commentTextArea" class="writtenCom" maxlength="255">Commentaire</textarea>
				</div>
				<div class="studentInfo">
					<span class="modalTitle2">Information</span>
					<div>
						<label for="lastName">Prénom*:</label> <input type="text" name="lastName"
							required maxlength="50">
					</div>
					<div>
						<label for="firstName">Nom*:</label> <input type="text" name="firstName"
							required maxlength="50">
					</div>
					<div>
						<label for="mail">Mail*:</label> <input type="email" name="mail"
							required maxlength="50">
					</div>
					<div>
						<label for="telephone">Téléphone:</label> <input type="tel"
							name="telephone" maxlength="20">
					</div>
					<button id="sendButton" type="submit">Envoyer</button>
				</div>
			</form>
		</div>
	</div>


</body>
</html>