var buttons = document.querySelectorAll('.btn-decrease')

buttons.forEach(button=>{
  var button_disabled = button.hasAttribute('disabled')

  if(button_disabled){
    button.style.opacity = 0.4;
    button.style.cursor = 'default';
  }
})