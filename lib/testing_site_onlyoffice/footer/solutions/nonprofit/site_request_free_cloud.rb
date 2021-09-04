# frozen_string_literal: true

require_relative 'site_nonprofit_banners'
require_relative '../../../get_onlyoffice/site_sign_up'

module TestingSiteOnlyoffice
  # /free-cloud.aspx
  # https://user-images.githubusercontent.com/40513035/101844672-0a421680-3b5e-11eb-8107-cde00a74100b.png
  class SiteRequestFreeCloud
    include PageObject

    # request form
    text_field(:first_name, xpath: '//input[@id="txtClEdFirstName"]')
    text_field(:last_name, xpath: '//input[@id="txtClEdLastName"]')
    text_field(:portal_name, xpath: '//input[@id="txtClEdPortalName"]')
    text_field(:email, xpath: '//input[@id="txtEmail"]')
    text_field(:site_url, xpath: '//input[@id="txtClEdWebSite"]')
    div(:submit_request, xpath: '//div[@id="sbmtClEd"]')
    div(:request_accepted_text, xpath: '//div[@class="divClEdSuccess"]')

    link(:create_your_cloud_office_here, xpath: '//div[@class="fce_text"]/a[@href="/registration.aspx?from=nonprofit"]')
    link(:banners, xpath: '//a[@href="/banners.aspx?from=nonprofit"]')
    link(:onlyoffice_website, xpath: '//a[@href="https://www.onlyoffice.com/"]')

    # you are selector
    div(:you_are_selector, xpath: '//div[contains(@class,"inner-text combobox")]')
    list_item(:you_are_school, xpath: '//li[@title="School"]')
    list_item(:you_are_nonprofit, xpath: '//li[@title="Non-profit"]')
    list_item(:you_are_contributor, xpath: '//li[@title="Contributor"]')

    def initialize(instance)
      super(instance.webdriver.driver)
      @instance = instance
      wait_to_load
    end

    def wait_to_load
      @instance.webdriver.wait_until { first_name_element.present? }
    end

    def open_banners
      banners_element.click
      SiteNonProfitBanners.new(@instance)
    end

    def click_create_your_cloud_office_here
      create_your_cloud_office_here_element.click
      SiteSignUp.new(@instance)
    end

    def click_onlyoffice_website
      onlyoffice_website_element.click
      @instance.webdriver.choose_tab(2)
      SiteHomePage.new(@instance)
    end

    def send_non_profit_request(data)
      fill_non_profit_request_form_with_data(data)
      submit_request_element.click
      @instance.webdriver.wait_until { request_accepted? }
    end

    def request_accepted?
      submit_request_element.attribute('class').include?('ok') && request_accepted_text_element.present?
    end

    def fill_non_profit_request_form_with_data(params = {})
      self.first_name = params.fetch(:first_name, Faker::Name.first_name)
      self.last_name = params.fetch(:last_name, Faker::Name.last_name)
      self.email = params.fetch(:email, SiteData::EMAIL_ADMIN)
      self.portal_name = params.fetch(:portal_name, SiteData::NON_PROFIT_PORTAL_NAME)
      choose_you_are(params.fetch(:you_are, :nonprofit))
      self.site_url = params.fetch(:site_url, Faker::Internet.domain_name)
    end

    def choose_you_are(type)
      unless you_are_school_element.present?
        you_are_selector_element.click
        @instance.webdriver.wait_until { you_are_school_element.present? }
      end
      case type
      when :school
        you_are_school_element.click
      when :nonprofit
        you_are_nonprofit_element.click
      when :you_are_contributor
        you_are_contributor_element.click
      end
      @instance.webdriver.wait_until { !you_are_school_element.present? }
    end
  end
end
