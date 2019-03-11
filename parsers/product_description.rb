body = Nokogiri.HTML(content)
description = body.at_css(".ShowMoreLess__content").to_s rescue ''


description = description.gsub(/^[^{]+<h3>Description<\/h3>/,'').gsub(/<h3>[^{]+\Z/,'').gsub(/<[^<>]+>/,'').gsub(/[\n\s,]/,' ').strip
products_details = page['vars']['product_details']

products_details[:PRODUCT_DESCRIPTION]=description

outputs<<products_details

