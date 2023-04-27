# frozen_string_literal: true

require_relative '../get_onlyoffice/modules/site_download_helper'
require_relative 'site_methods_footer/site_methods_footer_developers'

module TestingSiteOnlyoffice
  # Site footer
  # https://user-images.githubusercontent.com/40513035/131658727-259c73e8-24cc-4325-b94f-c1edd0ffd0ad.png
  module SiteFooter
    include PageObject
    include SiteDownloadHelper
    include SiteFooterDevelopers

    footer_xpath = '//div[@class="footer_menu_item"]'

    # by size
    link(:size_home_use, xpath: "#{footer_xpath}//a[contains(@href, 'home-use')]")

    # by industry
    link(:nonprofits, xpath: "#{footer_xpath}//a[contains(@href, 'nonprofit')]")
    link(:developers, xpath: "#{footer_xpath}//a[@href = '/for-developers.aspx']")

    # resources
    link(:help_center_footer_link, xpath: '//a[contains(@href,"helpcenter.onlyoffice.com/index.aspx")]')

    # support
    link(:order_demo, xpath: '//a[@href="/demo-order.aspx"]')
    link(:support_contact_form, xpath: '//a[@href="/support-contact-form.aspx"]')

    # contact us
    link(:request_a_call, xpath: "#{footer_xpath}//a[@href='/call-back-form.aspx']")

    # follow us on
    label(:subscribe_to_newsletter, xpath: '//div[contains(@class,"footer_menu")]//label[@title="Subscribe to our newsletters"]')

    # editors
    link(:document_editor, xpath: "#{footer_xpath}//a[@href = '/document-editor.aspx']")
    link(:spreadsheet_editor, xpath: "#{footer_xpath}//a[@href = '/spreadsheet-editor.aspx']")
    link(:presentation_editor, xpath: "#{footer_xpath}//a[@href = '/presentation-editor.aspx']")
    link(:form_creator, xpath: "#{footer_xpath}//a[@href = '/form-creator.aspx']")
    link(:pdf_reader_converter, xpath: "#{footer_xpath}//a[@href = '/pdf-reader.aspx']")

    footer_links = { size_home_use: SiteHomeUse,
                     nonprofits: SiteNonProfits,
                     developers: SiteForDevelopers,
                     help_center_footer_link: SiteAboutHelpCenter,
                     order_demo: SiteOrderDemo,
                     support_contact_form: SiteSupportContactForm,
                     request_a_call: SiteCallback,
                     subscribe_to_newsletter: SiteSubscribe,
                     document_editor: SiteFeaturesDocumentEditor,
                     spreadsheet_editor: SiteFeaturesSpreadsheetEditor,
                     presentation_editor: SiteFeaturesPresentationEditor,
                     pdf_reader_converter: SiteFeaturesPDFReaderConverter,
                     form_creator: SiteFeaturesFormCreator}

    footer_links.each_key do |link|
      define_method("click_#{link}") do
        @instance.webdriver.click_on_locator(send("#{link}_element"))
        footer_links[link].new(@instance)
      end
    end

    def site_footer_link_alive?(section_title, title)
      link_xpath = get_footer_xpath_by_title(section_title, title)
      link_element = @instance.webdriver.driver.find_element(:xpath, link_xpath)
      link_success_response?(link_element.attribute('href'))
    end

    def get_footer_xpath_by_title(section_title, title)
      if section_title == :'Follow us on'
        "//div[@class='footercolor']//a[@title='#{title}']"
      else
        "//div[@class='footercolor']//a[text()='#{title}']"
      end
    end
  end
end
