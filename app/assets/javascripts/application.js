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

  $("#q").on("keyup", function() {
    $(this).parent("form").submit();
  })

  $('.prop-table').on('click', '.wager-btn',(function() {
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
  }));

  function handleData (responseData) {
    console.log(responseData);
    state = responseData.prop.state;
    displayLine = responseData.display_line;
    propId = responseData.prop.id;
    propChoiceId = responseData.id;
    name = responseData.name
    odds = responseData.odds;
    total = responseData.prop.over_under;
    if ($(prop_choice)[0].classList.contains('odd')) {
      spread = responseData.prop.opt1_spread;
    } else {
      spread = responseData.prop.opt2_spread;
    }
    container = $(prop_choice).closest('tr');
    pageLine = container.find('.wager-btn');
    if ($(prop_choice)[0].classList.contains('green')) {
      if (state == "Open") {
          if (displayLine == $(pageLine).text()) {
            // do nothing
        } else {
            alert("line changed");
        }
          var row = $('tbody.new-wager-row').clone().removeClass('hidden new-wager-row');
          row.find('.wager-info').text(name + " " + displayLine);
          row.find('.wager-prop-id').val(propId);
          row.find('.wager-prop-choice-id').val(propChoiceId);
          row.find('.wager-odds').val(odds);
          row.find('.wager-spread').val(spread);
          row.find('.wager-total').val(total);
          $('tbody.actions').before(row);
          $('tbody.actions').removeClass("hidden");
      } else {
          alert("This event is not available for betting.");
      }
    } else {
        var wagerList = $('.wager-prop-choice-id'), i;
        for (var i = 0; i < wagerList.length; i ++) {
          if (propChoiceId == $(wagerList[i]).val()) {
            $(wagerList[i]).closest('tbody').remove();
          }
        }
        if (wagerList.length == 2) {
          $('tbody.actions').addClass("hidden");
        }
    }
  }

  $('.ticket').on('click', '.delete-wager',(function(){
    var container = $(this).closest('tbody');
    var choice = container.find('.wager-prop-choice-id');
    var choiceId = $(choice).val()
    container.remove();
    var wagerList = $('.wager-prop-choice-id')
    if (wagerList.length == 1) {
      $('tr.actions').addClass("hidden");
    }
    var propChoices = $('.wager-btn'), i;
    for (var i = 0; i < propChoices.length; i ++) {
      if (choiceId == $(propChoices[i]).data('propchoiceid')) {
        $(propChoices[i]).toggleClass("green");
      }
    }
  }))

  $('.ticket').on('keyup', '.wager-risk',(function() {
    container = $(this).closest('tbody');
    win = container.find('.wager-win');
    odds = parseInt(container.find('.wager-odds').val());
    risk = parseFloat($(this).val());
    $(win).val(calculateWin(risk, odds));
  }))

  $('.ticket').on('keyup', '.wager-win',(function() {
    container = $(this).closest('tbody');
    risk = container.find('.wager-risk');
    odds = parseInt(container.find('.wager-odds').val());
    win = parseFloat($(this).val());
    $(risk).val(calculateRisk(win, odds));
  }))

  function calculateWin (risk, odds) {
      if (odds > 0) {
          return (risk * odds / 100.0).toFixed(2)
      } else {
          return (risk * -100.0 / odds).toFixed(2)
      }
  }

  function calculateRisk (win, odds) {
      if (odds > 0) {
          return (win / odds * 100.0).toFixed(2)
      } else {
          return (win * odds / -100.0).toFixed(2)
      }
  }

  $('#datetimepicker').datetimepicker({
    format: "L"
    });
  $('#datetimepicker2').datetimepicker({
    format: "L"
    });

});


