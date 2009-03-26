require 'open-uri'
require 'spec_helper'
require 'magellan'
def async_request_urls(urls = [])
  reqs = []
  urls.each do |url|
    reqs << Thread.new { open(url) }
  end
  reqs.collect { |req| req.value }
end

def sync_request_urls(urls)
  urls.map {|url| open(url)}
end

#urls = [ 'http://www.blahr.com/', 'http://www.news.com/','http://www.news.com/','http://www.news.com/','http://www.google.com','http://www.google.com' ,'http://www.google.com' ,'http://www.google.com'  ]
#responses = sync_request_urls  urls

#puts urls.size
#puts responses.size
urls = ["http://studios.thoughtworks.com/mingle/movies/Mingle-Excel-Import.swf","http://studios.thoughtworks.com/mingle-videos2/plv_hd.swf","http://studios.thoughtworks.com/images/collab.png","http://studios.thoughtworks.com/images/card_trees_video.png","http://studios.thoughtworks.com/images/plv_hd.png","http://studios.thoughtworks.com/2008/10/21/announcing-mingle2-1","http://studios.thoughtworks.com/2008/9/29/announcing-the-twist-public-beta","http://studios.thoughtworks.com/2008/7/30/mingle-automated-testing-and-cruise","http://studios.thoughtworks.com/2008/7/28/announcing-cruise-continuous-integration-and-release-management-system","http://studios.thoughtworks.com/2008/9/29/announcing-the-twist-public-beta#comment-1445","http://studios.thoughtworks.com/2008/9/29/announcing-the-twist-public-beta#comment-1439","http://studios.thoughtworks.com/2008/10/21/announcing-mingle2-1#comment-1427","http://studios.thoughtworks.com/2008/7/28/announcing-cruise-continuous-integration-and-release-management-system#comment-1424","http://studios.thoughtworks.com/2008/7/28/announcing-cruise-continuous-integration-and-release-management-system#comment-1421","http://studios.thoughtworks.com/tags/Card%20Trees","http://studios.thoughtworks.com/tags/metrics","http://studios.thoughtworks.com/tags/Mingle","http://studios.thoughtworks.com/tags/Story%20Trees","http://studios.thoughtworks.com/2008/2/19/forest-for-the-trees/comments.xml","http://studios.thoughtworks.com/images/blogheadimg2.gif","http://studios.thoughtworks.com/images/trees-blog3.jpg","http://studios.thoughtworks.com/images/trees-blog2.jpg","http://studios.thoughtworks.com/images/trees-blog1.jpg","http://studios.thoughtworks.com/images/button1-share.gif","http://studios.thoughtworks.com/mingle-videos/swfobject.js","http://studios.thoughtworks.com/mingle-videos2/swfobject.js","http://studios.thoughtworks.com/download_files/Ross_Niemi_Case_Study.pdf","http://studios.thoughtworks.com/images/world.png","http://studios.thoughtworks.com/images/card-wall-casestudy.png","http://studios.thoughtworks.com/images/project-burn-up.png","http://studios.thoughtworks.com/images/velocity.png","http://studios.thoughtworks.com/cruise-continuous-integration/quick-tour","http://studios.thoughtworks.com/cruise-continuous-integration/cruise-over-cc","http://studios.thoughtworks.com/cruise-continuous-integration/features-and-benefits","http://studios.thoughtworks.com/cruise-continuous-integration/cruise-pricing-and-license","http://studios.thoughtworks.com/cruise-continuous-integration/multi-platform-testing","http://studios.thoughtworks.com/cruise-continuous-integration/dependency-management","http://studios.thoughtworks.com/cruise-continuous-integration/continuous-integration","http://studios.thoughtworks.com/cruise-continuous-integration/download-agent"]
urls.each do |url|
  puts "doing #{url}"
  cartographer = Magellan::Cartographer.new(url,1)
  broken_link_tracker = Magellan::BrokenLinkTracker.new
  cartographer.add_observer(broken_link_tracker)
  cartographer.crawl
  if broken_link_tracker.has_broken_links?
    STDERR.puts broken_link_tracker.failure_message
  end
end