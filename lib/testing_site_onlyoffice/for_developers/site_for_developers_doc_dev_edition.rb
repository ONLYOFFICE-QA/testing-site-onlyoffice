# frozen_string_literal: true

module TestingSiteOnlyoffice
  # developer-edition.aspx
  # https://user-images.githubusercontent.com/67409742/166101050-a8605bdb-d3be-4300-9376-cb57db77a93f.png
  class SiteForDevelopersDocDevEdition
    include PageObject
    def initialize(instance)
      super(instance.webdriver.driver)
      @instance = instance
      wait_to_load
    end

    def wait_to_load
      @instance.webdriver.wait_until { @instance.webdriver.element_present?("//div[@class='InnerPage solutionspages developersedition']") }
    end

    def check_button_get_it_developer?
      @instance.webdriver.click_on_locator("//div[@class='solutionspages_header_narrow']//a[contains(@href,'/download-docs.aspx')]")
      SiteGetOnlyofficeDocsDeveloper.new(@instance)
    end

    def check_button_developer_see_in_action?
      @instance.webdriver.click_on_locator("//div[@class='solutionspages_header_narrow']//a[@href='/see-it-in-action.aspx']")
      SiteFeaturesSeeItInAction.new(@instance)
    end

    def parse_url
      current_url = URI(@instance.webdriver.current_url)
      current_url.fragment = current_url.query = nil
      current_url.to_s
    end

    def check_button_macros_and_plugins?
      @instance.webdriver.click_on_locator("//a[contains(@href,'https://api.onlyoffice.com/plugin/basic')]")
      parse_url.include?('api.onlyoffice.com/plugin/basic')
    end

    def check_button_cross_browser_compatibility?
      @instance.webdriver.click_on_locator("//div[@class='sfb_gb_item block2']//a[contains(@href,'/document-editor-comparison.aspx')]")
      SiteCompareSuites.new(@instance)
    end

    def check_button_easy_deployment?
      @instance.webdriver.click_on_locator("//a[contains(@href,'/download-docs.aspx') and text() = 'Try now for free']")
      SiteGetOnlyofficeDocsDeveloper.new(@instance)
    end

    def check_button_integration_api?
      @instance.webdriver.click_on_locator("//a[contains(@href,'api.onlyoffice.com/editors/plugins')]")
      @instance.webdriver.choose_tab(2)
      parse_url.include?('api.onlyoffice.com/editors/plugins')
    end

    def check_button_wopi_support?
      @instance.webdriver.click_on_locator("//a[contains(@href,'/wopi-comparison.aspx')]")
      SiteWOPIComparison.new(@instance)
    end
  end
end
