# frozen_string_literal: true

require_relative '../../modules/site_toolbar'
require_relative '../../get_onlyoffice/modules/site_download_helper'
require_relative '../modules/site_about_search'
require_relative '../modules/site_about_section_filter'
require_relative 'site_white_paper_download_form'

module TestingSiteOnlyoffice
  # /whitepapers.aspx
  # https://user-images.githubusercontent.com/40513035/125709963-a55ea76f-58d3-451d-8d14-5fc8769c5b9b.png
  class SiteAboutWhitePapers
    include PageObject
    include SiteAboutSearch
    include SiteAboutSectionFilter
    include SiteDownloadHelper
    include SiteToolbar

    elements(:white_paper_block, xpath: "//div[@id='whitepapers_item']//div[@class='btn_container']/a")
    elements(:datasheet_block, xpath: "//div[@id='datasheets_item']//div[@class='btn_container']/a")
    link(:load_more, xpath: "//a[@id='datasheets_load']")

    def initialize(instance)
      super(instance.webdriver.driver)
      @instance = instance
      @instance.webdriver.wait_until { white_paper_block_visible? }
    end

    def white_papers_names
      white_papers_names = []
      white_paper_block_elements.each { |element| white_papers_names << element.attribute('id').to_sym }
      white_papers_names
    end

    def datasheets_names
      datasheets_names = []
      datasheet_block_elements.each { |element| datasheets_names << element.attribute('id').to_sym }
      datasheets_names
    end

    def white_paper_xpath(block_id)
      "//a[@id = '#{block_id}']"
    end

    def white_paper_block_visible?(block_id = 'for_government_offices')
      @instance.webdriver.element_visible?(white_paper_xpath(block_id))
    end

    def open_and_send_request_white_paper(block_id)
      load_more_element.click unless white_paper_block_visible?(block_id)
      @instance.webdriver.driver.find_element(:xpath, white_paper_xpath(block_id)).click
      courses_request_form = SiteWhitePaperDownloadForm.new(@instance)
      courses_request_form.send_white_paper_request
    end
  end
end
