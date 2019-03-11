require 'cgi'

headers={


    "Accept"=>"text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8",
"Accept-Encoding"=>"gzip, deflate, br",
"Accept-Language"=>"fr-FR,fr;q=0.9,en-US;q=0.8,en;q=0.7,de-DE;q=0.6,de;q=0.5",
"Cache-Control"=>"max-age=0",
"Connection"=>"keep-alive",
"Host"=>"www.delhaize.be",
    "Cookie"=>"groceryCookieLang=fr; check=true; AMCVS_2A6E210654E74B040A4C98A7%40AdobeOrg=1; s_fid=62434616E0288EA4-08B824D712546CFA; s_cc=true; _fbp=fb.1.1552123960237.459045766; sto__vuid=2b44ccf374c5f7189292e43d674fd9d5; JSESSIONID=FC30BB4A0FBB45916F48C8C19332730B.app3; AWSELB=7B231BFB08BC6471BF1FBE7264CCA19489D056752AEB0E05EC2C0FCF33A56504AD884E7825589601412E99F741BC7A941EAA1AC34EAEF4D55422A9CBB4C3FF2B75F43E90DCA31D16F4508DE8B0E58FCF5326D4D463; AMCV_2A6E210654E74B040A4C98A7%40AdobeOrg=1994364360%7CMCIDTS%7C17967%7CMCMID%7C65352667588721177441656304089964163143%7CMCAAMLH-1552904451%7C6%7CMCAAMB-1552904451%7CRKhpRz8krg2tLO6pguXWp5olkAcUniQYPHaMWWgdJ3xzPWQmdj0y%7CMCOPTOUT-1552306851s%7CNONE%7CMCAID%7CNONE%7CvVersion%7C3.4.0; mboxEdgeCluster=26; sto__session=1552303780225; recentlyViewedCookie=S2016052003651050000|S2014111908880910000|S2017082500195850097; mbox=PC#d88df9aed36b4af29ad4c42c408870a4.26_27#1615548579|session#a88d7b78fb6e4491aa76d0284095a088#1552308141; s_ppn=search%3Aproduct%20search%20page; s_sq=%5B%5BB%5D%5D; sto__count=6",
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