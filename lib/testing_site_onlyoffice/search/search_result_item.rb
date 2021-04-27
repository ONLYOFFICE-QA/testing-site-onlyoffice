# Constructor for site search results
# https://user-images.githubusercontent.com/40513035/116211956-39b28380-a6f9-11eb-8b4d-ad81fd7f62d9.png

module TestingSiteOnlyoffice
  class SiteResultItem
    attr_accessor :title_xpath, :snippet_xpath

    include PageObject

    def initialize(instance, index)
      super(instance.webdriver.driver)
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
