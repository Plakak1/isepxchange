function loading(currentTab) {
	var myContentField = document.getElementById("myContentCountry");
	var myContentField = document.getElementById("myContentField");
	var myContentLanguage = document.getElementById("myContentLanguage");
	
	var countryForm = document.getElementById("countryForm");
	var fieldForm = document.getElementById("fieldForm");
	var languageForm = document.getElementById("languageForm");

	if (currentTab == 1) {
		myContentCountry.style.display = "block";
		myContentField.style.display = "none";
		myContentLanguage.style.display = "none";
		
		countryForm.style.display = "block";
		fieldForm.style.display = "none";
		languageForm.style.display = "none";
	}
	if (currentTab == 2) {
		myContentCountry.style.display = "none";
		myContentField.style.display = "block";
		myContentLanguage.style.display = "none";
		
		countryForm.style.display = "none";
		fieldForm.style.display = "block";
		languageForm.style.display = "none";
	}
	if (currentTab == 3) {
		myContentCountry.style.display = "none";
		myContentField.style.display = "none";
		myContentLanguage.style.display = "block";
		
		countryForm.style.display = "none";
		fieldForm.style.display = "none";
		languageForm.style.display = "block";
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


function shareComment(uniName, uniId) {
	var modal = document.getElementById("commentModal");
	modal.classList.toggle("show-modal");

	var modalUniTitle = document.getElementById("modalUniversityTitle");
	modalUniTitle.innerHTML = "Université " + uniName;

	document.getElementById("id_uni").value = uniId;
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
