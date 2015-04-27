$(function() {

    $('.just-datetime-picker-time').on("keyup", function() {
        var time = $('.just-datetime-picker-time')
        var hour = $(time[0]).val()
        var minute = $(time[1]).val()
        if (hour == 00) {
             $('#prop_ampm_time').val("12:" + minute + " am")
        } else if (hour < 12) {
            $('#prop_ampm_time').val(hour + ":" + minute + " am")
        } else if (hour == 12) {
            $('#prop_ampm_time').val(hour + ":" + minute + " pm")
        } else {
            $('#prop_ampm_time').val(hour - 12 + ":" + minute + " pm")
        }
    })

    $(document).ready(function(){
        grades = $('.grade-prop'), i;
        for (var i = 0; i < grades.length; i ++) {
            if ($(grades[i]).find('.winner').text() == "Winner: ") {
                // do nothing
            } else {
                $(grades[i]).css("background-color", "lightgray")
                $(grades[i]).find('.team1').attr('class', 'regradeTeam1');
                $(grades[i]).find('.team2').attr('class', 'regradeTeam2');
                $(grades[i]).find('.push').attr('class', 'regradePush');
                $(grades[i]).find('.noAction').attr('class', 'regradeNoAction');
            }
        }
    })

    $('.team1').on("click", function() {
        var container = $(this).closest('.grade-prop');
        propID = $(container).data('propid')
        $.ajax({
            url: "/props/"+propID+"",
            dataType: "script",
            type: "PATCH",
            contentType: 'application/json',
            data: JSON.stringify({ prop:{winner:0}, _method:'patch' })
        })
        $(container).css("background-color", "lightgray");
        container.find('.winner').append("Team1");
        $(container).find('.team1').attr('class', 'regradeTeam1');
        $(container).find('.team2').attr('class', 'regradeTeam2');
        $(container).find('.push').attr('class', 'regradePush');
        $(container).find('.noAction').attr('class', 'regradeNoAction');
    })

    $('.index').on('click', '.regradeTeam1',(function() {
        var container = $(this).closest('.grade-prop');
        propID = $(container).data('propid')
        $.ajax({
            url: "/props/"+propID+"",
            dataType: "script",
            type: "PATCH",
            contentType: 'application/json',
            data: JSON.stringify({ prop:{winner:0, state:4}, _method:'patch' })
        })
        container.find('.winner').text("Winner: Team1");
    }))

    $('.team2').on("click", function() {
        var container = $(this).closest('.grade-prop');
        propID = $(container).data('propid')
        $.ajax({
            url: "/props/"+propID+"",
            dataType: "script",
            type: "PATCH",
            contentType: 'application/json',
            data: JSON.stringify({ prop:{winner:1}, _method:'patch' })
        })
        $(container).css("background-color", "lightgray");
        container.find('.winner').append("Team2");
        $(container).find('.team1').attr('class', 'regradeTeam1');
        $(container).find('.team2').attr('class', 'regradeTeam2');
        $(container).find('.push').attr('class', 'regradePush');
        $(container).find('.noAction').attr('class', 'regradeNoAction');
    })

    $('.index').on('click', '.regradeTeam2',(function() {
        var container = $(this).closest('.grade-prop');
        propID = $(container).data('propid')
        $.ajax({
            url: "/props/"+propID+"",
            dataType: "script",
            type: "PATCH",
            contentType: 'application/json',
            data: JSON.stringify({ prop:{winner:1, state:4}, _method:'patch' })
        })
        container.find('.winner').text("Winner: Team2");
    }))

    $('.push').on("click", function() {
        var container = $(this).closest('.grade-prop');
        propID = $(container).data('propid')
        $.ajax({
            url: "/props/"+propID+"",
            dataType: "script",
            type: "PATCH",
            contentType: 'application/json',
            data: JSON.stringify({ prop:{winner:2}, _method:'patch' })
        })
        $(container).css("background-color", "lightgray");
        container.find('.winner').append("Push");
        $(container).find('.team1').attr('class', 'regradeTeam1');
        $(container).find('.team2').attr('class', 'regradeTeam2');
        $(container).find('.push').attr('class', 'regradePush');
        $(container).find('.noAction').attr('class', 'regradeNoAction');
    })

    $('.index').on('click', '.regradePush',(function() {
        var container = $(this).closest('.grade-prop');
        propID = $(container).data('propid')
        $.ajax({
            url: "/props/"+propID+"",
            dataType: "script",
            type: "PATCH",
            contentType: 'application/json',
            data: JSON.stringify({ prop:{winner:2, state:4}, _method:'patch' })
        })
        container.find('.winner').text("Winner: Push");
    }))

    $('.noAction').on("click", function() {
        var container = $(this).closest('.grade-prop');
        propID = $(container).data('propid')
        $.ajax({
            url: "/props/"+propID+"",
            dataType: "script",
            type: "PATCH",
            contentType: 'application/json',
            data: JSON.stringify({ prop:{winner:3}, _method:'patch' })
        })
        $(container).css("background-color", "lightgray");
        container.find('.winner').append("NoAction");
        $(container).find('.team1').attr('class', 'regradeTeam1');
        $(container).find('.team2').attr('class', 'regradeTeam2');
        $(container).find('.push').attr('class', 'regradePush');
        $(container).find('.noAction').attr('class', 'regradeNoAction');
    })

    $('.index').on('click', '.regradeNoAction',(function() {
        var container = $(this).closest('.grade-prop');
        propID = $(container).data('propid')
        $.ajax({
            url: "/props/"+propID+"",
            dataType: "script",
            type: "PATCH",
            contentType: 'application/json',
            data: JSON.stringify({ prop:{winner:3, state:4}, _method:'patch' })
        })
        container.find('.winner').text("Winner: NoAction");
    }))

    $('#wager_prop_id').change(function() {
        var prop = document.getElementById('wager_prop_id')
        $.ajax({
        url: "/prop",
        type: "GET",
        data: {prop_id: prop.options[prop.selectedIndex].value},
        success: function (data) {
            handlePropData(data);
        },
        error: function (xhr, status, error) {
            console.log(status + error);
        }
      });
    })

    function handlePropData (responseData) {
        console.log(responseData);
        pc1 = responseData.prop_choices[0].id
        pc2 = responseData.prop_choices[1].id
        $('input#wager_prop_choice_id_team_1').val(pc1)
        $('input#wager_prop_choice_id_team_2').val(pc2)
    }

    $('.choice').change(function() {
        pc = $('input[name="wager[prop_choice_id]"]:checked').val()
        $.ajax({
        url: "/pc",
        type: "GET",
        data: {prop_choice_id: pc},
        success: function (data) {
            handlePropChoiceData(data);
        },
        error: function (xhr, status, error) {
            console.log(status + error);
        }
      });
    })

    function handlePropChoiceData (responseData) {
        console.log(responseData);
        odds = responseData.odds
        opt1_spread = responseData.prop.opt1_spread
        opt2_spread = responseData.prop.opt2_spread
        $('input#wager_odds').val(odds)
        if (document.getElementById('wager_prop_choice_id_team_1').checked) {
            $('input#wager_spread').val(opt1_spread)
        } else {
            $('input#wager_spread').val(opt2_spread)
        }
    }

    $('.has_many_remove').hide()

    $('#wrapper').on('change', '.player1', (function() {
        var container = $(this).closest('fieldset');
        container.find('.player2').removeClass('hidden');
        if ($("option:selected", this).text() == "Create a new player") {
            container.find('.player1new').removeClass('hidden');
        }
    }))

    $('#wrapper').on('change', '.player2', (function() {
        var container = $(this).closest('fieldset');
        container.find('.player3').removeClass('hidden');
        if ($("option:selected", this).text() == "Create a new player") {
            container.find('.player2new').removeClass('hidden');
        }
    }))

    $('#wrapper').on('change', '.player3', (function() {
        var container = $(this).closest('fieldset');
        container.find('.player4').removeClass('hidden');
        if ($("option:selected", this).text() == "Create a new player") {
            container.find('.player3new').removeClass('hidden');
        }
    }))

    $('#wrapper').on('change', '.player4', (function() {
        var container = $(this).closest('fieldset');
        container.find('.player5').removeClass('hidden');
        if ($("option:selected", this).text() == "Create a new player") {
            container.find('.player4new').removeClass('hidden');
        }
    }))

    $('#wrapper').on('change', '.player5', (function() {
        var container = $(this).closest('fieldset');
        if ($("option:selected", this).text() == "Create a new player") {
            container.find('.player5new').removeClass('hidden');
        }
    }))

    player2s = $('.player2e')
    player3s = $('.player3e')
    player4s = $('.player4e')
    player5s = $('.player5e')

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


