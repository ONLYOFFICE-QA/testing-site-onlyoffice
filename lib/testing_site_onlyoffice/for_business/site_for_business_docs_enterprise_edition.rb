# frozen_string_literal: true

require_relative '../features/site_features_see_it_in_action'
require_relative '../features/docs/site_features_document_editor'
require_relative '../features/docs/site_features_spreadsheet_editor'
require_relative '../features/docs/site_features_form_creator'
require_relative '../features/docs/site_features_presentation_editor'
require_relative '../get_onlyoffice/site_get_onlyoffice_docs_registration'

module TestingSiteOnlyoffice
  # /docs-enterprise.aspx
  # https://user-images.githubusercontent.com/67409742/142990092-032280ef-b02f-4329-8fc8-78328ebd654f.png
  class SiteForBusinessDocsEnterpriseEdition
    include PageObject

    div(:enterprise_edition, xpath: "//div[@id='forenterprises']")
    link(:get_it_now, xpath: "//div[@class='fe_header_text']//a[@href='/download-docs.aspx']")
    link(:see_it_in_action, xpath: '//a[contains(@href, "/see-it-in-action.aspx?from=docs-enterprise")]')
    link(:document_editing, xpath: "//div[@class='fe_cards']//a[@href='/document-editor.aspx']")
    link(:spreadsheet_editing, xpath: "//div[@class='fe_cards']//a[@href='/spreadsheet-editor.aspx']")
    link(:presentation_editing, xpath: "//div[@class='fe_cards']//a[@href='/presentation-editor.aspx']")
    link(:form_creator, xpath: "//div[@class='fe_cards']//a[@href='/form-creator.aspx']")
    link(:desktop_apps, xpath: "//div[@class='fe_tools']//a[@href='/download-desktop.aspx#desktop']")
    link(:mobile_apps, xpath: "//div[@class='fe_tools']//a[@href='/download-desktop.aspx#mobile']")
    link(:self_hosted, xpath: "//div[@class='choice_btn']//a[@href='/download-docs.aspx']")
    link(:amazon, xpath: "//div[@class='choice_btn']//a[contains(@href,'amazon')]")
    link(:docs_registration, xpath: "//div[@class='choice_btn']//a[contains(@href,'docs-registration')]")
    link(:all_connectors, xpath: "//div[@class='fec_text']//a[contains(@href,'/all-connectors.aspx')]")

    def initialize(instance)
      super(instance.webdriver.driver)
      @instance = instance
      wait_to_load
    end

    def wait_to_load
      @instance.webdriver.wait_until { @instance.webdriver.element_present?(enterprise_edition_element) }
    end

    button_classes = {
      get_it_now: SiteGetOnlyofficeDocsEnterprise,
      see_it_in_action: SiteFeaturesSeeItInAction,
      document_editing: SiteFeaturesDocumentEditor,
      spreadsheet_editing: SiteFeaturesSpreadsheetEditor,
      presentation_editing: SiteFeaturesPresentationEditor,
      form_creator: SiteFeaturesFormCreator,
      desktop_apps: SiteGetOnlyofficeDesktopApps,
      mobile_apps: SiteMobileApps,
      self_hosted: SiteGetOnlyofficeDocsEnterprise,
      all_connectors: SiteFeaturesConnectorsOnlyoffice,
      docs_registration: SiteGetOnlyofficeDocsRegistration
    }

    button_classes.each_key do |element|
      define_method("check_button_#{element}?") do
        @instance.webdriver.click_on_locator(send("#{element}_element"))
        button_classes[element].new(@instance)
      end
    end

    def check_link_amazon?
      attribute = @instance.webdriver.get_attribute(amazon_element, 'href')
      @instance.webdriver.click_on_locator(amazon_element)
      @instance.webdriver.switch_to_popup
      attribute.include?(parse_url)
    end

    def parse_url
      current_url = URI(@instance.webdriver.current_url)
      current_url.fragment = current_url.query = nil
      current_url.to_s
    end
  end
end
