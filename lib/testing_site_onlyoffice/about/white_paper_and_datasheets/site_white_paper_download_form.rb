# frozen_string_literal: true

module TestingSiteOnlyoffice
  # Site download form for white papers and datasheets
  # https://user-images.githubusercontent.com/40513035/125731894-25e9c97d-c358-4008-968e-05d1fd0eb544.png
  class SiteWhitePaperDownloadForm
    include PageObject

    text_field(:white_paper_full_name, xpath: "//input[@id='txtFirstName']")
    text_field(:white_paper_company_name, xpath: "//input[@id='txtCompanyName']")
    text_field(:white_paper_email, xpath: "//input[@id='txtEmail']")

    link(:white_paper_download, xpath: "//a[@id='request-button']")

    def initialize(instance)
      super(instance.webdriver.driver)
      @instance = instance
      wait_to_load
    end

    def wait_to_load
      @instance.webdriver.wait_until { white_paper_full_name_element.present? }
    end

    def send_white_paper_request(data = {})
      fill_white_paper_form(data)
      white_paper_download_element.click
      @instance.webdriver.wait_until { !white_paper_download_element.present? }
    end

    def fill_white_paper_form(params = {})
      self.white_paper_full_name = params.fetch(:full_name, Faker::Name.name)
      self.white_paper_company_name = params.fetch(:company_name, "NCT Test #{Faker::Company.name}")
      self.white_paper_email = params.fetch(:email, SiteData::CLIENT_EMAIL)
    end
  end
end
