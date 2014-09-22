# Description:
#   Print next bringers of breakfast
#
# Commands:
#   hubot breakfast

module.exports = (robot) ->
 robot.respond /breakfast$/i, (msg) ->
  msg.send "Fetching employees"
  msg.http("http://http://morgenmad.herokuapp.com/api/")
   .get() (response, body) ->
    bringers = JSON.parse(body)
    msg.send bringers
    printEmployee employee for employee in bringers
   .on('error') (error) ->
    console.log e.message

printEmployee = (employee) ->
 msg.send ":fork_and_knife: " + employee.name
