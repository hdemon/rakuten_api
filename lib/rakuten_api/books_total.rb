require "faraday"
require "faraday_middleware"

module RakutenApi
  class BooksTotal
    REQUEST_INTERVAL_SECOND = 1 # see: http://webservice.faq.rakuten.co.jp/app/answers/detail/a_id/14261
    URL = "/services/api/BooksBook/Search/20130522"

    def initialize(appId:, format: 'json', verbose: false)
      @appId = appId
      @format = format
      @verbose = verbose

      @connection = Faraday.new(url: 'https://app.rakuten.co.jp') do |faraday|
        faraday.adapter  Faraday.default_adapter
        faraday.response :json, :content_type => /\bjson$/
        faraday.response :logger if @verbose
      end
    end

    def fetch(title:, booksGenreId: '001', page: 1)
      @connection.get do |request|
        request.url URL
        request.params['applicationId'] = @appId
        request.params['format'] = @format
        request.params['formatVersion'] = 2
        request.params['booksGenreId'] = booksGenreId
        request.params['title'] = title
        request.params['page'] = page
      end
    end

    def fetchAll(title:, booksGenreId: '001')
      first = fetch(title: title, booksGenreId: booksGenreId, page: 1)
      total_page_count = first.body["pageCount"]

      result = (2..total_page_count).each_with_object([]) do |page_count, memo|
        sleep REQUEST_INTERVAL_SECOND
        response = fetch(title: title, booksGenreId: booksGenreId, page: page_count)
        memo << response.body["Items"]
      end

      first.body["Items"].concat result.flatten
    end
  end
end
