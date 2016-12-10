# Description
#   Interface for the Walters Museum API via Hubot
#
# Configuration:
#   HUBOT_WALTERS_MUSEUM_API_KEY
#   HUBOT_WALTERS_MUSEUM_API_VERSION
#
# Commands:
#   hubot recent exhibitions - <return the latest exhibitions>
#
# Author:
#   hector@hectorleiva.com

waltersAPIKey = process.env.HUBOT_WALTERS_MUSEUM_API_KEY
waltersMuseumAPIVersion = process.env.HUBOT_WALTERS_MUSEUM_API_VERSION or 'v1'
waltersMuseumBaseAPIURL = process.env.HUBOT_WALTERS_MUSEUM_BASE_URL or 'http://api.thewalters.org'
waltersMuseumBaseURL = "#{waltersMuseumBaseAPIURL}/#{waltersMuseumAPIVersion}"

WaltersMuseumController = require './waltersMuseumController'
WaltersMuseum = new WaltersMuseumController(waltersAPIKey, waltersMuseumBaseURL)

module.exports = (robot) ->
  robot.respond /(recent|latest) exhibitions?/, (msg) ->
    WaltersMuseum.latestExhibitions msg

  robot.respond /collections/, (msg) ->
    WaltersMuseum.collections msg
