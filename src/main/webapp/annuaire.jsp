<%@ page import="java.util.*" %>
<%@ page import="gl.model.Student" %>

<%@ page contentType="text/html; charset=UTF-8" %>

<%
	Comparator<Student> compareByUniversityCountry = (Student o1, Student o2) -> o1.getUniversityCountry().compareTo(o2.getUniversityCountry());
	
	// *** Separation Comparators and the university lists ***
	
	int currentTab = 1;
	
	List<Student> fullStudentList = new ArrayList();
	fullStudentList = (List<Student>) request.getAttribute("allStudents");
	
	Collections.sort(fullStudentList, compareByUniversityCountry);
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

<body onload="studentListLoading(<% out.println(currentTab); %>)">
  <h2>Liste des étudiants</h2>
  
  <div class="searchBar">
    <input type="text" placeholder="Rechercher...">
    <i class="fas fa-search"></i>
  </div>
  
  <div class="navBar">
    <span id="filterNavBarStudent" onclick="selectedStudentFilter(1)">Par pays</span>
    <span class="vertLine"></span>
    <span id="filterNavBarStudent" onclick="selectedStudentFilter(2)">Par nouveauté</span>
  </div>
  
  <div class="dropDown" id="myDropdownStudent">
    <form id="countryStudentForm" method="post" action="">
    <input type="text" placeholder="Sélectionner un pays" name="studentCountryParam" list="studentCountry">
    <datalist id="studentCountry">
        <% 
		for(Student myStud: fullStudentList){
	      	 out.println("<option type='submit' value=" +  myStud.getUniversityCountry() + ">");
	     }
         %>
    </datalist>
    </form>
    <form id="yearForm" method="post" action="">
    <input type="text" placeholder="Sélectionner une année" name="yearParam" list="year">
    <datalist id=year>
        <% 
		for(Student myStud: fullStudentList){
	      	 out.println("<option type='submit' value=" +  myStud.getYear() + ">");
	     }
         %>
    </datalist>
    </form>
  </div>
  
  <form method="post" action="/GL">
      <button class="studentListButton" type="submit">Liste des universités</button>
  </form>
  
  <% for(Student myStudent: fullStudentList){ %>
  <div class="annuaireStudentList">
  <div class="annuaireStudentInfo">
  	  <h2>Informations sur l'étudiant</h2>
  	  <div>
  	  	<span>Nom : </span>
   	  	<% out.println(myStudent.getFirstName() + " " + myStudent.getLastName()); %>
  	  </div>
  	  <div>
  	  	<span>Mail : </span>
   	  	<% out.println(myStudent.getMail()); %>
  	  </div>
  </div>
  <div class="annuaireUniversityInfo">
	  <h2>Détails du séjour réalisé</h2>
	  <div>
  	  	<span>Période : </span>
   	  	<% out.println(myStudent.getStartDate() + " - " + myStudent.getEndDate()); %>
  	  </div>
  	  <div>
  	  	<span>Université : </span>
   	  	<% out.println(myStudent.getUniversityName() + " en " + myStudent.getUniversityCountry()); %>
  	  </div>
  </div>
  </div>
  	<% } %>
  
</body>
</html>