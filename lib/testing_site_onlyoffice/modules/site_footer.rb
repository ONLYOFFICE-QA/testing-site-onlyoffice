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

    footer_xpath = '//div[@class="footer_menu"]'

    # by size
    link(:size_home_use, xpath: "#{footer_xpath}//a[contains(@href, 'home-use')]")

    # by industry
    link(:industry_nonprofits, xpath: "#{footer_xpath}//a[contains(@href, 'nonprofit')]")
    link(:industry_developers, xpath: "#{footer_xpath}//a[@href = '/for-developers.aspx']")

    # resources
    link(:help_center_footer_link, xpath: '//a[contains(@href,"helpcenter.onlyoffice.com/index.aspx")]')

    # support
    link(:order_demo, xpath: '//a[@href="/demo-order.aspx"]')
    link(:support_contact_form, xpath: '//a[@href="/support-contact-form.aspx"]')

    # contact us
    link(:request_a_call, xpath: "#{footer_xpath}//a[@href='/call-back-form.aspx']")

    # follow us on
    label(:subscribe_to_newsletter, xpath: '//div[contains(@class,"footer_menu")]//label[@title="Subscribe to our newsletters"]')

    # pdf reader & converter
    link(:pdf_reader_converter, xpath: "#{footer_xpath}//a[@href = '/pdf-reader.aspx']")

    # by size
    def footer_home_use
      size_home_use_element.click
      SiteHomeUse.new(@instance)
    end

    # by industry
    def footer_nonprofits
      industry_nonprofits_element.click
      SiteNonProfits.new(@instance)
    end

    def footer_developers
      industry_developers_element.click
      SiteForDevelopers.new(@instance)
    end

    # resources
    def click_help_center
      help_center_footer_link_element.click
      SiteAboutHelpCenter.new(@instance)
    end

    # support
    def click_order_demo
      order_demo_element.click
      SiteOrderDemo.new(@instance)
    end

    def click_support_contact_form
      support_contact_form_element.click
      SiteSupportContactForm.new(@instance)
    end

    # contact us
    def click_request_a_call
      request_a_call_element.click
      SiteCallback.new(@instance)
    end

    # follow us on
    def click_subscribe_to_newsletter
      subscribe_to_newsletter_element.click
      SiteSubscribe.new(@instance)
    end

    def click_pdf_reader_converter
      pdf_reader_converter_element.click
      SitePDFReaderConverter.new(@instance)
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
