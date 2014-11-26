module OkCupid
  class Message < OkCupid::Resource
    # Public:
    #
    # Determines the threadid of the message. Can be used to find the entire
    # message thread.
    #
    # Only availble when retrieving messages using `api.messages`.
    #
    # Returns a string.
    def threadid
      @doc.attributes['data-threadid'].value
    rescue
    end

    # Public:
    #
    # Determines the username of the author.
    #
    # Always available.
    #
    # Returns a string.
    def author
      @doc.
        css("img[alt^='An image of']").
        map { |img| img.attributes['alt'].value.scan(/^An image of (.*)/) }.
        flatten.
        compact.
        uniq.
        first
    rescue
    end

    # Public:
    #
    # Determines the time the message was sent.
    #
    # Always available.
    #
    # Returns a UNIX timestamp in integer form.
    def timestamp
      @doc.
        css('.timestamp script').
        first.
        to_s.
        scan(/^.*, (\d+),.*$/).
        flatten.
        compact.
        uniq.
        map(&:to_i).
        first
    rescue
    end

    # Public:
    #
    # Determines if the message was sent from a mobile application.
    #
    # Only available when retrieving messages using `api.thread(threadid)`.
    #
    # Returns true/false.
    def from_mobile
      !!@doc.
        css('.message_description').
        first.
        attributes['class'].
	to_s.
        scan(/from_mobile/).
        flatten.
        compact.
        uniq.
        first
    rescue
      false
    end

    # Public:
    #
    # Determines if the message has been read yet.
    #
    # Only available when retrieving messages using `api.thread(threadid)`.
    #
    # Returns true/false.
    def message_read
      !!@doc.
        css('.message_description').
        first.
        attributes['class'].
        to_s.
        scan(/message_read/).
        flatten.
        compact.
        uniq.
        first
    rescue
      false
    end

    # Public:
    #
    # Determines the photo_url of the message author.
    #
    # Always available.
    #
    # Returns a string or nil.
    def photo_url
      @doc.
        css('.photo img').
        first.
        attributes['src'].
        to_s
    rescue
    end
  end
end
