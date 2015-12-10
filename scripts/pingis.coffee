# Description 
# Setting up pingis teams 

maxplayers = 2
Array::shuffle = (a) -> a.sort -> 0.5 - Math.random()
Array::remove = (e) -> @[t..t] = [] if (t = @indexOf(e)) > -1
playersAreReady = (players) -> (maxplayers - players.length) <= 0
startGame = (message, robot) ->
  robot.brain.data.pingpongers.shuffle()
  message.send ":table_tennis_paddle_and_ball: :large_blue_circle: @#{robot.brain.data.pingpongers[0]} :red_circle: @#{robot.brain.data.pingpongers[1]}"
  robot.brain.data.pingpongers = []

module.exports = (robot) ->
  robot.brain.data.pingpongers = []
  robot.hear /^(pingis) ?(.*)/i, (msg) ->
    sender = msg.message.user.name
    command = msg.match[2].split(" ")[0]
    if (command is "")
      if (robot.brain.data.pingpongers.length is 0)
        robot.brain.data.pingpongers.push sender
        msg.send ":table_tennis_paddle_and_ball: #{robot.brain.data.pingpongers[0]} wants to play. Anyone else wants to play pingis?"
      else
        if (sender in robot.brain.data.pingpongers)
          msg.send ":table_tennis_paddle_and_ball: #{sender} REALLY wants to play. #{maxplayers - robot.brain.data.pingpongers.length} More needed"
        else
          robot.brain.data.pingpongers.push sender
          if (playersAreReady(robot.brain.data.pingpongers))
            startGame(msg, robot)
          else
            msg.send ":table_tennis_paddle_and_ball: #{sender} is game! #{maxplayers - robot.brain.data.pingpongers.length} more needed"
    else
      switch command
        when "queue", "kø"
          msg.send ":table_tennis_paddle_and_ball: #{robot.brain.data.pingpongers.join(', ')} wants to play. #{maxplayers - robot.brain.data.pingpongers.length} more needed"
        when "remove", "fjern"
          message = msg.match[2]
          commandData = if message.indexOf(' ') is -1 then '' else message.substring(message.indexOf(' ') + 1)
          if(commandData.length is 0)
            sender = msg.message.user.name
            robot.brain.data.pingpongers.remove(sender)
          else
            sender = commandData
            robot.brain.data.pingpongers.remove(sender)

          msg.send ":table_tennis_paddle_and_ball: #{sender} is a chicken. #{maxplayers - robot.brain.data.pingpongers.length} More needed"
        when "players"
          commandData = msg.match[2].substring(msg.match[2].indexOf(' ') + 1)
          players = commandData.split(",")
          robot.brain.data.pingpongers.push player.trim() for player in players
          if (playersAreReady(robot.brain.data.pingpongers))
            startGame(msg, robot)
          else
            msg.send ":table_tennis_paddle_and_ball: #{robot.brain.data.pingpongers.join(', ')} wants to play. #{maxplayers - robot.brain.data.pingpongers.length} more needed"
        else
          msg.send "#{command} is an unknown command"
