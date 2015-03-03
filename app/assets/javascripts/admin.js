$(window).load(function() {

    $('#wrapper').on('change', '.player1', (function() {
        var container = $(this).closest('fieldset');
        container.find('.player2').removeClass('hidden');
    }))

    $('#wrapper').on('change', '.player2', (function() {
        var container = $(this).closest('fieldset');
        container.find('.player3').removeClass('hidden');
    }))

    $('#wrapper').on('change', '.player3', (function() {
        var container = $(this).closest('fieldset');
        container.find('.player4').removeClass('hidden');
    }))

    $('#wrapper').on('change', '.player4', (function() {
        var container = $(this).closest('fieldset');
        container.find('.player5').removeClass('hidden');
    }))

    player2s = $('.player2')
    player3s = $('.player3')
    player4s = $('.player4')
    player5s = $('.player5')

    for (var i = 0; i < player2s.length; i ++) {
    if ($(player2s[i]).find('input:checked, input[type=text]').val() != "") {
            $(player2s[i]).removeClass('hidden')
        }
    }

    for (var i = 0; i < player3s.length; i ++) {
    if ($(player3s[i]).find('input:checked, input[type=text]').val() != "") {
            $(player3s[i]).removeClass('hidden')
        }
    }

    for (var i = 0; i < player4s.length; i ++) {
    if ($(player4s[i]).find('input:checked, input[type=text]').val() != "") {
            $(player4s[i]).removeClass('hidden')
        }
    }

    for (var i = 0; i < player5s.length; i ++) {
    if ($(player5s[i]).find('input:checked, input[type=text]').val() != "") {
            $(player5s[i]).removeClass('hidden')
        }
    }


});


