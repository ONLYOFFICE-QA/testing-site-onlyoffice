# frozen_string_literal: true

require_relative '../get_onlyoffice/modules/site_download_helper'
require_relative 'site_methods_footer/site_methods_footer_developers'
require_relative '../features/site_features_oforms'

module TestingSiteOnlyoffice
  # Site footer
  # https://user-images.githubusercontent.com/40513035/131658727-259c73e8-24cc-4325-b94f-c1edd0ffd0ad.png
  module SiteFooter
    include PageObject
    include SiteDownloadHelper
    include SiteFooterDevelopers

    footer_xpath = '//div[@class="footer_menu_item"]'

    # solutions
    link(:smbs, xpath: "#{footer_xpath}//a[contains(@href, 'for-small-business')]")
    link(:enterprises, xpath: "#{footer_xpath}//a[contains(@href, 'for-enterprises')]")
    link(:size_home_use, xpath: "#{footer_xpath}//a[contains(@href, 'home-use')]")
    link(:for_developers, xpath: "#{footer_xpath}//a[contains(@href, 'for-developers')]")
    link(:for_hosting_providers, xpath: "#{footer_xpath}//a[contains(@href, 'for-hosting-providers')]")
    link(:for_government, xpath: "#{footer_xpath}//a[contains(@href, 'for-government')]")
    link(:healthcare, xpath: "#{footer_xpath}//a[contains(@href, 'healthcare')]")
    link(:for_research, xpath: "#{footer_xpath}//a[contains(@href, 'for-research')]")
    link(:education, xpath: "#{footer_xpath}//a[contains(@href, 'education')]")
    link(:nonprofits, xpath: "#{footer_xpath}//a[contains(@href, 'nonprofit-organizations')]")

    # features
    link(:document_editor, xpath: "#{footer_xpath}//a[@href = '/document-editor.aspx']")
    link(:spreadsheet_editor, xpath: "#{footer_xpath}//a[@href = '/spreadsheet-editor.aspx']")
    link(:presentation_editor, xpath: "#{footer_xpath}//a[@href = '/presentation-editor.aspx']")
    link(:form_creator, xpath: "#{footer_xpath}//a[@href = '/form-creator.aspx']")
    link(:pdf_reader_converter, xpath: "#{footer_xpath}//a[@href = '/pdf-editor.aspx']")
    link(:security, xpath: "#{footer_xpath}//a[contains(@href, 'security')]")
    link(:accessibility, xpath: "#{footer_xpath}//a[contains(@href, 'accessibility')]")
    link(:ai_helper, xpath: "#{footer_xpath}//a[contains(@href, '/app-directory/chatgpt')]")
    link(:app_directory, xpath: "#{footer_xpath}//a[@href = '/app-directory']")

    # connectors
    link(:nextcloud, xpath: "#{footer_xpath}//a[contains(@href, 'nextcloud')]")
    link(:moodle, xpath: "#{footer_xpath}//a[contains(@href, 'moodle')]")
    link(:odoo, xpath: "#{footer_xpath}//a[contains(@href, 'odoo')]")
    link(:wordpress, xpath: "#{footer_xpath}//a[contains(@href, 'wordpress')]")
    link(:all_connectors, xpath: "#{footer_xpath}//a[contains(@href, 'all-connectors')]")

    # converters
    link(:text_converter, xpath: "#{footer_xpath}//a[contains(@href, 'text-file-converter.aspx')]")
    link(:spreadsheets_converter, xpath: "#{footer_xpath}//a[contains(@href, 'spreadsheet-converter.aspx')]")
    link(:presentations_converter, xpath: "#{footer_xpath}//a[contains(@href, 'presentation-converter.aspx')]")
    link(:PDFs_converter, xpath: "#{footer_xpath}//a[contains(@href, 'pdf-converter.aspx')]")

    # templates
    link(:find_pdf_form_templates, xpath: "#{footer_xpath}//a[contains(@href, 'oforms.onlyoffice.com')]")
    link(:fill_out_pdf_forms_online, xpath: "#{footer_xpath}//a[contains(@href, 'oforms.onlyoffice.com')]")

    # resources
    link(:help_center_footer_link, xpath: '//a[contains(@href,"helpcenter.onlyoffice.com/index.aspx")]')

    # support
    link(:order_demo, xpath: "#{footer_xpath}//a[@href = '/demo-order.aspx']")
    link(:support_contact_form, xpath: "#{footer_xpath}//a[@href='/support-contact-form.aspx']")

    # contact us
    link(:request_a_call, xpath: "#{footer_xpath}//a[@href='/call-back-form.aspx']")

    # follow us on
    label(:subscribe_to_newsletter, xpath: '//div[contains(@class,"footer_menu")]//label[@title="Subscribe to our newsletters"]')
    footer_links = { size_home_use: SiteHomeUse,
                     nonprofits: SiteNonProfits,
                     developers: SiteForDevelopers,
                     help_center_footer_link: SiteAboutHelpCenter,
                     support_contact_form: SiteSupportContactForm,
                     order_demo: SiteOrderDemo,
                     request_a_call: SiteCallback,
                     subscribe_to_newsletter: SiteSubscribe,
                     document_editor: SiteFeaturesDocumentEditor,
                     spreadsheet_editor: SiteFeaturesSpreadsheetEditor,
                     presentation_editor: SiteFeaturesPresentationEditor,
                     pdf_reader_converter: SiteFeaturesPDFReaderConverter,
                     form_creator: SiteFeaturesFormCreator,
                     text_converter: ConvertPage,
                     spreadsheets_converter: ConvertPage,
                     presentations_converter: ConvertPage,
                     PDFs_converter: ConvertPage,
                     find_pdf_form_templates: SiteFeaturesOforms,
                     fill_out_pdf_forms_online: SiteFeaturesOforms }

    footer_links.each_key do |link|
      define_method(:"click_#{link}") do
        @instance.webdriver.click_on_locator(send(:"#{link}_element"))
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
