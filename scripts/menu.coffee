# Description:
#   Gets the menu of the day
#
# Commands:
#   hubot menu

module.exports = (robot) ->
 robot.respond /menu$/i, (msg) ->
  msg.http("https://gist.githubusercontent.com/jehmvno/eca5aee48cbd857ff3d198385e1584b2/raw/606f911634e22d49ce6b38a01d0ed2ae6e77c990/MenuOfTheDay.json")
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
