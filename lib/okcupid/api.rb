module OkCupid
  class API
    attr_accessor :authorization_token

    # Public: Determines if the user is logged in.
    #
    # Examples
    #
    #   logged_in?
    #   # => true
    #
    # Returns true or false.
    def logged_in?
      !!authorization_token
    end
  end
end
