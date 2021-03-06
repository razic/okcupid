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
    # Returns an array of messages.
    def messages(low = 1, infiniscroll = 1, folder = 1)
      response = request(
        :get,
        "/messages?low=#{low}&infiniscroll=#{infiniscroll}&folder=#{folder}"
      )

      Nokogiri::HTML(response).css('li[id^=message_]').map do |message|
        OkCupid::Message.new message
      end
    end

    # Public: Gets a list of the users messages within a particular thread.
    #
    # Examples
    #
    #   thread
    #   # => [...]
    #
    # Returns an array of messages.
    def thread(threadid)
      response = request(
        :get,
        "/messages?readmsg=true&threadid=#{threadid}&folder=1"
      )

      Nokogiri::HTML(response).css('#thread li[id^=message_]').map do |message|
        OkCupid::Message.new message
      end
    end

    # Public: Deletes an entire message thread.
    #
    # Examples
    #
    #   delete_thread(threadid)
    #
    # Returns an HTTParty Response.
    def delete_thread(threadid)
      request(
        :delete,
        "/apitun/messages/threads?access_token=#{access_token}&threadids=%5B%22#{threadid}%22%5D"
      )
    end

    # Public: Gets an authentication token and memoizes it.
    #
    # Memoizes the @authentication_token variable.
    #
    # The token can be used for deleting messages and other API calls.
    #
    # Examples
    #
    #   authentication_token
    #   # => 'abc123'
    #
    # Returns an authentication token string.
    def access_token
      @access_token ||= begin
        response = request(:get, "/messages")

        Nokogiri::HTML(response).css("#search_overlay_authcode").text
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
