require 'cgi'
   
search_terms = ['Red Bull', 'RedBull', 'Energy Drink', 'Boisson Énergisante']
search_terms.take(1).each do |search_term|

  pages << {
      page_type: 'products_search',
      method: 'GET',
      url: "https://www.delhaize.be/search/products/loadMore?text=#{CGI.escape(search_term)}&pageSize=20&pageNumber=0&sort=relevance&q=#{CGI.escape(search_term)}%3Arelevance",
      vars: {
          'input_type' => 'search',
          'search_term' => search_term,
          'page' => 1
      }


  }

end