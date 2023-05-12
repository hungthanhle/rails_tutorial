function addValueForm (formID, emotion) {
  $(`#${formID} .emoji-value`).val(emotion);
  document.querySelector(`#${formID}`).requestSubmit();
}
