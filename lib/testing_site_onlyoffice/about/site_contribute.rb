# frozen_string_literal: true

module TestingSiteOnlyoffice
  # /contribute.aspx
  # https://user-images.githubusercontent.com/67409742/144370551-2c601f44-ed47-4b6b-a3f0-2c4312e09e90.png
  class SiteContribute
    include PageObject

    div(:contribute_header_backgrounds, xpath: '//div[@class="contribute_header_backgrounds"]')
    link(:ready_to_use_connectors, xpath: '//a[@class="csn_link"]')

    def initialize(instance)
      super(instance.webdriver.driver)
      @instance = instance
      wait_to_load
    end

    def wait_to_load
      @instance.webdriver.wait_until { contribute_header_backgrounds_element.present? }
    end

    def xpath_read_api_documentation(number)
      "//div[@class='cib_container'][#{number}]//a[@class='cib_link']"
    end

    def click_read_api_documentation(number)
      @instance.webdriver.driver.find_element(:xpath, xpath_read_api_documentation(number)).click
      @instance.webdriver.choose_tab(2)
    end

    def check_title_documentation_github
      @instance.webdriver.get_title_of_current_tab.include?('ONLYOFFICE · GitHub')
    end

    def check_title_documentation_community_server
      @instance.webdriver.get_title_of_current_tab.include?('ONLYOFFICE Api Documentation - Basic concepts')
    end

    def check_title_documentation_plagins
      @instance.webdriver.get_title_of_current_tab.include?('ONLYOFFICE Api Documentation - Overview')
    end

    def check_title_documentation_connectors
      ready_to_use_connectors_element.click
      @instance.webdriver.choose_tab(2)
      @instance.webdriver.get_title_of_current_tab.include?('ONLYOFFICE Api Documentation - Ready-to-use connectors')
    end
  end
end
