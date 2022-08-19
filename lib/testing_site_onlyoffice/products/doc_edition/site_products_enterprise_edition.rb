# frozen_string_literal: true

module TestingSiteOnlyoffice
  # docs-enterprise.aspx?from=docs-enterprise-prices
  # https://user-images.githubusercontent.com/67409742/142990092-032280ef-b02f-4329-8fc8-78328ebd654f.png
  class SiteProductsEnterpriseEdition
    include PageObject

    div(:enterprise_edition, xpath: "//div[@id='forenterprises']")
    link(:get_it, xpath: "//div[@class='fe_header_text']//a[@href='/download-docs.aspx']")
    link(:request_demo, xpath: "//div[@class='fe_header_text']//a[@href='/demo-order.aspx?from=docs-enterprise']")
    link(:document_editing, xpath: "//div[@class='fe_cards']//a[@href='/document-editor.aspx']")
    link(:spreadsheet_editing, xpath: "//div[@class='fe_cards']//a[@href='/spreadsheet-editor.aspx']")
    link(:presentation_editing, xpath: "//div[@class='fe_cards']//a[@href='/presentation-editor.aspx']")
    link(:form_creator, xpath: "//div[@class='fe_cards']//a[@href='/form-creator.aspx']")
    link(:desktop_apps, xpath: "//div[@class='fe_tools']//a[@href='/download-desktop.aspx#desktop']")
    link(:mobile_apps, xpath: "//div[@class='fe_tools']//a[@href='/download-desktop.aspx#mobile']")
    link(:self_hosted, xpath: "//div[@class='choice_btn']//a[@href='/download-docs.aspx']")
    link(:amazon, xpath: "//div[@class='choice_btn']//a[contains(@href,'amazon')]")
    link(:univention, xpath: "//div[@class='choice_btn']//a[contains(@href,'univention')]")
    link(:all_connectors, xpath: "//div[@class='fec_text']//a[contains(@href,'/all-connectors.aspx')]")

    def initialize(instance)
      super(instance.webdriver.driver)
      @instance = instance
      wait_to_load
    end

    def wait_to_load
      @instance.webdriver.wait_until { @instance.webdriver.element_present?(enterprise_edition_element) }
    end

    def check_button_get_it_now?
      get_it_element.click
      SiteDocsEnterprise.new(@instance)
    end

    def check_button_request_demo?
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

    def check_button_desktop_apps?
      desktop_apps_element.click
      SiteDesktopApps.new(@instance)
    end

    def check_button_mobile_apps?
      mobile_apps_element.click
      SiteMobileApps.new(@instance)
    end

    def check_button_all_connectors?
      all_connectors_element.click
      SiteProductsConnectorsOnlyoffice.new(@instance)
    end

    def check_button_self_hosted?
      self_hosted_element.click
      SiteDocsEnterprise.new(@instance)
    end

    def check_link_business_platform?(section)
      attribute = @instance.webdriver.get_attribute(move_to_business_platform[section][:element], 'href')
      @instance.webdriver.click_on_locator(move_to_business_platform[section][:element])
      @instance.webdriver.switch_to_popup
      attribute.include?(parse_url)
    end

    def parse_url
      current_url = URI(@instance.webdriver.current_url)
      current_url.fragment = current_url.query = nil
      current_url.to_s
    end

    def move_to_business_platform
      {
        amazon: {
          element: amazon_element
        },
        univention: {
          element: univention_element
        }
      }
    end
  end
end
