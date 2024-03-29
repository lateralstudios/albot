# Description:
#   "Makes your Hubot even more Clever™"
#
# Dependencies:
#   "cleverbot-node": "0.1.1"
#
# Configuration:
#   None
#
# Commands:
#   hubot c <input>
#
# Author:
#   ajacksified

cleverbot = require('cleverbot-node')

module.exports = (robot) ->
  c = new cleverbot()
  robot.respond /c (.*)/i, (msg) ->
    data = msg.match[1].trim()
    c.write(data, (c) => msg.send(c.message))

  robot.catchAll (msg) ->
    rStart = new RegExp "^(?:#{robot.alias}|#{robot.name}:?) (.*)", "i"
    rEnd   = new RegExp "(.*) (#{robot.alias}|#{robot.name}\??)$", "i"
    matches = msg.message.text.match(rStart)
    if matches == null || matches.length < 1
      matches = msg.message.text.match(rEnd)
    if matches != null && matches.length > 1
      c.write(matches[1], (c) => msg.send(c.message)) 
    msg.finish()
