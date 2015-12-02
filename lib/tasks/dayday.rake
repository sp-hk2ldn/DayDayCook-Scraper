namespace :dayday do
  desc "Scrape All Recipes"

  task :recipes => :environment do
    require 'open-uri'
    require 'nokogiri'

    url_list = File.open('/Users/stephenparker/workspace/daydaycookscraper/lib/tasks/urllist.txt', 'r')
    url_list.each_line do |line|
      url = line.to_s[0...-1]
      html_doc = Nokogiri::HTML(open(url).read)
      dish_name = html_doc.css('.recipe_details_topic')
      puts dish_name
    end
  end
end