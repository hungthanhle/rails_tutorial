function proceed () {
  var form = document.createElement('form');
  form.setAttribute('method', 'post');
  form.setAttribute('action', '/reacts');

  // (CSRF) token
  var token = document.getElementsByName('csrf-token')[0].content
  var newField = document.createElement('input');
  newField.setAttribute('name','authenticity_token');
  newField.setAttribute('value',token);
  newField.setAttribute('autocomplete',"off");
  newField.style.display = 'hidden';
  form.appendChild(newField);
  // `<input type="hidden" name="authenticity_token" value="${token}" autocomplete="off"></input>`

  // Field
  var newField = document.createElement('input');
  newField.setAttribute('name','react[emotion]');
  newField.setAttribute('value','like');
  newField.setAttribute('autocomplete',"off");
  newField.style.display = 'hidden';
  form.appendChild(newField);
  // <input type="hidden" name="react[emotion]" value="like" autocomplete="off">
  
  form.style.display = 'hidden';
  document.body.appendChild(form)
  form.submit();
}
