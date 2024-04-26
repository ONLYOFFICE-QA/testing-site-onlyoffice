# frozen_string_literal: true

module TestingSiteOnlyoffice
  # /technology-partners.aspx
  # https://github.com/ONLYOFFICE-QA/testing-site-onlyoffice/assets/99170537/c582b091-bdbb-4e1e-b9ed-82b7025ed2a3
  class SitePartnersTechnology
    include PageObject
    include SiteToolbar
    include SiteDownloadHelper

    div(:software_tab, xpath: '//div[@id = "part-software"]')
    link(:become_partner_button, xpath: '//div[@class="first-screen-part"]/a[@href="/partnership-request.aspx"]')
    link(:docs_dev_try_now, xpath: '//a[@href="/download-docs.aspx#docs-developer"]')
    link(:doc_builder_download, xpath: '//a[@href="/download-builder.aspx" and @class="button red"]')

    def initialize(instance)
      super(instance.webdriver.driver)
      @instance = instance
      wait_to_load
    end

    def wait_to_load
      @instance.webdriver.wait_until do
        @instance.webdriver.element_present?(software_tab_element)
      end
    end

    def click_become_partner_button
      become_partner_button_element.click
      SitePartnersRequest.new(@instance)
    end

    def click_docs_dev_try_now
      docs_dev_try_now_element.click
      SiteGetOnlyofficeDocsDeveloper.new(@instance)
    end

    def click_doc_builder_download
      doc_builder_download_element.click
      SiteGetOnlyofficeDownloadDocBuilder.new(@instance)
    end

    def get_partner_link(current_partner)
      xpath = "//a[@class='le-logo-elem #{current_partner}']"
      @instance.webdriver.get_attribute(xpath, 'href')
    end
  end
end
