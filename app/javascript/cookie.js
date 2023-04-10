const btn = document.querySelector('#google_oauth2');
btn.onclick = () => {
  const checked = document.querySelector('#checked_google_oauth2').checked ? '1' : '0'
  document.cookie = `remember_me=${checked}`;
};
