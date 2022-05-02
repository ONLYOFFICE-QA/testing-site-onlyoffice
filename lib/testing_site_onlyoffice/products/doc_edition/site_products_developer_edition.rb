# frozen_string_literal: true

module TestingSiteOnlyoffice
  # developer-edition.aspx
  # https://user-images.githubusercontent.com/67409742/166101050-a8605bdb-d3be-4300-9376-cb57db77a93f.png
  class SiteProductsDeveloperEdition
    include PageObject

    div(:developer_edition, xpath: "//div[@class='InnerPage solutionspages developersedition']")
    link(:get_it_developer, xpath: "//div[@class='solutionspages_header_narrow']//a[contains(@href,'/download-docs.aspx')]")
    link(:request_demo, xpath: "//div[@class='solutionspages_header_narrow']//a[@href='/demo-order.aspx?from=developer-edition']")
    link(:document_editing, xpath: "//div[@class='shn_gb_item block1']//a[@href='/document-editor.aspx?from=developer-edition']")
    link(:spreadsheet_editing, xpath: "//div[@class='shn_gb_item block1']//a[@href='/spreadsheet-editor.aspx?from=developer-edition']")
    link(:presentation_editing, xpath: "//div[@class='shn_gb_item block1']//a[@href='/presentation-editor.aspx?from=developer-edition']")
    link(:form_creator, xpath: "//div[@class='shn_gb_item block1']//a[@href='/form-creator.aspx?from=developer-edition']")
    link(:format_compatibility, xpath: "//a[contains(@href,'https://helpcenter.onlyoffice.com/ONLYOFFICE-Editors/ONLYOFFICE-Document-Editor/HelpfulHints/SupportedFormats.aspx')]")
    link(:editing_functionality, xpath: "//a[contains(@href,'https://api.onlyoffice.com/editors/demopreview')]")
    link(:collaborative_features, xpath: "//a[contains(@href,'https://helpcenter.onlyoffice.com/ONLYOFFICE-Editors/ONLYOFFICE-Document-Editor/HelpfulHints/CollaborativeEditing.aspx')]")
    link(:macros_and_plugins, xpath: "//a[contains(@href,'https://api.onlyoffice.com/plugin/basic')]")
    link(:cross_browser_compatibility, xpath: "//div[@class='sfb_gb_item block9']//a[contains(@href,'/document-editor-comparison.aspx')]")
    link(:supported_programming_languages, xpath: "//a[contains(@href,'https://api.onlyoffice.com/editors/?')]")
    link(:easy_deployment, xpath: "//a[contains(@href,'/download-docs.aspx#docs-developer')]")
    link(:integration_api, xpath: "//a[contains(@href,'api.onlyoffice.com/editors/basic')]")
    link(:highest_security, xpath: "//div[@class='sfb_gb_item block8']//a[contains(@href,'/security.aspx#data_protection')]")
    link(:wopi_support, xpath: "//a[contains(@href,'/wopi-comparison.aspx')]")

    def initialize(instance)
      super(instance.webdriver.driver)
      @instance = instance
      wait_to_load
    end

    def wait_to_load
      @instance.webdriver.wait_until { @instance.webdriver.element_present?(developer_edition_element) }
    end

    def check_button_get_it_developer?
      get_it_developer_element.click
      SiteDocsDeveloper.new(@instance)
    end

    def check_button_developer_request_demo?
      request_demo_element.click
      SiteOrderDemo.new(@instance)
    end

    def check_button_spreadsheet_editing?
      spreadsheet_editing_element.click
      SiteProductsSpreadsheetEditor.new(@instance)
    end

    def check_button_presentation_editing?
      presentation_editing_element.click
      SiteProductsPresentationEditor.new(@instance)
    end

    def check_button_document_editing?
      document_editing_element.click
      SiteProductsDocumentEditor.new(@instance)
    end

    def check_button_form_creator?
      form_creator_element.click
      SiteProductsFormCreator.new(@instance)
    end

    def parse_url
      current_url = URI(@instance.webdriver.get_url)
      current_url.fragment = current_url.query = nil
      current_url.to_s
    end

    def check_button_format_compatibility?
      format_compatibility_element.click
      parse_url.include?('SupportedFormats')
    end

    def check_button_editing_functionality?
      editing_functionality_element.click
      parse_url.include?('demopreview')
    end

    def check_button_collaborative_features?
      collaborative_features_element.click
      parse_url.include?('CollaborativeEditing')
    end

    def check_button_macros_and_plugins?
      macros_and_plugins_element.click
      parse_url.include?('api.onlyoffice.com/plugin/basic')
    end

    def check_button_cross_browser_compatibility?
      cross_browser_compatibility_element.click
      SiteCompareSuites.new(@instance)
    end

    def check_button_supported_programming_languages?
      supported_programming_languages_element.click
      parse_url.include?('https://api.onlyoffice.com/editors')
    end

    def check_button_easy_deployment?
      easy_deployment_element.click
      SiteDocsDeveloper.new(@instance)
    end

    def check_button_integration_api?
      integration_api_element.click
      parse_url.include?('https://api.onlyoffice.com/editors')
    end

    def check_button_highest_security?
      highest_security_element.click
      SiteProductsSecurity.new(@instance)
    end

    def check_button_wopi_support?
      wopi_support_element.click
      SiteWOPIComparison.new(@instance)
    end
  end
end
