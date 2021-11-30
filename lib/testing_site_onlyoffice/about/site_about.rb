# frozen_string_literal: true

require_relative '../modules/site_toolbar'
module TestingSiteOnlyoffice
  # /about.aspx
  # https://user-images.githubusercontent.com/40513035/101415041-44aa7a00-38f8-11eb-858b-8c1f89115293.png
  class SiteAbout
    include PageObject
    include SiteToolbar

    div(:about_page, xpath: '//div[@class="wwd_header_narrow max-width-1"]')
    link(:about_onlyoffice_docs, xpath: '//div[@class="wwdfn_text_block"]/a')
    link(:registration_cloud, xpath: '//div[@class="wwdon_text_block"]/a')
    link(:customer_stories, xpath: '//div[@class="wwd_home_block2"]/a')

    def initialize(instance)
      super(instance.webdriver.driver)
      @instance = instance
      wait_to_load
    end

    def wait_to_load
      @instance.webdriver.wait_until { about_page_element.present? }
    end

    def opened?
      @instance.webdriver.driver.current_url.include? '/about.aspx'
    end

    def click_onlyoffice_docs
      @instance.webdriver.wait_until { about_onlyoffice_docs_element.present? }
      about_onlyoffice_docs_element.click
      SiteProductsDocs.new(@instance)
    end

    def click_registration_cloud
      @instance.webdriver.wait_until { registration_cloud_element.present? }
      registration_cloud_element.click
      SiteSignUp.new(@instance)
    end

    def click_customer_stories
      @instance.webdriver.wait_until { customer_stories_element.present? }
      customer_stories_element.click
      SiteCustomerStories.new(@instance)
    end
  end
end
