data = JSON.parse(content)
product_details = page['vars']['product_details']
product_details['PRODUCT_STAR_RATING'] = data["rating"].to_f>0?data["rating"]:""
product_details['PRODUCT_NBR_OF_REVIEWS'] = data["reviewCount"]
product_details['_collection'] = 'products'
product_details['EXTRACTED_ON']= Time.now.to_s
outputs << product_details



