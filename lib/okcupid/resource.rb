module OkCupid
  class Resource
    def initialize doc
      @doc = doc
    end

    private

    def method_missing method, *args, &block
      @doc.css(".#{method}").text
    end
  end
end
