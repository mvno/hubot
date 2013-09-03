# Description:
#   Lets hubot review stuff.
#

module.exports = (robot) ->
  robot.hear /(review.*agilezen\.com)|(agilezen\.com.*review)/, (msg) ->
    msg.send ['Done!', 'Ready!', 'Good job!'][Math.floor(Math.random() * 3)]