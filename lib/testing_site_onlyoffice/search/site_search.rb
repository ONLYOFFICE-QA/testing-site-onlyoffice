# frozen_string_literal: true

require_relative 'site_search_result_page'

module TestingSiteOnlyoffice
  # Search field
  # https://user-images.githubusercontent.com/40513035/116186728-1081fb00-a6d9-11eb-9fc6-522830d6987f.png
  module SiteSearch
    include PageObject

    div(:search_icon, xpath: "//div[@id='search-button']")
    text_field(:search_field, xpath: "//input[@id='search-input']")
    div(:close_search, xpath: "//div[@id='close-button']")

    def search_field_opened?
      @instance.webdriver.element_present?(search_field_element)
    end

    def open_search_field
      search_icon_element.click
      @instance.webdriver.wait_until { search_field_opened? }
    end

    # Perform search by string
    # @param [String] string to find
    # @return [SearchResultPage] page with result
    def search(string)
      open_search_field unless search_field_opened?
      @instance.webdriver.type_text(search_field_element.selector[:xpath], "#{string}\n")
      SiteSearchResultPage.new(@instance)
    end
  end
end
