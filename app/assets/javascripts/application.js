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
//= require bootstrap-sprockets
//= require jquery_ujs
//= require turbolinks
//= require_tree .

$(function(){

  $('.seeMore').on('click', function(e) {
    e.preventDefault();
    var container = $(this).closest('.wager');
    var moreContent = container.find('.moreContent');
    var seeMore = container.find('.seeMore');

    if (moreContent.is(':hidden')) {
      moreContent.slideDown();
      seeMore.text("-");
    } else {
      moreContent.slideUp();
      seeMore.text("+");
    }
  });

});

