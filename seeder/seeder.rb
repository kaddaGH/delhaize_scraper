require 'cgi'
require './lib/headers'



search_terms = ['RedBull']
search_terms.each do |search_term|

  pages << {
      page_type: 'products_search',
      method: 'GET',
      headers: ReqHeaders::SEARCH_PAGE_HEADER_REQ,
      url: "https://www.delhaize.be/search/products/loadMore?text=#{CGI.escape(search_term)}&pageSize=20&pageNumber=55&sort=relevance&q=#{CGI.escape(search_term)}%3Arelevance",
      vars: {
          'input_type' => 'search',
          'search_term' => search_term,
          'page' => 1
      }


  }

end