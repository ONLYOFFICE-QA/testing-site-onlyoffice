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
    link(:workspace_link, xpath: '//div[@class="wwdon_text_block"]/a')
    link(:docspace_link, xpath: '//a[contains(@class, "wwdds_link")]')
    link(:become_contributor, xpath: '//div[contains(@class, "wwd_description_text")]//a[@href="/contribute.aspx"]')
    link(:job_openings, xpath: '//div[contains(@class, "wwd_description_text")]//a[@href="/vacancies.aspx"]')
    link(:customer_stories, xpath: '//div[@class="wwd_home_block2"]/a')

    def initialize(instance)
      super(instance.webdriver.driver)
      @instance = instance
      wait_to_load
    end

    def wait_to_load
      @instance.webdriver.wait_until { @instance.webdriver.element_present?(about_page_element) }
    end

    def opened?
      @instance.webdriver.driver.current_url.include? '/about.aspx'
    end

    def click_onlyoffice_docs
      @instance.webdriver.wait_until { @instance.webdriver.element_present?(about_onlyoffice_docs_element) }
      about_onlyoffice_docs_element.click
      SiteProductsDocs.new(@instance)
    end

    def click_workspace
      @instance.webdriver.wait_until { @instance.webdriver.element_present?(workspace_link_element) }
      workspace_link_element.click
      SiteFeaturesWorkspace.new(@instance)
    end

    def click_docspace
      @instance.webdriver.wait_until { @instance.webdriver.element_present?(docspace_link_element) }
      docspace_link_element.click
      SiteDocSpaceMainPage.new(@instance)
    end

    def click_customer_stories
      @instance.webdriver.wait_until { @instance.webdriver.element_present?(customer_stories_element) }
      customer_stories_element.click
      SiteAboutCustomerStories.new(@instance)
    end

    def click_become_contributor
      @instance.webdriver.wait_until { @instance.webdriver.element_present?(become_contributor_element) }
      become_contributor_element.click
      SiteAboutContribute.new(@instance)
    end

    def click_job_openings
      @instance.webdriver.wait_until { @instance.webdriver.element_present?(job_openings_element) }
      job_openings_element.click
      SiteAboutJobs.new(@instance)
    end
  end
end
