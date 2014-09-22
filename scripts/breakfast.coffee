# Description:
#   Print next bringers of breakfast
#
# Commands:
#   hubot breakfast

module.exports = (robot) ->
 robot.respond /breakfast$/i, (msg) ->
  msg.send "Fetching employees"

  employees = "[{"name":"Endnu en testbruger","latestDelivery":null,"_id":"541ff5241a7e9002000e4798","__v":0},{"__v":0,"_id":"5236dd8bfad2e50200000001","email":"lund@telenor.dk","latestDelivery":"2013-09-16T14:36:11.358Z","name":"Martin Lund"},{"__v":0,"_id":"5237f27c7c3f090200000001","email":"lund@telenor.dk","latestDelivery":"2013-09-17T06:11:17.856Z","name":"Lund"}]";
  bringers = JSON.parse(body)
  msg.send bringers
  printEmployee employee for employee in bringers

  request = msg.http("http://http://morgenmad.herokuapp.com/api/")
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
  request.setTimeout(10000) ->
   msg.send "Timeout expired"

printEmployee = (employee) ->
 msg.send ":fork_and_knife: " + employee.name
