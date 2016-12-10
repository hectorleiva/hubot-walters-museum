ExhibitionsController = require './Controllers/ExhibitionsController'
CollectionsController = require './Controllers/CollectionsController'

module.exports = class WaltersMuseumClient
  constructor: (waltersAPIKey, waltersMuseumBaseURL) ->
    @Exhibitions = new ExhibitionsController(waltersAPIKey, waltersMuseumBaseURL)
    @Collections = new CollectionsController(waltersAPIKey, waltersMuseumBaseURL)

  collections: (msg) ->
    @Collections.collections msg

  latestExhibitions: (msg) ->
    @Exhibitions.getLatestReleventExhibitions msg
