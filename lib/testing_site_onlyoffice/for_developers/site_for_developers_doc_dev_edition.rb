# frozen_string_literal: true
require_relative '../features/docs/site_features_document_editor'
require_relative '../features/docs/site_features_e_book_creator'
require_relative '../modules/site_editors_links_checking_helper'
require_relative '../for_developers/site_for_developers_doc_builder'
require_relative '../for_developers/site_for_developers_conversion_api'
require_relative 'modules/site_doc_dev_edition_helper'

module TestingSiteOnlyoffice
  # developer-edition.aspx
  # https://user-images.githubusercontent.com/67409742/166101050-a8605bdb-d3be-4300-9376-cb57db77a93f.png
  class SiteForDevelopersDocDevEdition
    include SiteDocDevEditionHelper
    include SiteEditorsLinksCheckingHelper
    include SiteDownloadHelper
    include PageObject

    link(:get_it_now, xpath: "//*[@id='get-it-now__developer-edition__b__download-docs']")

    def initialize(instance)
      super(instance.webdriver.driver)
      @instance = instance
      wait_to_load
    end

    def wait_to_load
      @instance.webdriver.wait_until { @instance.webdriver.element_present?(get_it_now_element) }
    end
  end
end
