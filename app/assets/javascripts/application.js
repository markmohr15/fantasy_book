// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require moment
//= require bootstrap-sprockets
//= require bootstrap-datetimepicker
//= require_tree .

$(function(){

  $('.seeMore').on('click', function(e) {
    e.preventDefault();
    var container = $(this).closest('tr');
    var moreContent = container.find('.moreContent');
    var seeMore = container.find('.seeMore');

    if (moreContent.is(':hidden')) {
      moreContent.removeClass('hidden');
      seeMore.text("-");
    } else {
      moreContent.addClass('hidden');
      seeMore.text("+");
    }
  });

  $('.wager-btn').on('click', function(e) {
    e.preventDefault();
    $(this).toggleClass("green");
    prop_choice = $(this);
    $.ajax({
      url: "/pc",
      type: "GET",
      data: {prop_choice_id: $(this).data('propchoiceid')},
      success: function (data) {
          handleData(data);
      },
      error: function (xhr, status, error) {
        console.log(status + error);
      }
    });
  });

  function handleData (responseData) {
    console.log(responseData);
    state = responseData.prop.state;
    display_line = responseData.display_line;
    container = $(prop_choice).closest('tr');
    page_line = container.find('.prop-name');
    if ($(prop_choice)[0].classList.contains('green')) {
      if (state == "Open") {
        if (display_line == $(page_line).text()) {
            var row = $('tr.new-wager-row').clone().removeClass('hidden new-wager-row');
            $('tr.actions').before(row);
        } else {
            alert("line changed")
        }
    } else {
          alert("This event is not available for betting.");
      }
    }
  }


  $('#datetimepicker').datetimepicker({
    format: "L"
    });
  $('#datetimepicker2').datetimepicker({
    format: "L"
    });

});


