class FireEagle
  class Response

    attr_reader :users

    #Parses the XML response from FireEagle
    def initialize(doc)
      doc = Hpricot(doc) unless doc.is_a?(Hpricot::Doc || Hpricot::Elem)
      @doc = doc
      raise FireEagle::FireEagleException, @doc.at("/rsp/err").attributes["msg"] if !success? 
      @users = doc.search("/rsp/user").map do |user|
        FireEagle::User.new(user.to_s)
      end
    end

    #does the response indicate success?
    def success?
      @doc.at("/rsp").attributes["stat"] == "ok"
    end

  end
end