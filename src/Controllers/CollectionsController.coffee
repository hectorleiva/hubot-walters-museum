BaseController = require './BaseController'

module.exports = class CollectionsController extends BaseController
  constructor: (waltersAPIKey, waltersMuseumBaseURL) ->
    super(waltersAPIKey, waltersMuseumBaseURL)
    @waltersAPIKey = waltersAPIKey
    @waltersMuseumBaseURL = waltersMuseumBaseURL

  collections: (msg) ->
    if @checkAPIKey(msg, @waltersAPIKey)
      msg.http(@museumResourceURL(
        @waltersMuseumBaseURL
        , @waltersAPIKey
        , 'collections'
      ))
      .get() (err, res, body) ->
        if err
          msg.send """
          There was an error attempting to reach out to the Walter's Museum:
          #{err}
          """
          return

        result = JSON.parse(body)

        for index, collection_item of result.Items
          msg.send """
            Collection Name: #{collection_item.CollectionName}.
            Collection Description: #{collection_item.CollDescription}
            Num of Objects in this collection: #{collection_item.NumObjects}
          """
