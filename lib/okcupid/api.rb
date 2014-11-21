module OkCupid
  class API
    include HTTParty

    COOKIE_REGEX = /\bsession=.{5,}?;/

    base_uri 'https://www.okcupid.com'

    def initialize(username = nil, password = nil)
      login(username, password) if username && password
    end

    # Public: Gets a list of the users messages.
    #
    # Examples
    #
    #   messages
    #   # => [...]
    #
    # Returns an array.
    def messages(low = 1, infiniscroll = 1, folder = 1)
      response = request(
        :get,
        "/messages?low=#{low}&infiniscroll=#{infiniscroll}&folder=#{folder}"
      )

      doc = Nokogiri::HTML(response)

      doc.css(OkCupid::Message::CSS_SELECTOR).map do |message|
        OkCupid::Message.new message
      end
    end

    # Public: Determines if the user is logged in.
    #
    # Examples
    #
    #   logged_in?
    #   # => true
    #
    # Returns true or false.
    def logged_in?
      !!@cookie
    end

    private

    # Private: Logs a user in.
    #
    # Sets the @cookie variable.
    #
    # Subsequent requests acknowledge the @cookie and authenticate the user.
    #
    # Examples
    #
    #   login(username, password)
    #   # => 'session: 1234;'
    #
    # Returns a cookie string.
    def login(username, password)
      @cookie = request(:post, '/login',
        body: {
          username: username,
          password: password,
          okc_api: 1
        }
      ).headers['set-cookie'][COOKIE_REGEX]
    end

    # Private: Convenience method for making API requests.
    #
    # Returns an HTTParty::Response
    def request(method, endpoint, options = {})
      self.class.send(
        method,
        endpoint,
        body: options[:body],
        headers: default_headers.merge(options[:headers] || {})
      )
    end

    # Private: Default HTTP Headers
    #
    # Returns a hash.
    def default_headers
      {
        'X-Requested-With' => 'XMLHttpRequest',
        'User-Agent' => 'User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_9_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/39.0.2171.36 Safari/537.36',
        'Cookie' => "#{@cookie}"
      }
    end
  end
end
