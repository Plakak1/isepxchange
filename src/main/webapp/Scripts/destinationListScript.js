function loading(currentTab) {
	var myContentField = document.getElementById("myContentCountry");
	var myContentField = document.getElementById("myContentField");
	var myContentLanguage = document.getElementById("myContentLanguage");
	
	var countryForm = document.getElementById("countryForm");
	var fieldForm = document.getElementById("fieldForm");
	var languageForm = document.getElementById("languageForm");
	var exchangeTypeForm = document.getElementById("exchangeTypeForm");

	if (currentTab == 1) {
		myContentCountry.style.display = "block";
		myContentField.style.display = "none";
		myContentLanguage.style.display = "none";
		
		countryForm.style.display = "block";
		fieldForm.style.display = "none";
		languageForm.style.display = "none";
		exchangeTypeForm.style.display = "none";
	}
	if (currentTab == 2) {
		myContentCountry.style.display = "none";
		myContentField.style.display = "block";
		myContentLanguage.style.display = "none";
		
		countryForm.style.display = "none";
		fieldForm.style.display = "block";
		languageForm.style.display = "none";
		exchangeTypeForm.style.display = "none";
	}
	if (currentTab == 3) {
		myContentCountry.style.display = "none";
		myContentField.style.display = "none";
		myContentLanguage.style.display = "block";
		
		countryForm.style.display = "none";
		fieldForm.style.display = "none";
		languageForm.style.display = "block";
		exchangeTypeForm.style.display = "none";
	}
}

function selectedFilter(value) {
  var countryForm = document.getElementById("countryForm");
  var fieldForm = document.getElementById("fieldForm");
  var languageForm = document.getElementById("languageForm");
  var exchangeTypeForm = document.getElementById("exchangeTypeForm");
  
  var myContentCountry = document.getElementById("myContentCountry");
  var myContentField = document.getElementById("myContentField");
  var myContentLanguage = document.getElementById("myContentLanguage");
  
  if (value === 1) {
	countryForm.style.display = "block";
	fieldForm.style.display = "none";
	languageForm.style.display = "none";
	exchangeTypeForm.style.display = "none";
    
    myContentCountry.style.display = "block";
    myContentField.style.display = "none";
    myContentLanguage.style.display = "none";
  }
  if (value === 2) {
	countryForm.style.display = "none";
	fieldForm.style.display = "block";
	languageForm.style.display = "none";
	exchangeTypeForm.style.display = "none";
	  
    myContentCountry.style.display = "none";
    myContentField.style.display = "block";
    myContentLanguage.style.display = "none";
  }
  if (value === 3) {
	countryForm.style.display = "none";
	fieldForm.style.display = "none";
	languageForm.style.display = "block";
	exchangeTypeForm.style.display = "none";
	  
    myContentCountry.style.display = "none";
    myContentField.style.display = "none";
    myContentLanguage.style.display = "block";
  }
  if (value === 4) {
	countryForm.style.display = "none";
	fieldForm.style.display = "none";
	languageForm.style.display = "none";
	exchangeTypeForm.style.display = "block";
	  
    myContentCountry.style.display = "none";
    myContentField.style.display = "none";
    myContentLanguage.style.display = "none";
  }
}

function selectedStudentFilter(value) {
	var countryForm = document.getElementById("countryStudentForm");
	var yearForm = document.getElementById("yearForm");
	  
	  if (value === 1) {
		  countryForm.style.display = "block";
		  yearForm.style.display = "none";
	  }
	  if (value === 2) {
		  countryForm.style.display = "none";
		  yearForm.style.display = "block";
	  }
	}

function studentListLoading(currentTab) {


	if (currentTab == 1) {

	}
	if (currentTab == 2) {

	}
}


function shareComment(uniName) {
  var modal = document.getElementById("commentModal");
  modal.classList.toggle("show-modal");
  
  var modalUniTitle = document.getElementById("modalUniversityTitle");
  modalUniTitle.innerHTML = "Université " + uniName;
}

function closeModal() {
    var modal = document.getElementById("commentModal");
    modal.classList = "modal";
  }

window.onclick = function(event) {
  var modal = document.getElementById("commentModal");
  if (event.target == modal) {
    modal.classList = "modal";
  }
}



function changeComment() {
    document.getElementById("commentTextArea").value = "Test";
  }
