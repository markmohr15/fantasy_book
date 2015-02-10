$(window).load(function() {

  if (document.getElementById("prop_variety").value == "") {
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

    document.getElementById("new_prop").elements.namedItem("prop_variety").onchange = function () {
    $(".inputs")[1].style.visibility = 'visible'
    if (document.getElementById("new_prop").elements.namedItem("prop_variety").value == "PvP") {
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
}   else if (document.getElementById("new_prop").elements.namedItem("prop_variety").value == "2Pv2P") {
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
} else if (document.getElementById("new_prop").elements.namedItem("prop_variety").value == "Over/Under") {
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
        document.getElementById("prop_prop_choices_attributes_0_choice_raw").value = "Over"
        document.getElementById("prop_prop_choices_attributes_1_choice_raw").value = "Under"
        $(".has_many_add")[0].style.visibility = 'hidden'
        var removes = $(".has_many_remove"), i;
        for (var i = 0; i < removes.length; i ++) {
            removes[i].style.visibility = 'hidden';
        }
} else if (document.getElementById("new_prop").elements.namedItem("prop_variety").value == "Other") {
        $(".inputs")[1].style.visibility = 'visible'
        document.getElementById("opt1-spread").className += ' hidden'
        document.getElementById("over-under").className += ' hidden'
        var players = $("li.player"), i;
        for (var i = 0; i < players.length; i ++) {
            $(players[i]).addClass("hidden")
        }
        var choices = $("li.choice-raw"), i;
        document.getElementById("prop_prop_choices_attributes_0_choice_raw").value = ""
        document.getElementById("prop_prop_choices_attributes_1_choice_raw").value = ""
        var choices = $("li.choice-raw"), i;
        for (var i = 0; i < choices.length; i ++) {
            $(choices[i]).removeClass("hidden")
        }
        $(".has_many_add")[0].style.visibility = 'visible'
        var removes = $(".has_many_remove"), i;
        for (var i = 0; i < removes.length; i ++) {
            removes[i].style.visibility = 'visible';
        }
}
}

});
