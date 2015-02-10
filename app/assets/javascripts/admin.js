$(window).load(function() {

    if ($('input[name="prop[variety]"]:checked').length < 1) {
        $(".inputs")[1].style.visibility = 'hidden'
    }

    $(".has_many_add").on('click', function() {
        setTimeout(
            function() {
                var players = $(".player"), i;
                for (var i = 0; i < players.length; i ++) {
                    $(players[i]).addClass("hidden")
                }
                var choices = $("li.choice-raw"), i;
                for (var i = 0; i < choices.length; i ++) {
                    $(choices[i]).removeClass("hidden")
        }
            },
            40);
    })

    $('#wrapper').on('click', '#prop_variety_fantasy',(function(){
        $(".inputs")[1].style.visibility = 'visible'
        document.getElementById("over-under").className += ' hidden'
        document.getElementById("opt1-spread").className -= ' hidden'
        $(".has_many_add")[0].style.visibility = 'hidden'
        var choices = $("li.choice-raw"), i;
        for (var i = 0; i < choices.length; i ++) {
            $(choices[i]).addClass("hidden")
        }
        var inputs = $('.has_many_fields')
        for (var i = 2; i < inputs.length; i ++) {
            $(inputs[i]).addClass("hidden")
        }
        var player2s = $("li.player2"), i;
        for (var i = 0; i < player2s.length; i ++) {
            $(player2s[i]).addClass("hidden")
        }
        var player1s = $("li.player1"), i;
        for (var i = 0; i < player1s.length; i ++) {
            $(player1s[i]).removeClass("hidden")
        }
        $(".has_many_add")[0].style.visibility = 'hidden'
        var removes = $(".has_many_remove"), i;
        for (var i = 0; i < removes.length; i ++) {
            removes[i].style.visibility = 'hidden';
        }
}))
    $('#wrapper').on('click', '#prop_variety_2p_fantasy',(function(){
        $(".inputs")[1].style.visibility = 'visible'
        document.getElementById("over-under").className += ' hidden'
        document.getElementById("opt1-spread").className -= ' hidden'
        $(".has_many_add")[0].style.visibility = 'hidden'
        var choices = $("li.choice-raw"), i;
        for (var i = 0; i < choices.length; i ++) {
            $(choices[i]).addClass("hidden")
        }
        var inputs = $('.has_many_fields')
        for (var i = 2; i < inputs.length; i ++) {
            $(inputs[i]).addClass("hidden")
        }
        var players = $("li.player"), i;
        for (var i = 0; i < players.length; i ++) {
            $(players[i]).removeClass("hidden")
        }
        $(".has_many_add")[0].style.visibility = 'hidden'
        var removes = $(".has_many_remove"), i;
        for (var i = 0; i < removes.length; i ++) {
            removes[i].style.visibility = 'hidden';
        }
}))
    $('#wrapper').on('click', '#prop_variety_overunder',(function(){
        $(".inputs")[1].style.visibility = 'visible'
        document.getElementById("opt1-spread").className += ' hidden'
        document.getElementById("over-under").className -= ' hidden'
        $(".has_many_add")[0].style.visibility = 'hidden'
        var players = $("li.player"), i;
        for (var i = 0; i < players.length; i ++) {
            $(players[i]).addClass("hidden")
        }
        var choices = $("li.choice-raw"), i;
        for (var i = 0; i < choices.length; i ++) {
            $(choices[i]).removeClass("hidden")
        }
        var inputs = $('.has_many_fields')
        for (var i = 2; i < inputs.length; i ++) {
            $(inputs[i]).addClass("hidden")
        }
        var totals = $('.prop_choices').find('.choice')
        totals[0].value = "Over"
        totals[1].value = "Under"
        $(".has_many_add")[0].style.visibility = 'hidden'
        var removes = $(".has_many_remove"), i;
        for (var i = 0; i < removes.length; i ++) {
            removes[i].style.visibility = 'hidden';
        }
}))
    $('#wrapper').on('click', '#prop_variety_other',(function(){
        $(".inputs")[1].style.visibility = 'visible'
        document.getElementById("opt1-spread").className += ' hidden'
        document.getElementById("over-under").className += ' hidden'
        var players = $("li.player"), i;
        for (var i = 0; i < players.length; i ++) {
            $(players[i]).addClass("hidden")
        }
        var choices = $("li.choice-raw"), i;
        var totals = $('.prop_choices').find('.choice')
        totals[0].value = ""
        totals[1].value = ""
        var choices = $("li.choice-raw"), i;
        for (var i = 0; i < choices.length; i ++) {
            $(choices[i]).removeClass("hidden")
        }
        $(".has_many_add")[0].style.visibility = 'visible'
        var removes = $(".has_many_remove"), i;
        for (var i = 0; i < removes.length; i ++) {
            removes[i].style.visibility = 'visible';
        }
}))

});
