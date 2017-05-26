function resize_menu(margin, spacing, selector, containerProportion) {
  if(!containerProportion) containerProportion = 1;
  var w = window.innerWidth * containerProportion - margin
  var side = w / 17 - spacing

  $(selector).each(function(i,el){
    el.style.width = String(side) + "px"
    el.style.height = String(side) + "px"
  })
}

$(document).on('turbolinks:load', function() {

  if($('.c-sustainable_development_goals').length > 0) {
    // Between 1 and 2px spacing randomly decided by broswer
    resize_menu(0, 2, 'a.menu-link svg')
    window.onresize = function() {
      resize_menu(0, 2, 'a.menu-link svg')
    }
  }

  if($('#filters').length > 0) {
    resize_menu(40, 7, 'a.filter-menu svg', 0.9)
    window.onresize = function() {
      resize_menu(40, 7, 'a.filter-menu svg', 0.9)
    }
  }

})
