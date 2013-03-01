# Description:
#   Ha! Gaaaaaay.
#
# Commands:
#   hubot gay
module.exports = (robot) ->
  robot.respond /@?(gay)*$/i, (msg) ->
    msg.send "http://www.youtube.com/watch?v=wXw6znXPfy4"
