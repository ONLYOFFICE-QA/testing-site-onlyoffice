# frozen_string_literal: true

module TestingSiteOnlyoffice
  # /download-docspace.aspx
  # https://github.com/ONLYOFFICE-QA/testing-site-onlyoffice/assets/38238032/3830ab1f-aa49-4f51-aa68-cc7bbb92a2d2 date: 09/10/2023
  class SiteDocSpaceDownloadEnterprise
    include PageObject

    link(:docker_download_button, xpath: '//a[@id = "onlyoffice_docspace_enterprise_for_docker_image"]')

    def initialize(instance)
      super(instance.webdriver.driver)
      @instance = instance
    end

    def wait_to_load
      @instance.webdriver.wait_until { @instance.webdriver.element_present?(docker_download_button) }
    end
  end
end
