$(window).load(function() {

    if (document.getElementById("prop_variety").value == "") {
        document.getElementById("prop_over_under_input").className += ' hidden'
        document.getElementById("prop_opt1_spread_input").className += ' hidden'
        $(".has_many_add")[0].style.visibility = 'hidden'
        $(".inputs")[1].style.visibility = 'hidden'
    } else if ((document.getElementById("prop_variety").value == "PvP") | (document.getElementById("prop_variety").value == "2Pv2P")) {
        document.getElementById("prop_over_under_input").className += ' hidden'
        $(".has_many_add")[0].style.visibility = 'hidden'
    } else if (document.getElementById("prop_variety").value == "Over/Under") {
        document.getElementById("prop_opt1_spread_input").className += ' hidden'
        $(".has_many_add")[0].style.visibility = 'hidden'
    } else if (document.getElementById("prop_variety").value == "Other") {
        document.getElementById("prop_opt1_spread_input").className += ' hidden'
        document.getElementById("prop_over_under_input").className += ' hidden'
    }


    $(".has_many_add").on('click', function() {
        setTimeout(
            function() {
                document.getElementById("prop_prop_choices_attributes_2_player1_input").className += ' hidden'
                document.getElementById("prop_prop_choices_attributes_3_player1_input").className += ' hidden'
                document.getElementById("prop_prop_choices_attributes_2_player2_input").className += ' hidden'
                document.getElementById("prop_prop_choices_attributes_3_player2_input").className += ' hidden'
                document.getElementById("prop_prop_choices_attributes_4_player1_input").className += ' hidden'
                document.getElementById("prop_prop_choices_attributes_5_player1_input").className += ' hidden'
                document.getElementById("prop_prop_choices_attributes_4_player2_input").className += ' hidden'
                document.getElementById("prop_prop_choices_attributes_5_player2_input").className += ' hidden'
                document.getElementById("prop_prop_choices_attributes_6_player1_input").className += ' hidden'
                document.getElementById("prop_prop_choices_attributes_7_player1_input").className += ' hidden'
                document.getElementById("prop_prop_choices_attributes_6_player2_input").className += ' hidden'
                document.getElementById("prop_prop_choices_attributes_7_player2_input").className += ' hidden'
            },
            25);
    })

    document.getElementById("new_prop").elements.namedItem("prop_variety").onchange = function () {
    $(".inputs")[1].style.visibility = 'visible'
    if (document.getElementById("new_prop").elements.namedItem("prop_variety").value == "PvP") {
        document.getElementById("prop_prop_choices_attributes_0_choice_raw_input").className += ' hidden'
        document.getElementById("prop_prop_choices_attributes_1_choice_raw_input").className += ' hidden'
        document.getElementById("prop_prop_choices_attributes_0_player2_input").className += ' hidden'
        document.getElementById("prop_prop_choices_attributes_1_player2_input").className += ' hidden'
        document.getElementById("prop_over_under_input").className += ' hidden'
        document.getElementById("prop_prop_choices_attributes_0_player1_input").className -= ' hidden'
        document.getElementById("prop_prop_choices_attributes_1_player1_input").className -= ' hidden'
        document.getElementById("prop_opt1_spread_input").className -= ' hidden'
        $(".has_many_add")[0].style.visibility = 'hidden'
        var removes = $(".has_many_remove"), i;
        for (var i = 0; i < removes.length; i ++) {
            removes[i].style.visibility = 'hidden';
        }
}   else if (document.getElementById("new_prop").elements.namedItem("prop_variety").value == "2Pv2P") {
        document.getElementById("prop_prop_choices_attributes_0_choice_raw_input").className += ' hidden'
        document.getElementById("prop_prop_choices_attributes_1_choice_raw_input").className += ' hidden'
        document.getElementById("prop_over_under_input").className += ' hidden'
        document.getElementById("prop_prop_choices_attributes_0_player1_input").className -= ' hidden'
        document.getElementById("prop_prop_choices_attributes_1_player1_input").className -= ' hidden'
        document.getElementById("prop_prop_choices_attributes_0_player2_input").className -= ' hidden'
        document.getElementById("prop_prop_choices_attributes_1_player2_input").className -= ' hidden'
        document.getElementById("prop_opt1_spread_input").className -= ' hidden'
        $(".has_many_add")[0].style.visibility = 'hidden'
        var removes = $(".has_many_remove"), i;
        for (var i = 0; i < removes.length; i ++) {
            removes[i].style.visibility = 'hidden';
        }
} else if (document.getElementById("new_prop").elements.namedItem("prop_variety").value == "Over/Under") {
        document.getElementById("prop_prop_choices_attributes_0_player1_input").className += ' hidden'
        document.getElementById("prop_prop_choices_attributes_1_player1_input").className += ' hidden'
        document.getElementById("prop_prop_choices_attributes_0_player2_input").className += ' hidden'
        document.getElementById("prop_prop_choices_attributes_1_player2_input").className += ' hidden'
        document.getElementById("prop_opt1_spread_input").className += ' hidden'
        document.getElementById("prop_prop_choices_attributes_0_choice_raw_input").className -= ' hidden'
        document.getElementById("prop_prop_choices_attributes_1_choice_raw_input").className -= ' hidden'
        document.getElementById("prop_over_under_input").className -= ' hidden'
        document.getElementById("prop_prop_choices_attributes_0_choice_raw").value = "Over"
        document.getElementById("prop_prop_choices_attributes_1_choice_raw").value = "Under"
        $(".has_many_add")[0].style.visibility = 'hidden'
        var removes = $(".has_many_remove"), i;
        for (var i = 0; i < removes.length; i ++) {
            removes[i].style.visibility = 'hidden';
        }
} else if (document.getElementById("new_prop").elements.namedItem("prop_variety").value == "Other") {
        document.getElementById("prop_prop_choices_attributes_0_player1_input").className += ' hidden'
        document.getElementById("prop_prop_choices_attributes_1_player1_input").className += ' hidden'
        document.getElementById("prop_prop_choices_attributes_0_player2_input").className += ' hidden'
        document.getElementById("prop_prop_choices_attributes_1_player2_input").className += ' hidden'
        document.getElementById("prop_opt1_spread_input").className += ' hidden'
        document.getElementById("prop_over_under_input").className += ' hidden'
        document.getElementById("prop_prop_choices_attributes_0_choice_raw").value = ""
        document.getElementById("prop_prop_choices_attributes_1_choice_raw").value = ""
        document.getElementById("prop_prop_choices_attributes_0_choice_raw_input").className -= ' hidden'
        document.getElementById("prop_prop_choices_attributes_1_choice_raw_input").className -= ' hidden'
        $(".has_many_add")[0].style.visibility = 'visible'
        var removes = $(".has_many_remove"), i;
        for (var i = 0; i < removes.length; i ++) {
            removes[i].style.visibility = 'visible';
        }
}
}

});
