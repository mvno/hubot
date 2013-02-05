# Description 
# Setting up fussball teams 
#
# Commands:
# Hubot fussball
# hubot ball
# hubot bold 

players = []
maxplayers = 4 
Array::shuffle = -> @sort -> 0.5 - Math.random()

module.exports = (robot) ->
  robot.respond  /@?(foosball|ball|bold)*$/i, (msg) ->
    sender = msg.message.user.name.toLowerCase()
    if (players.length is 0)
      players.push sender
      msg.send "#{players[0]} wants to play. Anyone else wants to play foosball?"
    else
      msg.send "#{sender}! Dude, a game is about to start. Join by typing 'hubot bold ja'"

  robot.respond /@?(foosball|ball|bold|debug) ja*$/i, (msg) ->
    command = msg.match[1]
    sender = msg.message.user.name.toLowerCase()

    if(command.trim() is 'debug')
      sender = "#{sender}-Debug-#{players.length}"

    if (sender in players)
      msg.send "#{sender} REALLY wants to play. #{maxplayers - players.length} More needed" 
    else 
      players.push sender
      msg.send "#{players.toString()} wants to play. #{maxplayers - players.length} More needed" 

    if ((maxplayers - players.length) is 0)
      players.shuffle()
      msg.send "Teams are BLUE: #{players[0]} and #{players[1]} RED: #{players[2]}, #{players[3]}"
      players = []

    