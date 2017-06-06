$(document).on('turbolinks:load', function(){
  $('#filters input').on('change', function(){
    $('form').submit()
  })

  $('#filters .filter-menu').on('click', function(e, el){
    icon = $(this).find('use')
    if(icon.hasClass('inactive') || icon.hasClass("no-filter")) {
      $('#sdg-select').val($(this).data("number"))
      $('form').submit()
    }
    else {
      $('#sdg-select').val("")
      $('form').submit()
    }
  })

  $('#more-results').on('click', function(e, el){
    $('#page').val(parseInt($('#page').val()) + 1)
    $('form').submit()
  })

  $('#previous').on('click', function(e, el){
    $('#page').val(parseInt($('#page').val()) - 1)
    $('form').submit()
  })

})
