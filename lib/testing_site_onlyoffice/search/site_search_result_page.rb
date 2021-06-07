# frozen_string_literal: true

require_relative '../site_home_page'
require_relative 'search_result_item'

module TestingSiteOnlyoffice
  # /search.aspx
  # https://user-images.githubusercontent.com/40513035/116189519-eaab2500-a6dd-11eb-8cc7-7af755bb1719.png
  class SiteSearchResultPage
    include PageObject

    list_item(:search_result_entry, xpath: "//li[@class='searchItem']")

    # result not found
    no_result_xpath = "//div[@class='noResults']"
    div(:no_result_found, xpath: no_result_xpath)
    link(:main_page, xpath: "#{no_result_xpath}/a")

    def initialize(instance)
      super(instance.webdriver.driver)
      @instance = instance
      wait_to_load
    end

    def wait_to_load
      @instance.webdriver.wait_until do
        no_result_found_element.present? || search_result_entry_element.present?
      end
    end

    # @return [Integer] found entries count
    def search_result_count
      return 0 if no_result_found_element.present?

      @instance.webdriver.driver.find_elements(:xpath, search_result_entry_element.selector[:xpath]).count
    end

    def go_to_main_page
      main_page_element.click
      SiteHomePage.new(@instance)
    end

    # @return [Array] of search results
    def search_results
      results_array = []
      search_result_count.times { |index| results_array << SiteResultItem.new(@instance, index + 1) }
      results_array
    end
  end
end
