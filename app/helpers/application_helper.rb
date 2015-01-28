module ApplicationHelper

  def countries
    [
      ["United States", "USA"],
      ["Canada", "Canada"],
      ["Mexico", "Mexico"]
    ]
  end
  def us_states
    [
      ["Alaska", "AK"],
      ["Alabama", "AL"],
      ["Arkansas", "AR"],
      ["Arizona", "AZ"],
      ["California", "CA"],
      ["Colorado", "CO"],
      ["Connecticut", "CT"],
      ["District of Columbia ", "DC"],
      ["Delaware", "DE"],
      ["Florida", "FL"],
      ["Georgia", "GA"],
      ["Hawaii", "HI"],
      ["Iowa", "IA"],
      ["Idaho", "ID"],
      ["Illinois", "IL"],
      ["Indiana", "IN"],
      ["Kansas", "KS"],
      ["Kentucky", "KY"],
      ["Louisiana", "LA"],
      ["Massachusettes", "MA"],
      ["Maryland", "MD"],
      ["Maine", "ME"],
      ["Michigan", "MI"],
      ["Minnesota", "MN"],
      ["Missouri", "MO"],
      ["Mississippi", "MS"],
      ["Montana", "MT"],
      ["North Carolina", "NC"],
      ["North Dakota", "ND"],
      ["Nebraska", "NE"],
      ["New Hampshire", "NH"],
      ["New Jersey", "NJ"],
      ["New Mexico", "NM"],
      ["Nevada", "NV"],
      ["New York", "NY"],
      ["Ohio", "OH"],
      ["Oklahoma", "OK"],
      ["Oregon", "OR"],
      ["Pennsylvania", "PA"],
      ["Rhode Island", "RI"],
      ["South Carolina", "SC"],
      ["South Dakota", "SD"],
      ["Tennessee", "TN"],
      ["Texas", "TX"],
      ["Utah", "UT"],
      ["Virginia", "VA"],
      ["Vermont", "VT"],
      ["Washington", "WA"],
      ["Wisconsin", "WI"],
      ["West Virginia", "WV"],
      ["Wyoming", "WY"]
    ]
  end

  def point_spreads
    [
      ["pk", 0, { :'selected' => 'selected' }],  #default spread
      [-50, -50],
      [-49.5, -49.5],
      [-49, -49],
      [-48.5, -48.5],
      [-48, -48],
      [-47.5, -47.5],
      [-47, -47],
      [-46.5, -46.5],
      [-46, -46],
      [-45.5, -45.5],
      [-45, -45],
      [-44.5, -44.5],
      [-44, -44],
      [-43.5, -43.5],
      [-43, -43],
      [-42.5, -42.5],
      [-42, -42],
      [-41.5, -41.5],
      [-41, -41],
      [-40.5, -40.5],
      [-40, -40],
      [-39.5, -39.5],
      [-39, -39],
      [-38.5, -38.5],
      [-38, -38],
      [-37.5, -37.5],
      [-37, -37],
      [-36.5, -36.5],
      [-36, -36],
      [-35.5, -35.5],
      [-35, -35],
      [-34.5, -34.5],
      [-34, -34],
      [-33.5, -33.5],
      [-33, -33],
      [-32.5, -32.5],
      [-32, -32],
      [-31.5, -31.5],
      [-31, -31],
      [-30.5, -30.5],
      [-30, -30],
      [-29.5, -29.5],
      [-29, -29],
      [-28.5, -28.5],
      [-28, -28],
      [-27.5, -27.5],
      [-27, -27],
      [-26.5, -26.5],
      [-26, -26],
      [-25.5, -25.5],
      [-25, -25],
      [-24.5, -24.5],
      [-24, -24],
      [-23.5, -23.5],
      [-23, -23],
      [-22.5, -22.5],
      [-22, -22],
      [-21.5, -21.5],
      [-21, -21],
      [-20.5, -20.5],
      [-20, -20],
      [-19.5, -19.5],
      [-19, -19],
      [-18.5, -18.5],
      [-18, -18],
      [-17.5, -17.5],
      [-17, -17],
      [-16.5, -16.5],
      [-16, -16],
      [-15.5, -15.5],
      [-15, -15],
      [-14.5, -14.5],
      [-14, -14],
      [-13.5, -13.5],
      [-13, -13],
      [-12.5, -12.5],
      [-12, -12],
      [-11.5, -11.5],
      [-11, -11],
      [-10.5, -10.5],
      [-10, -10],
      [-9.5, -9.5],
      [-9, -9],
      [-8.5, -8.5],
      [-8, -8],
      [-7.5, -7.5],
      [-7, -7],
      [-6.5, -6.5],
      [-6, -6],
      [-5.5, -5.5],
      [-5, -5],
      [-4.5, -4.5],
      [-4, -4],
      [-3.5, -3.5],
      [-3, -3],
      [-2.5, -2.5],
      [-2, -2],
      [-1.5, -1.5],
      [-1, -1],
      [-0.5, -0.5],
      ["+0.5", 0.5],
      ["+1", 1],
      ["+1.5", 1.5],
      ["+2", 2],
      ["+2.5", 2.5],
      ["+3", 3],
      ["+3.5", 3.5],
      ["+4", 4],
      ["+4.5", 4.5],
      ["+5", 5],
      ["+5.5", 5.5],
      ["+6", 6],
      ["+6.5", 6.5],
      ["+7", 7],
      ["+7.5", 7.5],
      ["+8", 8],
      ["+8.5", 8.5],
      ["+9", 9],
      ["+9.5", 9.5],
      ["+10", 10],
      ["+10.5", 10.5],
      ["+11", 11],
      ["+11.5", 11.5],
      ["+12", 12],
      ["+12.5", 12.5],
      ["+13", 13],
      ["+13.5", 13.5],
      ["+14", 14],
      ["+14.5", 14.5],
      ["+15", 15],
      ["+15.5", 15.5],
      ["+16", 16],
      ["+16.5", 16.5],
      ["+17", 17],
      ["+17.5", 17.5],
      ["+18", 18],
      ["+18.5", 18.5],
      ["+19", 19],
      ["+19.5", 19.5],
      ["+20", 20],
      ["+20.5", 20.5],
      ["+21", 21],
      ["+21.5", 21.5],
      ["+22", 22],
      ["+22.5", 22.5],
      ["+23", 23],
      ["+23.5", 23.5],
      ["+24", 24],
      ["+24.5", 24.5],
      ["+25", 25],
      ["+25.5", 25.5],
      ["+26", 26],
      ["+26.5", 26.5],
      ["+27", 27],
      ["+27.5", 27.5],
      ["+28", 28],
      ["+28.5", 28.5],
      ["+29", 29],
      ["+29.5", 29.5],
      ["+30", 30],
      ["+30.5", 30.5],
      ["+31", 31],
      ["+31.5", 31.5],
      ["+32", 32],
      ["+32.5", 32.5],
      ["+33", 33],
      ["+33.5", 33.5],
      ["+34", 34],
      ["+34.5", 34.5],
      ["+35", 35],
      ["+35.5", 35.5],
      ["+36", 36],
      ["+36.5", 36.5],
      ["+37", 37],
      ["+37.5", 37.5],
      ["+38", 38],
      ["+38.5", 38.5],
      ["+39", 39],
      ["+39.5", 39.5],
      ["+40", 40],
      ["+40.5", 40.5],
      ["+41", 41],
      ["+41.5", 41.5],
      ["+42", 42],
      ["+42.5", 42.5],
      ["+43", 43],
      ["+43.5", 43.5],
      ["+44", 44],
      ["+44.5", 44.5],
      ["+45", 45],
      ["+45.5", 45.5],
      ["+46", 46],
      ["+46.5", 46.5],
      ["+47", 47],
      ["+47.5", 47.5],
      ["+48", 48],
      ["+48.5", 48.5],
      ["+49", 49],
      ["+49.5", 49.5],
      ["+50", 50]
    ]
  end

  def vigs
    [
      [-110, -110, { :'selected' => 'selected' }], #default vig
      [-1000, -1000],
      [-990, -990],
      [-980, -980],
      [-970, -970],
      [-960, -960],
      [-950, -950],
      [-940, -940],
      [-930, -930],
      [-920, -920],
      [-910, -910],
      [-900, -900],
      [-890, -890],
      [-880, -880],
      [-870, -870],
      [-860, -860],
      [-850, -850],
      [-840, -840],
      [-830, -830],
      [-820, -820],
      [-810, -810],
      [-800, -800],
      [-790, -790],
      [-780, -780],
      [-770, -770],
      [-760, -760],
      [-750, -750],
      [-740, -740],
      [-730, -730],
      [-720, -720],
      [-710, -710],
      [-700, -700],
      [-690, -690],
      [-680, -680],
      [-670, -670],
      [-660, -660],
      [-650, -650],
      [-640, -640],
      [-630, -630],
      [-620, -620],
      [-610, -610],
      [-600, -600],
      [-590, -590],
      [-580, -580],
      [-570, -570],
      [-560, -560],
      [-550, -550],
      [-540, -540],
      [-530, -530],
      [-520, -520],
      [-510, -510],
      [-500, -500],
      [-490, -490],
      [-480, -480],
      [-470, -470],
      [-460, -460],
      [-450, -450],
      [-440, -440],
      [-430, -430],
      [-420, -420],
      [-410, -410],
      [-400, -400],
      [-390, -390],
      [-380, -380],
      [-370, -370],
      [-360, -360],
      [-350, -350],
      [-340, -340],
      [-330, -330],
      [-320, -320],
      [-310, -310],
      [-300, -300],
      [-295, -295],
      [-290, -290],
      [-285, -285],
      [-280, -280],
      [-275, -275],
      [-270, -270],
      [-265, -265],
      [-260, -260],
      [-255, -255],
      [-250, -250],
      [-245, -245],
      [-240, -240],
      [-235, -235],
      [-230, -230],
      [-225, -225],
      [-220, -220],
      [-215, -215],
      [-210, -210],
      [-205, -205],
      [-200, -200],
      [-195, -195],
      [-190, -190],
      [-185, -185],
      [-180, -180],
      [-175, -175],
      [-170, -170],
      [-165, -165],
      [-160, -160],
      [-155, -155],
      [-150, -150],
      [-145, -145],
      [-140, -140],
      [-135, -135],
      [-130, -130],
      [-125, -125],
      [-120, -120],
      [-115, -115],
      [-105, -105],
      ["+100", 100],
      ["+105", 105],
      ["+110", 110],
      ["+115", 115],
      ["+120", 120],
      ["+125", 125],
      ["+130", 130],
      ["+135", 135],
      ["+140", 140],
      ["+145", 145],
      ["+150", 150],
      ["+155", 155],
      ["+160", 160],
      ["+165", 165],
      ["+170", 170],
      ["+175", 175],
      ["+180", 180],
      ["+185", 185],
      ["+190", 190],
      ["+195", 195],
      ["+200", 200],
      ["+205", 205],
      ["+210", 210],
      ["+215", 215],
      ["+220", 220],
      ["+225", 225],
      ["+230", 230],
      ["+235", 235],
      ["+240", 240],
      ["+245", 245],
      ["+250", 250],
      ["+255", 255],
      ["+260", 260],
      ["+265", 265],
      ["+270", 270],
      ["+275", 275],
      ["+280", 280],
      ["+285", 285],
      ["+290", 290],
      ["+295", 295],
      ["+300", 300],
      ["+310", 310],
      ["+320", 320],
      ["+330", 330],
      ["+340", 340],
      ["+350", 350],
      ["+360", 360],
      ["+370", 370],
      ["+380", 380],
      ["+390", 390],
      ["+400", 400],
      ["+410", 410],
      ["+420", 420],
      ["+430", 430],
      ["+440", 440],
      ["+450", 450],
      ["+460", 460],
      ["+470", 470],
      ["+480", 480],
      ["+490", 490],
      ["+500", 500],
      ["+510", 510],
      ["+520", 520],
      ["+530", 530],
      ["+540", 540],
      ["+550", 550],
      ["+560", 560],
      ["+570", 570],
      ["+580", 580],
      ["+590", 590],
      ["+600", 600],
      ["+610", 610],
      ["+620", 620],
      ["+630", 630],
      ["+640", 640],
      ["+650", 650],
      ["+660", 660],
      ["+670", 670],
      ["+680", 680],
      ["+690", 690],
      ["+700", 700],
      ["+710", 710],
      ["+720", 720],
      ["+730", 730],
      ["+740", 740],
      ["+750", 750],
      ["+760", 760],
      ["+770", 770],
      ["+780", 780],
      ["+790", 790],
      ["+800", 800],
      ["+810", 810],
      ["+820", 820],
      ["+830", 830],
      ["+840", 840],
      ["+850", 850],
      ["+860", 860],
      ["+870", 870],
      ["+880", 880],
      ["+890", 890],
      ["+900", 900],
      ["+910", 910],
      ["+920", 920],
      ["+930", 930],
      ["+940", 940],
      ["+950", 950],
      ["+960", 960],
      ["+970", 970],
      ["+980", 980],
      ["+990", 990],
      ["+1000", 1000]
    ]
  end
end
