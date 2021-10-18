require 'nokogiri'
require 'open-uri'
require_relative 'recipe'

class ScrapeAllrecipesService
  def initialize(ingredient)
    @ingredient = ingredient
  end

  # should return an array of INSTANCES
  def call
    # file = File.join(__dir__, 'donut.html')  # or 'strawberry.html'
    url = "https://www.allrecipes.com/search/results/?search=#{@ingredient}"
    html = URI.open(url).read
    doc = Nokogiri::HTML(html, nil, 'utf-8')
    doc.search('.card__detailsContainer').first(5).map do |card_element|
      name = card_element.search('.card__title').text.strip
      description = card_element.search('.card__summary').text.strip
      rating = card_element.search('.rating-star.active').count
      url = card_element.search('.card__titleLink').attribute('href').value
      prep_time = fetch_prep_time(url)
      Recipe.new(
        name: name,
        description: description,
        rating: rating,
        prep_time: prep_time
      )
    end
  end

  def fetch_prep_time(url)
    html = URI.open(url).read
    doc = Nokogiri::HTML(html, nil, 'utf-8')
    doc.search('.recipe-meta-item-body').first.text.strip
  end
end
