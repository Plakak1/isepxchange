<%@ page import="java.util.*" %>
<%@ page import="gl.model.Student" %>

<%@ page contentType="text/html; charset=UTF-8" language="java" %>

<%
	Comparator<Student> compareByUniversityCountry = (Student o1, Student o2) -> o1.getUniversityCountry().compareTo(o2.getUniversityCountry());
	
	// *** Separation Comparators and the university lists ***
	
	int currentTab = 1;
	
	List<Student> fullStudentList = new ArrayList();
	fullStudentList = (List<Student>) request.getAttribute("allStudents");
	
	List<Student> studentListFilteredByCountry = new ArrayList<>();
	studentListFilteredByCountry = (List<Student>) request.getAttribute("studentsFilteredByCountry");
	if (studentListFilteredByCountry == null) {
		studentListFilteredByCountry = fullStudentList;
	}

	List<String> fullCountryList = new ArrayList();
	for (int i = 0; i < fullStudentList.size(); i++) {
		if (!fullCountryList.contains(fullStudentList.get(i).getUniversityCountry())) {
			fullCountryList.add(fullStudentList.get(i).getUniversityCountry());
		}
	}
	
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
        <h1>Liste des étudiants</h1>

        <div class="searchBar">
            <form method="post" action="/GL" class="changebutton">
                <button class="studentListButton" type="submit">Liste des universités</button>
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
                <button name="currentTab" value="2" type="submit">Par nouveauté</button>
            </form>
        </div>

        <div class="dropDown" id="myDropdownStudent">
            <form id="countryStudentForm" method="post" action="">
                <input type="text" placeholder="Sélectionner un pays" name="studentCountryParam" list="studentCountry">
                <datalist id="studentCountry">
                    <% for(String myCountry: fullCountryList){
                        out.println("<option type='submit' value=" + myCountry + ">");
                    } %>
                </datalist>
            </form>
            <form id="yearForm" method="post" action="">
                <input type="text" placeholder="Sélectionner une année" name="yearParam" list="year">
                <datalist id=year>
                    <% for(Student myStud: fullStudentList){
                        out.println("<option type='submit' value=" +  myStud.getYear() + ">");
                    } %>
                </datalist>
            </form>
        </div>

        <% for(Student myStudent: studentListFilteredByCountry){ %>
            <div class="annuaireStudentList">
                <div class="annuaireStudentInfo">
                    <h4>Informations sur l'étudiant</h4>
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
                    <h4>Détails du séjour réalisé</h4>
                    <div>
                        <span>Université : </span>
                        <% out.println(myStudent.getUniversityName() + " en " + myStudent.getUniversityCountry()); %>
                    </div>
                    <div>
                        <span>Période : </span>
                        <% out.println(myStudent.getStartDate() + " à " + myStudent.getEndDate()); %>
                    </div>
                </div>
            </div>
        <% } %>

    </body>
</html>