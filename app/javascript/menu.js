document.getElementById('btn-menu').addEventListener('click', function(e) {
  const nav = document.querySelector('#menu-mobile');
  var nav_height = nav.clientHeight || nav.offsetHeight;
  nav.style.display = nav_height ? "none" : "block";
})
