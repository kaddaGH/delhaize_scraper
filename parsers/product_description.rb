body = Nokogiri.HTML(content)
description = body.at_css(".ShowMoreLess__content").text rescue ''

description = description.gsub(/Conseils d[^<]+\Z/,'').gsub(/^[^<]+Description/,'').strip

products_details = page['vars']['product_details']

products_details[:PRODUCT_DESCRIPTION]=description

outputs<<products_details

