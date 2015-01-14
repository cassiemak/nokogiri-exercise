namespace :scrape do
  # this is a description of your task
  desc "Scrape Google Finance Fundatmentals"

  # this is your task function
  task :google_finance => :environment do
    # do something
    require 'open-uri'
    require 'nokogiri'

    all_companies = Company.all 
    all_companies.each do |company|

    end

    url = "https://www.google.com/finance?q={company.symbol}&fstype=ii"
    document = open(url).read
    # puts document

    html_doc = Nokogiri::HTML(document)

    # dataStructure = "div.id-incinterimdiv > table.gf-table.rgt > tbody > tr > td.lft.lm"
    # row_names = html_doc.css(dataStructure).text()
    # puts row_names


    incomedataStructure = "div.id-incannualdiv > table.gf-table.rgt > tbody > tr > td:nth-child(2).r"

    sept2014927 = html_doc.css(incomedataStructure).text()

    puts sept2014927

  end

  desc "Scrape companies"
  task :csv_getCompanyname => :environment do 
    
    require 'open-uri'
    require 'csv'

    url = "http://s3.amazonaws.com/nvest/nasdaq_09_11_2014.csv"

    url_data = open(url)

    CSV.foreach(url_data) do |symbol, name|
      puts "#{name}: #{symbol}"
      Company.create(:name => name, :symbol => symbol)
    end
  end

  desc "Scrape BTBs"
  task :scrape_babyproducts => :environment do
  
    require 'open-uri'
    require 'nokogiri'


    #loop throught all the product page and repeat below

    (0..1000).each do |data_id|
      input_data(data_id)
      puts data_id
    end
  #:scrape_babyproducts
  end

    def input_data(data_id)
      url = "http://www.bumpstobabes.com/index.php/ProductDetail.html?id=#{data_id}"
      document = open(url).read

      html_doc = Nokogiri::HTML(document)

      dataStructure_details = "body > div > div:nth-child(4) > div > p:nth-child(2n+1)"
      dataStructure_pix = "body > div > div > div > img"
      dataStructure_name = "body > div > div:nth-child(4) > p"

      details = html_doc.css(dataStructure_details)
      puts details

      if not details.any?
        return
      end

      details_pix = html_doc.css(dataStructure_pix)[0]['src']
      details_name = html_doc.css(dataStructure_name)[0].text

      new_product = Product.new
      new_product.name = details_name
      new_product.img_url = "http://www.bumpstobabes.com/#{details_pix}"
      new_product.details = details[0].text
      new_product.save 

    #function input_data
    end

#namespace
end




