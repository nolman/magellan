require 'hpricot'
require 'open-uri'
require 'ostruct'

module Magellan
  class Explorer
    UNKNOWN_CONTENT = "unknown"
    LINKS = [["a","href"],["script","src"],["img","src"]]
    def initialize(urls)
      @links = LINKS
      @urls = urls
    end

    def explore
      reqs = []
      @urls.each do |url|
        reqs.push Thread.new { explore_a(url) }
      end
      reqs.collect { |req| req.value }
    end

    def explore_a(url)
      begin
        agent = WWW::Mechanize.new
        agent.user_agent = "Ruby/#{RUBY_VERSION}"
        doc = agent.get(url)
        destination_url = doc.uri.to_s
        status_code = doc.code
        #TODO: clean this up, this is very hacky, I would rather pass in a hpricot doc to create a result
        if doc.respond_to?(:content_type) && doc.content_type.starts_with?("text/html")
          Explorer.create_result(url, destination_url, status_code, doc.links_to_other_documents(@links),doc.content_type)
        else
          Explorer.create_result(url, destination_url, status_code, [], doc.respond_to?(:content_type) ? doc.content_type : UNKNOWN_CONTENT)
        end
      rescue WWW::Mechanize::ResponseCodeError => the_error
        Explorer.create_result(url, url, the_error.response_code, [],UNKNOWN_CONTENT)
      rescue Timeout::Error
        Explorer.create_result(url, url, "505", [],UNKNOWN_CONTENT)
      end
    end

    def self.create_result(url,destination_url,status_code,links,content_type)
      Result.new(status_code,url,destination_url,links.map{|link| link.to_s},content_type)
    end
  end
end
