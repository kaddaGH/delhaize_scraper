body = Nokogiri.HTML(content)
description = body.at_css(".ShowMoreLess__content").to_s rescue ""


description = description.gsub(/^[^{]+<h3>Description<\/h3>/, '').gsub(/<h3>[^{]+\Z/, '').gsub(/<[^<>]+>/, '').gsub(/[\n\s,]+/, ' ').strip

description_second = body.at_css(".col-sm-30:contains('Description')").text.gsub(/Description/, '').gsub(/[\n\s,]+/, ' ').strip rescue ""


products_details = page['vars']['product_details']

products_details[:PRODUCT_DESCRIPTION] = description + description_second


item_size = nil
uom = nil
in_pack = nil


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
    /(\d*[\.,]?\d+)\s?([Pp][Cc])/,
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
regexps.find {|regexp| products_details[:PRODUCT_DESCRIPTION] =~ regexp}
item_size = $1
uom = $2

if item_size and uom

  products_details[:PRODUCT_ITEM_SIZE] = item_size
  products_details[:PRODUCT_ITEM_SIZE_UOM] = uom
end


match = [
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
].find {|regexp| products_details[:PRODUCT_DESCRIPTION] =~ regexp}
in_pack = $1
if in_pack

  products_details[:PRODUCT_ITEM_QTY_IN_PACK] = in_pack

end

outputs << products_details

