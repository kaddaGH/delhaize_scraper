require 'cgi'
    pages << {
    page_type: 'products_search',
    method: 'GET',
    url: "https://www.delhaize.be/fr-be/shop/Boissons-et-alcools/Boissons-energisantes/c/v2DRIENE/loadMore?q=%3Apopularity&sort=popularity&pageSize=12&pageNumber=0",
    vars: {
        'input_type' => 'taxonomy',
        'search_term' => '-',
        'page' => 1
    }


}
search_terms = ['Red Bull', 'RedBull', 'Energidryck', 'Energidrycker']
search_terms.each do |search_term|

  pages << {
      page_type: 'products_search',
      method: 'GET',
      url: "https://www.delhaize.be/search/products/loadMore?text=red+bull&pageSize=20&pageNumber=0&sort=relevance&q=red+bull%3Arelevance",
      vars: {
          'input_type' => 'search',
          'search_term' => search_term,
          'page' => 1
      }


  }

end