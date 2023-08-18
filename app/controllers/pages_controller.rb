require 'open-uri'
require 'nokogiri'

class PagesController < ApplicationController

  def scrape
    return if params[:wikipedia_link].blank?

    wikipedia_url = params[:wikipedia_link]

    # Perform basic validation to ensure it's a Wikipedia article URL
    if wikipedia_url =~ %r{\Ahttps?://([a-z]+)\.wikipedia\.org/wiki/}
      # Scrape the contents of the Wikipedia link
      document = Nokogiri::HTML(URI.open(wikipedia_url))

      # Extract the title of the article
      @title = document.css('h1#firstHeading').text

      # Extract the languages in which the article is available
      @languages = document.css('li.interlanguage-link a').map { |lang| lang.text }

      # Store the relevant data in a suitable data structure
      @data = {
        title: @title,
        languages: @languages
      }
    else
      flash.now[:error] = 'Invalid Wikipedia link!'
    end
  end
end
