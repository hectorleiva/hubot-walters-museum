module.exports = class BaseController
  constructor: () ->

  # Helper for if the class is missing the API Key
  checkAPIKey: (msg, waltersAPIKey) ->
    if !waltersAPIKey?
      return msg.send """
        You need to setup your Walters API Key first!
        Please visit http://api.thewalters.org/ to get your API Key
        and add it to your bot!
      """
    else
      return true

  # Helper to construct the URL for the specified resource
  museumResourceURL: (baseURL, APIKey, resource, params) ->
    return "#{baseURL}/#{resource}?apikey=#{APIKey}&#{params}"
