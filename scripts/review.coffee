# Description
# Setting up review team

maxreviewers = 3
Array::shuffle = -> @sort -> 0.5 - Math.random()
Array::remove = (e) -> @[t..t] = [] if (t = @indexOf(e)) > -1
reviewersAreReady = (reviewers) -> (maxreviewers - reviewers.length) <= 0
startGame = (message, robot) ->
  robot.brain.data.reviewers.shuffle()
  message.send ":octocat: Review! #{robot.brain.data.reviewers[0]}, #{robot.brain.data.reviewers[1]} & #{robot.brain.data.reviewers[2]}"
  robot.brain.data.reviewers = []

module.exports = (robot) ->
  robot.brain.data.reviewers = []
  robot.respond /review/i, (msg) ->
    msg.send ":octocat: review requested"
    sender = msg.message.user.name
    command = msg.match[2].split(" ")[0]
    if (command is "")
      if (robot.brain.data.reviewers.length is 0)
        robot.brain.data.reviewers.push sender
        msg.send ":octocat: #{robot.brain.data.reviewers[0]} wants to do a codereview. Anyone else wants to do codereview?"
      else
        if (sender in robot.brain.data.reviewers)
          msg.send ":octocat: #{sender} REALLY wants to review some code. #{maxreviewers - robot.brain.data.reviewers.length} more needed"
        else
          robot.brain.data.reviewers.push sender
          if (reviewersAreReady(robot.brain.data.reviewers))
            startGame(msg, robot)
          else
            msg.send ":octocat: #{sender} is game! #{maxreviewers - robot.brain.data.reviewers.length} more needed"
    else
      switch command
        when "queue", "kø"
          msg.send ":octocat: #{robot.brain.data.reviewers.join(', ')} wants to review some code. #{maxreviewers - robot.brain.data.reviewers.length} more needed"
        when "remove", "fjern"
          message = msg.match[2]
          commandData = if message.indexOf(' ') is -1 then '' else message.substring(message.indexOf(' ') + 1)
          if(commandData.length is 0)
            sender = msg.message.user.name
            robot.brain.data.reviewers.remove(sender)
          else
            sender = commandData
            robot.brain.data.reviewers.remove(sender)

          msg.send ":octocat: #{sender} is a chicken. #{maxreviewers - robot.brain.data.reviewers.length} More needed"
        when "reviewers"
          commandData = msg.match[2].substring(msg.match[2].indexOf(' ') + 1)
          reviewers = commandData.split(",")
          robot.brain.data.reviewers.push reviewer.trim() for reviewer in reviewers
          if (reviewersAreReady(robot.brain.data.reviewers))
            startGame(msg, robot)
          else
            msg.send ":octocat: #{robot.brain.data.reviewers.join(', ')} wants to review some code. #{maxreviewers - robot.brain.data.reviewers.length} more needed"
        else
          msg.send "#{command} is an unknown command"
