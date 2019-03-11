data = JSON.parse(content)




scrape_url_nbr_products = data['pagination']['totalNumberOfResults'].to_i
current_page = data['pagination']['currentPage'].to_i
number_of_pages = data['pagination']['numberOfPages'].to_i
products = data['results']


# if ot's first page , generate pagination
if current_page == 0 and number_of_pages > 1
  nbr_products_pg1 = products.length
  step_page = 1
  while step_page < number_of_pages
    pages << {
        page_type: 'products_search',
        method: 'GET',
        url: page['url'].gsub(/pageNumber=0/, "pageNumber=#{step_page}"),
        vars: {
            'input_type' => page['vars']['input_type'],
            'search_term' => page['vars']['search_term'],
            'page' => step_page,
            'nbr_products_pg1' => nbr_products_pg1
        }
    }

    step_page = step_page + 1


  end
elsif current_page == 0 and number_of_pages == 1
  nbr_products_pg1 = products.length
else
 nbr_products_pg1 = page['vars']['nbr_products_pg1']
end


products.each_with_index do |product, i|

  promotion = product['potentialPromotions'][0]['description'] rescue ''

  availability = product['stock']['inStock']== true ? '1' : ''
  item_size_info = product['price']['supplementaryPriceLabel2'].gsub(/,/,'.')

  price = product['price']['value'] rescue ''


  regexps = [
      /(\d*[\.,]?\d+)\s?([Ff][Ll]\.?\s?[Oo][Zz])/,
      /(\d*[\.,]?\d+)\s?([Oo][Zz])/,
      /(\d*[\.,]?\d+)\s?([Ff][Oo])/,
      /(\d*[\.,]?\d+)\s?([Ee][Aa])/,
      /(\d*[\.,]?\d+)\s?([Ff][Zz])/,
      /(\d*[\.,]?\d+)\s?(Fluid Ounces?)/,
      /(\d*[\.,]?\d+)\s?([Oo]unce)/,
      /(\d*[\.,]?\d+)\s?([Mm][Ll])/,
      /(\d*[\.,]?\d+)\s?([Cc][Ll])/,
      /(\d*[\.,]?\d+)\s?([Ll])/,
      /(\d*[\.,]?\d+)\s?([Gg])/,
      /(\d*[\.,]?\d+)\s?([Ll]itre)/,
      /(\d*[\.,]?\d+)\s?([Ss]ervings)/,
      /(\d*[\.,]?\d+)\s?([Pp]acket\(?s?\)?)/,
      /(\d*[\.,]?\d+)\s?([Cc]apsules)/,
      /(\d*[\.,]?\d+)\s?([Tt]ablets)/,
      /(\d*[\.,]?\d+)\s?([Tt]ubes)/,
      /(\d*[\.,]?\d+)\s?([Cc]hews)/,
      /(\d*[\.,]?\d+)\s?([Mm]illiliter)/i,
  ]
  regexps.find {|regexp| item_size_info =~ regexp}
  item_size = $1
  uom = $2


  regexps = [
      /(\d+)\s?[xX]/,
      /Pack of (\d+)/,
      /Box of (\d+)/,
      /Case of (\d+)/,
      /(\d+)\s?[Cc]ount/,
      /(\d+)\s?[Cc][Tt]/,
      /(\d+)[\s-]?Pack($|[^e])/,
      /(\d+)[\s-]pack($|[^e])/,
      /(\d+)[\s-]?[Pp]ak($|[^e])/,
      /(\d+)[\s-]?Tray/,
      /(\d+)\s?[Pp][Kk]/,
      /(\d+)\s?([Ss]tuks)/i,
      /(\d+)\s?([Pp]ak)/i,
      /(\d+)\s?([Pp]ack)/i,
  ]
  regexps.find {|regexp| item_size_info =~ regexp}
  in_pack = $1
  in_pack ||= '1'
  ean = product['eanCodes'][0] rescue ''

  product_details = {
      # - - - - - - - - - - -
      RETAILER_ID: '128',
      RETAILER_NAME: 'delhaize',
      GEOGRAPHY_NAME: 'BE',
      # - - - - - - - - - - -
      SCRAPE_INPUT_TYPE: page['vars']['input_type'],
      SCRAPE_INPUT_SEARCH_TERM: page['vars']['search_term'],
      SCRAPE_INPUT_CATEGORY: page['vars']['input_type'] == 'taxonomy' ? 'Boissons energisantes': '-',
      SCRAPE_URL_NBR_PRODUCTS: scrape_url_nbr_products,
      # - - - - - - - - - - -
      SCRAPE_URL_NBR_PROD_PG1: nbr_products_pg1,
      # - - - - - - - - - - -
      PRODUCT_BRAND: product['manufacturerName'],
      PRODUCT_RANK: i + 1,
      PRODUCT_PAGE: current_page + 1,
      PRODUCT_ID: product['code'],
      PRODUCT_NAME: product['manufacturerName']+' - '+product['name'],
      EAN: ean,
      PRODUCT_DESCRIPTION: product['description'],
      PRODUCT_MAIN_IMAGE_URL: 'https://dhf6qt42idbhy.cloudfront.net'+product['thumbnailImage'],
      PRODUCT_ITEM_SIZE: item_size,
      PRODUCT_ITEM_SIZE_UOM: uom,
      PRODUCT_ITEM_QTY_IN_PACK: in_pack,
      SALES_PRICE: price,
      IS_AVAILABLE: availability,
      PROMOTION_TEXT: promotion,
  }
  product_details['_collection'] = 'products'
  product_details['EXTRACTED_ON']= Time.now.to_s
  outputs << product_details


end

