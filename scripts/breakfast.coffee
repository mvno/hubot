# Description:
#   Print next bringers of breakfast
#
# Commands:
#   hubot breakfast

module.exports = (robot) ->
 robot.respond /breakfast$/i, (msg) ->
  msg.send "Fetching employees"
  msg.http("http://http://morgenmad.herokuapp.com/api/")
   .header('Accept', 'application/json')
   .get() (error, response, body) ->
    msg.send body
    if error
     msg.send "Encountered an error :( #{error}"
     return

    msg.send "Http statuscode: " + response.statusCode
    bringers = JSON.parse(body)
    msg.send bringers
    printEmployee employee for employee in bringers

printEmployee = (employee) ->
 msg.send ":fork_and_knife: " + employee.name
