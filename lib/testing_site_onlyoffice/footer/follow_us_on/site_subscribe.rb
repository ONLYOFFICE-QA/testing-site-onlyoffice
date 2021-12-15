# frozen_string_literal: true

require_relative 'site_subscribe_confirmation'

module TestingSiteOnlyoffice
  # Main site page footer -> Subscribe to our newsletters link
  # https://user-images.githubusercontent.com/3971732/43764973-7fd0ad5a-9a37-11e8-9a43-11439b0a4800.png
  class SiteSubscribe
    include PageObject

    text_field(:first_name, xpath: '//input[@id="subscriptionFirstName"]')
    text_field(:email, xpath: '//input[@id="subscriptionEmail"]')
    text_field(:subscribe_button, xpath: '//input[@id="subscriptionFinishButton"]')

    div(:subscribe_success, xpath: "//div[@class='success']")

    def initialize(instance)
      super(instance.webdriver.driver)
      @instance = instance
      wait_to_load
    end

    def wait_to_load
      @instance.webdriver.wait_until { @instance.webdriver.element_present?(first_name_element) }
    end

    def fill_subscribe_form(params = {})
      self.first_name = params.fetch(:name, Faker::Name.first_name)
      self.email = params.fetch(:email, SiteData::CLIENT_EMAIL)
      subscribe_button_element.click
      @instance.webdriver.wait_until { @instance.webdriver.element_present?(subscribe_success_element) }
    end

    def subscribe_from_link(link)
      @instance.webdriver.open(link)
      SiteSubscribeConfirmation.new(@instance)
    end

    def self.parse_subscribe_link(mail_html)
      parsed_data = Nokogiri::HTML.parse(mail_html)
      parsed_data.xpath("//a[contains(@href,'Subscribe')]").attribute('href').value
    end
  end
end
