function loading(currentTab) {
  var myContentCountry = document.getElementById('myContentCountry');
  var myContentField = document.getElementById('myContentField');
  var myContentLanguage = document.getElementById('myContentLanguage');

  var countryForm = document.getElementById('countryForm');
  var fieldForm = document.getElementById('fieldForm');
  var languageForm = document.getElementById('languageForm');

  if (currentTab == 1) {
    myContentCountry.style.display = 'block';
    myContentField.style.display = 'none';
    myContentLanguage.style.display = 'none';

    countryForm.style.display = 'block';
    fieldForm.style.display = 'none';
    languageForm.style.display = 'none';
  }
  if (currentTab == 2) {
    myContentCountry.style.display = 'none';
    myContentField.style.display = 'block';
    myContentLanguage.style.display = 'none';

    countryForm.style.display = 'none';
    fieldForm.style.display = 'block';
    languageForm.style.display = 'none';
  }
  if (currentTab == 3) {
    myContentCountry.style.display = 'none';
    myContentField.style.display = 'none';
    myContentLanguage.style.display = 'block';

    countryForm.style.display = 'none';
    fieldForm.style.display = 'none';
    languageForm.style.display = 'block';
  }
}

function loadingNotifications(currentTab) {
  var myCommentTab = document.getElementById('submittedCommentTab');
  var myReportTab = document.getElementById('reportTab');

  if (currentTab == 1) {
    myCommentTab.style.display = 'block';
    myReportTab.style.display = 'none';
  }
  if (currentTab == 2) {
    myCommentTab.style.display = 'none';
    myReportTab.style.display = 'block';
  }
}

function selectedStudentFilter(value) {
  var countryForm = document.getElementById('countryStudentForm');
  var yearForm = document.getElementById('yearForm');

  if (value === 1) {
    countryForm.style.display = 'block';
    yearForm.style.display = 'none';
  }
  if (value === 2) {
    countryForm.style.display = 'none';
    yearForm.style.display = 'block';
  }
}

function studentListLoading(currentTab) {
  if (currentTab == 1) {
  }
  if (currentTab == 2) {
  }
}

function shareComment(uniName, uniId) {
  var modal = document.getElementById('commentModal');
  modal.classList.toggle('show-modal');

  var modalUniTitle = document.getElementById('modalUniversityTitle');
  modalUniTitle.innerHTML = uniName;

  document.getElementById('id_uni').value = uniId;
}

function updateUniversityInfo(uniName, uniId, uniCountry, uniCity, uniUrl, uniQuota, uniDescription) {
  var adminModal = document.getElementById('adminUpdateUniversityModal');
  adminModal.classList.toggle('show-modal');

  var modalUniTitle = document.getElementById('modalUniversityTitle');
  modalUniTitle.innerHTML = uniName;

  var modalUniTitle = document.getElementById('adminUniName');
  modalUniTitle.innerHTML = uniName;

  var modalUniTitle = document.getElementById('adminUniCountry');
  modalUniTitle.innerHTML = uniCountry;

  var modalUniTitle = document.getElementById('adminUniCity');
  modalUniTitle.innerHTML = uniCity;

  var modalUniTitle = document.getElementById('adminUniInfo');
  modalUniTitle.innerHTML = uniDescription;

  document.getElementById('adminUniUrl').value = uniUrl;
  document.getElementById('adminUniQuota').value = uniQuota;
  document.getElementById('id_uni').value = uniId;
}

function login() {
  var loginModal = document.getElementById('loginModal');
  loginModal.classList.toggle('show-modal');
}

function closeModal() {
  var modal = document.getElementById('commentModal');
  modal.classList = 'modal';
}

function closeAdminModal() {
  var adminModal = document.getElementById('adminUpdateUniversityModal');
  adminModal.classList = 'modal';
}

function closeLoginModal() {
  var loginModal = document.getElementById('loginModal');
  loginModal.classList = 'modal';
}

function sendWarning(uniName, uniId) {
  var modal = document.getElementById('warningModal');
  modal.classList.toggle('show-modal');

  var modalUniTitle = document.getElementById('warningUniversityTitle');
  warningUniversityTitle.innerHTML = uniName;

  document.getElementById('id_uni_alert').value = uniId;
}

function closeWarning() {
  var modal = document.getElementById('warningModal');
  modal.classList = 'modal';
}

window.onclick = function(event) {
  var modal = document.getElementById('commentModal');
  var adminModal = document.getElementById('adminUpdateUniversityModal');
  var loginModal = document.getElementById('loginModal');
  if (event.target == modal) {
    modal.classList = 'modal';
  }
  if (event.target == adminModal) {
    adminModal.classList = 'modal';
  }
  if (event.target == loginModal) {
    loginModal.classList = 'modal';
  }
};

function changeComment() {
  document.getElementById('commentTextArea').value = 'Test';
}
