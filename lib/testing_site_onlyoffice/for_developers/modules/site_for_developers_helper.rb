# frozen_string_literal: true

module TestingSiteOnlyoffice
  # Helper for storing additional methods of the class SiteForDevelopers
  module SiteForDevelopersHelper
    def click_docspace_learn_more
      docspace_learn_more_element.click
      TestingSiteOnlyoffice::SiteDocSpaceMainPage.new(@instance)
    end

    def click_docspace_api
      docspace_api_element.click
    end

    def click_available_plugins
      available_plugins_element.click
      TestingSiteOnlyoffice::SiteFeaturesMarketplace.new(@instance)
    end

    def click_docs_try_now
      docs_try_now_element.click
      TestingSiteOnlyoffice::SiteGetOnlyofficeDocsDeveloper.new(@instance)
    end

    def click_docs_integration_examples
      docs_integration_examples_element.click
    end

    def click_docs_learn_more
      docs_learn_more_element.click
      TestingSiteOnlyoffice::SiteForDevelopersDocDevEdition.new(@instance)
    end

    def click_docs_compare_api_wopi
      docs_compare_api_wopi_element.click
      TestingSiteOnlyoffice::SiteWOPIComparison.new(@instance)
    end

    def click_docbuilder_download_now
      docbuilder_download_now_element.click
      TestingSiteOnlyoffice::SiteGetOnlyofficeDocsDeveloper.new(@instance)
    end

    def click_docbuilder_source_code
      docbuilder_source_code_element.click
    end

    def click_docbuilder_check_examples
      docbuilder_check_examples_element.click
    end

    # Explicitly switches to the second tab due to the forced context change required after opening a new tab
    def click_docspace_check_tutorial
      docspace_check_tutorial_element.click
      @instance.webdriver.choose_tab(2)
      TestingSiteOnlyoffice::SiteAboutBlog.new(@instance)
    end

    def click_workspace_find_out_more
      workspace_find_out_more_element.click
    end
  end
end
