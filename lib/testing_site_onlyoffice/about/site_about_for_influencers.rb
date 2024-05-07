# frozen_string_literal: true

module TestingSiteOnlyoffice
  # /influencer-program.aspx
  # https://github.com/ONLYOFFICE-QA/testing-site-onlyoffice/assets/99170537/f808c8c0-c7d0-48a3-b484-f4b7d6dd174a
  class SiteAboutForInfluencers
    include PageObject

    link(:get_started_button, xpath: '//a[@id="account-btn"]')
    link(:application_form_link, xpath: '//a[@class="orange_link" and @href="#form"]')
    link(:apply_now_button, xpath: '//a[@id="btn"]')
    link(:join_now_ambassador_button, xpath: '//a[contains(@class, "button gray") and contains(@href, "blog")]')
    link(:start_now_affiliates_button, xpath: '//a[contains(@class, "button gray") and contains(@href, "affiliates.aspx")]')

    # form inputs
    text_field(:full_name, xpath: '//input[@id="txtFirstName"]')
    text_field(:email, xpath: '//input[@id="txtEmail"]')
    text_field(:website_link, xpath: '//input[@id="txtCompanyWebsite"]')
    text_area(:more_details, xpath: '//textarea[contains(@class,  "txtSubjMatter")]')
    text_field(:submit_button, xpath: '//input[@id="sbmtRequest"]')

    def initialize(instance)
      super(instance.webdriver.driver)
      @instance = instance
      wait_to_load
    end

    def wait_to_load
      @instance.webdriver.wait_until do
        @instance.webdriver.element_present?(get_started_button_element)
      end
    end

    def influencer_form_visible?
      @instance.webdriver.wait_until do
        @instance.webdriver.element_visible?(full_name_element)
      end
    end

    def click_join_now_ambassador
      join_now_ambassador_button_element.click
      SiteAboutBlog.new(@instance)
    end

    def click_join_now_affiliates
      start_now_affiliates_button_element.click
      SitePartnersAffiliates.new(@instance)
    end

    def fill_influencer_form_and_submit(email)
      self.full_name = Faker::Name.name
      self.email = email
      self.website_link = Faker::Internet.url
      self.more_details = Faker::Lorem.sentences(number: 2).join(' ')
      submit_button_element.click
    end
  end
end
