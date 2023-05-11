function createReact (emotion, micropost_id) {
  var form = document.createElement('form');
  form.setAttribute('method', 'post');
  form.setAttribute('action', '/reacts');

  // (CSRF) token
  CSRFToken(form)

  // Field
  var newField = document.createElement('input');
  newField.setAttribute('name','react[emotion]');
  newField.setAttribute('value', emotion);
  newField.setAttribute('autocomplete',"off");
  newField.style.display = 'hidden';
  form.appendChild(newField);

  // Field
  var newField = document.createElement('input');
  newField.setAttribute('name','react[micropost_id]');
  newField.setAttribute('value', micropost_id);
  newField.setAttribute('autocomplete',"off");
  newField.style.display = 'hidden';
  form.appendChild(newField);
  
  form.style.display = 'hidden';
  document.body.appendChild(form)
  form.submit();
}

function updateReact (emotion, micropost_id, react_id) {
  var form = document.createElement('form');
  form.setAttribute('method', 'post');
  form.setAttribute('action', `/reacts/${react_id}`);

  // (CSRF) token
  CSRFToken(form)

  // Field
  var newField = document.createElement('input');
  newField.setAttribute('name','_method');
  newField.setAttribute('value', "patch");
  newField.setAttribute('autocomplete',"off");
  newField.style.display = 'hidden';
  form.appendChild(newField);

  // Field
  var newField = document.createElement('input');
  newField.setAttribute('name','react[emotion]');
  newField.setAttribute('value', emotion);
  newField.setAttribute('autocomplete',"off");
  newField.style.display = 'hidden';
  form.appendChild(newField);

  // Field
  var newField = document.createElement('input');
  newField.setAttribute('name','react[micropost_id]');
  newField.setAttribute('value', micropost_id);
  newField.setAttribute('autocomplete',"off");
  newField.style.display = 'hidden';
  form.appendChild(newField);
  
  form.style.display = 'hidden';
  document.body.appendChild(form)
  form.submit();
}

function destroyReact (emotion, micropost_id, react_id) {
  var form = document.createElement('form');
  form.setAttribute('method', 'post');
  form.setAttribute('action', `/reacts/${react_id}`);

  // (CSRF) token
  CSRFToken(form)

  // Field
  var newField = document.createElement('input');
  newField.setAttribute('name','_method');
  newField.setAttribute('value', "delete");
  newField.setAttribute('autocomplete',"off");
  newField.style.display = 'hidden';
  form.appendChild(newField);

  // Field
  var newField = document.createElement('input');
  newField.setAttribute('name','react[emotion]');
  newField.setAttribute('value', emotion);
  newField.setAttribute('autocomplete',"off");
  newField.style.display = 'hidden';
  form.appendChild(newField);

  // Field
  var newField = document.createElement('input');
  newField.setAttribute('name','react[micropost_id]');
  newField.setAttribute('value', micropost_id);
  newField.setAttribute('autocomplete',"off");
  newField.style.display = 'hidden';
  form.appendChild(newField);
  
  form.style.display = 'hidden';
  document.body.appendChild(form)
  form.submit();
}

function CSRFToken(form){
  var token = document.getElementsByName('csrf-token')[0].content
  var newField = document.createElement('input');
  newField.setAttribute('name','authenticity_token');
  newField.setAttribute('value',token);
  newField.setAttribute('autocomplete',"off");
  newField.style.display = 'hidden';
  form.appendChild(newField);
}
