# Description:
#   Gets the menu of the day
#
# Commands:
#   hubot menu

module.exports = (robot) ->
 robot.respond /menu$/i, (msg) ->
  msg.http("https://gist.github.com/Leh2/7464481/raw/telenor_menu.json")
   .get() (error, response, body) ->
    menu = JSON.parse(body)[getDate()]
    if menu?
     msg.send menu
    else
     msg.send "Couldn't find the menu for date " + getDate()

getDate = () ->
 currentDate = new Date()
 day = currentDate.getDate()
 month = currentDate.getMonth() + 1
 year = currentDate.getFullYear()
 return day + "/" + month + "/" + year
