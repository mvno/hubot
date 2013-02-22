# Description 
# Setting up fussball teams 
#
# Commands:
# Hubot foosball
# hubot ball
# hubot bold 

maxplayers = 4 
Array::shuffle = -> @sort -> 0.5 - Math.random()

module.exports = (robot) ->
  robot.brain.data.players = []
  robot.respond  /@?(foosball|ball|bold)*$/i, (msg) ->
    sender = msg.message.user.name
    if (robot.brain.data.players.length is 0)
      robot.brain.data.players.push sender
      msg.send ":soccer: #{robot.brain.data.players[0]} wants to play. Anyone else wants to play foosball?"
    else
      msg.send "Sorry #{sender} Dude, a game is about to start. Join by typing 'hubot bold ja'"

  robot.respond /@?(foosball|ball|bold|debug) ja*$/i, (msg) ->
    command = msg.match[1]
    sender = msg.message.user.name

    if (command.trim() is 'debug')
      sender = "#{sender}-Debug-#{robot.brain.data.players.length}"

    if (sender in robot.brain.data.players)
      msg.send "#{sender} REALLY wants to play. #{maxplayers - robot.brain.data.players.length} More needed" 
    else 
      robot.brain.data.players.push sender
      if ((maxplayers - robot.brain.data.players.length) is 0)
        robot.brain.data.players.shuffle()
        msg.send ":large_blue_circle: #{robot.brain.data.players[0]} & #{robot.brain.data.players[1]} :red_circle: #{robot.brain.data.players[2]} & #{robot.brain.data.players[3]}"
        robot.brain.data.players = []
      else
        msg.send "#{robot.brain.data.players.toString()} wants to play. #{maxplayers - robot.brain.data.players.length} more needed"

    