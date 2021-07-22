# frozen_string_literal: true

require_relative '../get_onlyoffice/modules/site_download_helper'

module TestingSiteOnlyoffice
  # Site footer
  # https://user-images.githubusercontent.com/40513035/100441407-75e4a800-30b7-11eb-8e39-9d2cc50329ee.png
  module SiteFooter
    include PageObject
    include SiteDownloadHelper

    # developers
    link(:document_builder, xpath: '//a[@href="/document-builder.aspx"]')

    # resources
    link(:help_center_footer_link, xpath: '//a[contains(@href,"helpcenter.onlyoffice.com/index.aspx")]')

    # support
    link(:premium_support, xpath: '//a[@href="/support.aspx"]')
    link(:order_demo, xpath: '//a[@href="/demo-order.aspx"]')
    link(:support_contact_form, xpath: '//a[@href="/support-contact-form.aspx"]')

    # contact us
    link(:request_a_call, xpath: '//a[@href="/call-back-form.aspx"]')

    # follow us on
    label(:subscribe_to_newsletter, xpath: '//div[@class="footer_menu"]//label[@title="Subscribe to our newsletters"]')

    def click_document_builder_info
      document_builder_element.click
      SiteDocumentBuilder.new(@instance)
    end

    def click_help_center
      help_center_footer_link_element.click
      SiteHelpCenter.new(@instance)
    end

    def click_order_demo
      order_demo_element.click
      SiteOrderDemo.new(@instance)
    end

    def click_premium_support
      premium_support_element.click
      SitePremiumSupport.new(@instance)
    end

    def click_support_contact_form
      support_contact_form_element.click
      SiteSupportContactForm.new(@instance)
    end

    def click_request_a_call
      request_a_call_element.click
      SiteCallback.new(@instance)
    end

    def click_subscribe_to_newsletter
      subscribe_to_newsletter_element.click
      SiteSubscribe.new(@instance)
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
