# frozen_string_literal: true

module TestingSiteOnlyoffice
  # Single item in search result
  # https://user-images.githubusercontent.com/40513035/116211956-39b28380-a6f9-11eb-8b4d-ad81fd7f62d9.png
  class SiteResultItem
    def initialize(instance, index)
      @instance = instance
      @title_xpath = "(//h2[@class='serachTitle'])[#{index}]"
      @snippet_xpath = "(//p[@class='searchSnippet'])[#{index}]"
    end

    def snippet_text
      @instance.webdriver.get_element(@snippet_xpath).text
    end

    def click_search_title
      @instance.webdriver.get_element(@title_xpath).click
    end
  end
end
