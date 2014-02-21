# Description:
#   Gets the menu of the day
#
# Commands:
#   hubot menu

module.exports = (robot) ->
 robot.respond /menu$/i, (msg) ->
  msg.http("https://gist.githubusercontent.com/mtie/7465174/raw/MenuOfTheDay.json")
   .get() (error, response, body) ->
    menu = JSON.parse(body)[getDate()]
    if menu?
     msg.send ":fork_and_knife: " + menu
    else
     msg.send "Couldn't find the menu for date " + getDate()

getDate = () ->
 currentDate = new Date()
 day = currentDate.getDate()
 month = currentDate.getMonth() + 1
 year = currentDate.getFullYear()
 return day + "/" + month + "/" + year
