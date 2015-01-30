$(document).ready(function() {

  document.getElementById("new_prop").elements.namedItem("prop_variety").onchange = function () {
  if (document.getElementById("new_prop").elements.namedItem("prop_variety").value == "PvP") {
    document.getElementById("prop_prop_choices_attributes_0_choice_raw_input").remove()
    document.getElementById("prop_prop_choices_attributes_1_choice_raw_input").remove()
    document.getElementById("prop_prop_choices_attributes_0_player2_input").remove()
    document.getElementById("prop_prop_choices_attributes_1_player2_input").remove()
    document.getElementById("prop_over_under_input").remove()
    $('.has_many_add').remove()
} else if (document.getElementById("new_prop").elements.namedItem("prop_variety").value == "2Pv2P") {
    document.getElementById("prop_prop_choices_attributes_0_choice_raw_input").remove()
    document.getElementById("prop_prop_choices_attributes_1_choice_raw_input").remove()
    document.getElementById("prop_over_under_input").remove()
    $('.has_many_add').remove()
} else if (document.getElementById("new_prop").elements.namedItem("prop_variety").value == "Over/Under") {
    document.getElementById("prop_prop_choices_attributes_0_player1_input").remove()
    document.getElementById("prop_prop_choices_attributes_1_player1_input").remove()
    document.getElementById("prop_prop_choices_attributes_0_player2_input").remove()
    document.getElementById("prop_prop_choices_attributes_1_player2_input").remove()
    document.getElementById("prop_opt1_spread_input").remove()
    $('.has_many_add').remove()
    document.getElementById("prop_prop_choices_attributes_0_choice_raw").value = "Over"
    document.getElementById("prop_prop_choices_attributes_1_choice_raw").value = "Under"
} else if (document.getElementById("new_prop").elements.namedItem("prop_variety").value == "Other") {
    document.getElementById("prop_prop_choices_attributes_0_player1_input").remove()
    document.getElementById("prop_prop_choices_attributes_1_player1_input").remove()
    document.getElementById("prop_prop_choices_attributes_0_player2_input").remove()
    document.getElementById("prop_prop_choices_attributes_1_player2_input").remove()
    document.getElementById("prop_opt1_spread_input").remove()
}
}

});
