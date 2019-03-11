require 'cgi'

headers={


    "Accept"=>"text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8",
"Accept-Encoding"=>"gzip, deflate, br",
"Accept-Language"=>"fr-FR,fr;q=0.9,en-US;q=0.8,en;q=0.7,de-DE;q=0.6,de;q=0.5",
"Cache-Control"=>"max-age=0",
"Connection"=>"keep-alive",
"Host"=>"www.delhaize.be",
"Upgrade-Insecure-Requests"=>"1",
"User-Agent"=>"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/72.0.3626.121 Safari/537.36",

}

search_terms = ['Red Bull', 'RedBull', 'Energy Drink', 'Boisson Énergisante']
search_terms.take(1).each do |search_term|

  pages << {
      page_type: 'products_search',
      method: 'GET',
      headers:headers,
      url: "https://www.delhaize.be/search/products/loadMore?text=#{CGI.escape(search_term)}&pageSize=20&pageNumber=0&sort=relevance&q=#{CGI.escape(search_term)}%3Arelevance",
      vars: {
          'input_type' => 'search',
          'search_term' => search_term,
          'page' => 1
      }


  }

end