namespace :dayday do
  desc "Scrape All Recipes"

  task :recipes => :environment do
    require 'open-uri'
    require 'nokogiri'

    url_list = File.open('/Users/stephenparker/workspace/daydaycookscraper/lib/tasks/urllist.txt', 'r')
    url_list.each_line do |line|
      url = line.to_s[0...-1]
      html_doc = Nokogiri::HTML(open(url).read)
      name = html_doc.css('.recipe_details_topic').text
      puts name
      imagePath = html_doc.css('#recipe_list_content > div.recipe-content-area > div.recipe-inner-content-area > div.inner-recipie1 > div.inner-recipie1-sec-1 > a.gallery_click > img').attr('src')
      puts imagePath
      ingredientsDiv = html_doc.css('#desktop_show_detail > div.inner-recipie2.ingredients > div.inner-recipie2-sec1 > div > div.block_style_1.block_style_common').map do |node|
        node.children.text do |p|
          puts p
        end
      end
      puts ingredientsDiv
      

      

      english_main_dish = {
      #   "mainDishDescription": mainDishDescription,
        "imagePath": imagePath,
        "name": name
      #   "ingredients": ingredients
      }
    end
  end
end