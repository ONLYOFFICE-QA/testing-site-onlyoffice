# frozen_string_literal: true

module TestingSiteOnlyoffice
  # search field for /whitepapers.aspx and /training-courses.aspx pages
  # https://user-images.githubusercontent.com/40513035/125728126-ee25c498-ff57-4a39-9d52-f18235e57a70.png
  module SiteAboutSearch
    include PageObject

    text_field(:search_field, xpath: "//input[@id='ad-search-input']")

    def about_search(string)
      @instance.webdriver.type_text(search_field_element.selector[:xpath], "#{string}\n")
      sleep 1 # wait for search to end
    end
  end
end
