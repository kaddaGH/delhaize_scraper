body = Nokogiri.HTML(content)
description = body.at_css(".ShowMoreLess__content").to_s rescue ''


description = description.gsub(/^[^{]+<h3>Description<\/h3>/,'').gsub(/<h3>[^{]+\Z/,'').gsub(/<[^<>]+>/,'').gsub(/[\n\s,]+/,' ').strip

description_second=body.at_css(".col-sm-30:contains('Description')").text.gsub(/Description/,'').gsub(/[\n\s,]+/,' ').strip rescue ()


products_details = page['vars']['product_details']

products_details[:PRODUCT_DESCRIPTION]=description+description_second

outputs<<products_details

