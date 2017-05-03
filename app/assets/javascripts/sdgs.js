function resize_menu() {
  console.log('HERE')
  w = window.innerWidth
  // Between 1 and 2px spacing randomly decided by broswer
  side = w / 17 - 2

  $('a.menu-link svg').each(function(i,el){
    // debugger;
    el.style.width = String(side) + "px"
    el.style.height = String(side) + "px"
  })
}

$(document).on('turbolinks:load', function() {

  if($('.c-sustainable_development_goals').length > 0) {
    resize_menu()
  }
  window.onresize = resize_menu
})
