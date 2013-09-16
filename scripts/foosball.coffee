# Description 
# Setting up fussball teams 

maxplayers = 4 
Array::shuffle = -> @sort -> 0.5 - Math.random()
Array::remove = (e) -> @[t..t] = [] if (t = @indexOf(e)) > -1

module.exports = (robot) ->
  robot.brain.data.players = []
  robot.hear /^(foosball|ball|bold) ?(.*)/i, (msg) ->
    sender = msg.message.user.name
    command = msg.match[2].substring(0, msg.match[2].indexOf(' '))
    if (command is "")
      if (robot.brain.data.players.length is 0)
        robot.brain.data.players.push sender
        msg.send ":soccer: #{robot.brain.data.players[0]} wants to play. Anyone else wants to play foosball?"
      else
        if (sender in robot.brain.data.players)
          msg.send ":soccer: #{sender} REALLY wants to play. #{maxplayers - robot.brain.data.players.length} More needed"
        else
          robot.brain.data.players.push sender
          if ((maxplayers - robot.brain.data.players.length) is 0)
            robot.brain.data.players.shuffle()
            msg.send ":soccer: :large_blue_circle: #{robot.brain.data.players[0]} & #{robot.brain.data.players[1]} :red_circle: #{robot.brain.data.players[2]} & #{robot.brain.data.players[3]}"
            robot.brain.data.players = []
          else
            msg.send ":soccer: #{sender} is game! #{maxplayers - robot.brain.data.players.length} more needed"
    else
      switch command
        when "queue", "kø"
          msg.send ":soccer: #{robot.brain.data.players.join(', ')} wants to play. #{maxplayers - robot.brain.data.players.length} more needed"
        when "remove", "fjern"
          sender = msg.message.user.name
          robot.brain.data.players.remove(sender)
          msg.send ":soccer: #{sender} is a chicken. #{maxplayers - robot.brain.data.players.length} More needed"
        when "players"
          commandData = msg.match[2].substring(msg.match[2].indexOf(' ') + 1)
          players = commandData.split(",")
          robot.brain.data.players.push players
          msg.send ":soccer: #{robot.brain.data.players.join(', ')} wants to play. #{maxplayers - robot.brain.data.players.length} more needed"
        else
          msg.send "#{command} is an unknown command"
