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

    def check_button_developer_request_demo?
      @instance.webdriver.click_on_locator("//div[@class='solutionspages_header_narrow']//a[@href='/demo-order.aspx?from=developer-edition']")
      SiteOrderDemo.new(@instance)
    end

    def check_button_spreadsheet_editing?
      @instance.webdriver.click_on_locator("//div[@class='shn_gb_item block1']//a[@href='/spreadsheet-editor.aspx?from=developer-edition']")
      SiteFeaturesSpreadsheetEditor.new(@instance)
    end

    def check_button_presentation_editing?
      @instance.webdriver.click_on_locator("//div[@class='shn_gb_item block1']//a[@href='/presentation-editor.aspx?from=developer-edition']")
      SiteFeaturesPresentationEditor.new(@instance)
    end

    def check_button_document_editing?
      @instance.webdriver.click_on_locator("//div[@class='shn_gb_item block1']//a[@href='/document-editor.aspx?from=developer-edition']")
      SiteFeaturesDocumentEditor.new(@instance)
    end

    def check_button_form_creator?
      @instance.webdriver.click_on_locator("//div[@class='shn_gb_item block1']//a[@href='/form-creator.aspx?from=developer-edition']")
      SiteFeaturesFormCreator.new(@instance)
    end

    def parse_url
      current_url = URI(@instance.webdriver.current_url)
      current_url.fragment = current_url.query = nil
      current_url.to_s
    end

    def check_button_format_compatibility?
      @instance.webdriver.click_on_locator("//a[contains(@href,'https://helpcenter.onlyoffice.com/ONLYOFFICE-Editors/ONLYOFFICE-Document-Editor/HelpfulHints/SupportedFormats.aspx')]")
      parse_url.include?('SupportedFormats')
    end

    def check_button_editing_functionality?
      @instance.webdriver.click_on_locator("//a[contains(@href,'https://api.onlyoffice.com/editors/demopreview')]")
      parse_url.include?('demopreview')
    end

    def check_button_collaborative_features?
      @instance.webdriver.click_on_locator("//a[contains(@href,'https://helpcenter.onlyoffice.com/ONLYOFFICE-Editors/ONLYOFFICE-Document-Editor/HelpfulHints/CollaborativeEditing.aspx')]")
      parse_url.include?('CollaborativeEditing')
    end

    def check_button_macros_and_plugins?
      @instance.webdriver.click_on_locator("//a[contains(@href,'https://api.onlyoffice.com/plugin/basic')]")
      parse_url.include?('api.onlyoffice.com/plugin/basic')
    end

    def check_button_cross_browser_compatibility?
      @instance.webdriver.click_on_locator("//div[@class='sfb_gb_item block9']//a[contains(@href,'/document-editor-comparison.aspx')]")
      SiteCompareSuites.new(@instance)
    end

    def check_button_supported_programming_languages?
      @instance.webdriver.click_on_locator("//a[contains(@href,'https://api.onlyoffice.com/editors/?')]")
      parse_url.include?('https://api.onlyoffice.com/editors')
    end

    def check_button_easy_deployment?
      @instance.webdriver.click_on_locator("//a[contains(@href,'/download-docs.aspx#docs-developer')]")
      SiteGetOnlyofficeDocsDeveloper.new(@instance)
    end

    def check_button_integration_api?
      @instance.webdriver.click_on_locator("//a[contains(@href,'api.onlyoffice.com/editors/basic')]")
      parse_url.include?('https://api.onlyoffice.com/editors')
    end

    def check_button_highest_security?
      @instance.webdriver.click_on_locator("//div[@class='sfb_gb_item block8']//a[contains(@href,'/security.aspx#data_protection')]")
      SiteFeaturesSecurity.new(@instance)
    end

    def check_button_wopi_support?
      @instance.webdriver.click_on_locator("//a[contains(@href,'/wopi-comparison.aspx')]")
      SiteWOPIComparison.new(@instance)
    end
  end
end
