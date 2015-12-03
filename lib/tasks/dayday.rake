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
      # puts name
      result = html_doc.at_css('#recipe_list_content > div.recipe-content-area > div.recipe-inner-content-area > div.inner-recipie1 > div.inner-recipie1-sec-1 > a.gallery_click > img')
      if result
        puts result.attr('src')
      else
        next
      end
      imagePath = html_doc.css('#recipe_list_content > div.recipe-content-area > div.recipe-inner-content-area > div.inner-recipie1 > div.inner-recipie1-sec-1 > a.gallery_click > img').attr('src')
      ingredients = []
      ingredientsDiv = html_doc.css('#desktop_show_detail > div.inner-recipie2.ingredients > div.inner-recipie2-sec1 > div > div.block_style_1.block_style_common').map do |node|
        node.children.text do
          # ingredients.push(text.to_s)
        end
      end
      mainDishDescription = html_doc.css('#recipe_list_content > div.recipe-content-area > div.recipe-inner-content-area > div.inner-recipie1 > div.breif_desc > p').text
      ingredients = ingredientsDiv[0]
      ingredients = ingredients.split("\r\n\r\n")
      english_main_dish = {
        "mainDishDescription": mainDishDescription,
        "imagePath": imagePath.text,
        "name": name,
        "ingredients": ingredients,
        "url": url
      }

      puts english_main_dish.to_json
    end
  end
end