module OkCupid
  class Message < OkCupid::Resource
    CSS_SELECTOR = '[id^=message_]'

    def threadid
      @doc.attributes['data-threadid'].value
    end
  end
end
