moment = require 'moment';
BaseController = require './BaseController';

module.exports = class ExhibitionsController extends BaseController
  constructor: (waltersAPIKey, waltersMuseumBaseURL) ->
    super(waltersAPIKey, waltersMuseumBaseURL)
    @waltersAPIKey = waltersAPIKey
    @waltersMuseumBaseURL = waltersMuseumBaseURL

  # Relevent as in exhibitions that are in the future, that haven't ended yet
  getLatestReleventExhibitions: (msg) ->
    getUpcomingExhibitions = @getUpcomingExhibitions
    if @checkAPIKey(msg, @waltersAPIKey)
      thisYear = moment().year()

      msg.http(@museumResourceURL(
        @waltersMuseumBaseURL
        , @waltersAPIKey
        , 'exhibitions'
        , "beginYear=#{thisYear}&soryBy=beginYear&page=1"
      ))
      .get() (err, res, body) ->
        if err
          msg.send """
          There was an error attempting to reach out to the Walter's Musem:
          #{err}
          """
        response = JSON.parse body
        items = response.Items
        upcomingExhibitions = getUpcomingExhibitions items

        exhibitionInfo = """
        The following exhibitions are at The Walter's currently:
        """

        for exhibit, i in upcomingExhibitions
          exhibitionInfo += """
          \n
          #{exhibit.ExhTitle}
          Textblock: #{exhibit.Textblock}
          Display Dates: #{exhibit.ExhibDisplayDate}
          """

        msg.send exhibitionInfo
        return

  # Time-window, only get exhibitions that are after today's current date
  getUpcomingExhibitions: (items) ->
    currentDate = moment().format('Y-MM-DD')
    items.filter (item) ->
      if currentDate < item.ExhibEndDate and currentDate > item.ExhibBeginDate
        return true
      else
        return false
