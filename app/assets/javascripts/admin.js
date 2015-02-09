$(window).load(function() {

  if (document.getElementById("prop_variety").value == "") {
        $(".has_many_add")[0].style.visibility = 'hidden'
        $(".inputs")[1].style.visibility = 'hidden'
    } else if ((document.getElementById("prop_variety").value == "PvP") | (document.getElementById("prop_variety").value == "2Pv2P")) {
        $(".has_many_add")[0].style.visibility = 'hidden'
    } else if (document.getElementById("prop_variety").value == "Over/Under") {
        $(".has_many_add")[0].style.visibility = 'hidden'
    }


    $(".has_many_add").on('click', function() {
        setTimeout(
            function() {
                var players = $(".player"), i;
                for (var i = 0; i < players.length; i ++) {
                players[i].className += ' hidden'
            }
            },
            40);
    })

    document.getElementById("new_prop").elements.namedItem("prop_variety").onchange = function () {
    $(".inputs")[1].style.visibility = 'visible'
    if (document.getElementById("new_prop").elements.namedItem("prop_variety").value == "PvP") {
        document.getElementById("over-under").className += ' hidden'
        document.getElementById("opt1-spread").className -= ' hidden'
        var choices = $("li.choice-raw"), i;
        for (var i = 0; i < choices.length; i ++) {
            choices[i].className += ' hidden'
        }
        var player2s = $("li.player2"), i;
        for (var i = 0; i < player2s.length; i ++) {
            player2s[i].className += ' hidden'
        }
        var player1s = $("li.player1"), i;
        for (var i = 0; i < player1s.length; i ++) {
            player1s[i].className -= ' hidden'
        }
        $(".has_many_add")[0].style.visibility = 'hidden'
        var removes = $(".has_many_remove"), i;
        for (var i = 0; i < removes.length; i ++) {
            removes[i].style.visibility = 'hidden';
        }
}   else if (document.getElementById("new_prop").elements.namedItem("prop_variety").value == "2Pv2P") {
        document.getElementById("over-under").className += ' hidden'
        document.getElementById("opt1-spread").className -= ' hidden'
        var choices = $("li.choice-raw"), i;
        for (var i = 0; i < choices.length; i ++) {
            choices[i].className += ' hidden'
        }
        var players = $("li.player"), i;
        for (var i = 0; i < players.length; i ++) {
            players[i].className -= ' hidden'
        }
        $(".has_many_add")[0].style.visibility = 'hidden'
        var removes = $(".has_many_remove"), i;
        for (var i = 0; i < removes.length; i ++) {
            removes[i].style.visibility = 'hidden';
        }
} else if (document.getElementById("new_prop").elements.namedItem("prop_variety").value == "Over/Under") {
        document.getElementById("opt1-spread").className += ' hidden'
        document.getElementById("over-under").className -= ' hidden'
        var players = $("li.player"), i;
        for (var i = 0; i < players.length; i ++) {
            players[i].className += ' hidden'
        }
        var choices = $("li.choice-raw"), i;
        for (var i = 0; i < choices.length; i ++) {
            choices[i].className -= ' hidden'
        }
        choices[0].value = "Over"
        choices[1].value = "Under"
        $(".has_many_add")[0].style.visibility = 'hidden'
        var removes = $(".has_many_remove"), i;
        for (var i = 0; i < removes.length; i ++) {
            removes[i].style.visibility = 'hidden';
        }
} else if (document.getElementById("new_prop").elements.namedItem("prop_variety").value == "Other") {
        document.getElementById("opt1-spread").className += ' hidden'
        document.getElementById("over-under").className += ' hidden'
        var players = $("li.player"), i;
        for (var i = 0; i < players.length; i ++) {
            players[i].className += ' hidden'
        }
        var choices = $("li.choice-raw"), i;
        choices[0].value = ""
        choices[1].value = ""
        var choices = $("li.choice-raw"), i;
        for (var i = 0; i < choices.length; i ++) {
            choices[i].className -= ' hidden'
        }
        $(".has_many_add")[0].style.visibility = 'visible'
        var removes = $(".has_many_remove"), i;
        for (var i = 0; i < removes.length; i ++) {
            removes[i].style.visibility = 'visible';
        }
}
}

});
