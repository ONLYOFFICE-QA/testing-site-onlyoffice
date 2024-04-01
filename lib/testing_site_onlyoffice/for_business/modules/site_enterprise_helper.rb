# frozen_string_literal: true

module TestingSiteOnlyoffice
  # Helper for storing additional methods of the class SiteEnterprise
  module SiteEnterpriseHelper
    def click_docspace_use_for_free
      docspace_use_for_free_link_element.click
      SiteDocSpaceSignUp.new(@instance)
    end

    def click_docspace_run_on_your_server
      docspace_learn_more_link_element.click
      SiteDocSpaceDownloadEnterprise.new(@instance)
    end

    def click_docspace_learn_more
      docspace_learn_more_link_element.click
      SiteDocSpaceMainPage.new(@instance)
    end

    def click_docs_try_now
      docs_try_now_link_element.click
      SiteGetOnlyofficeDocsEnterprise.new(@instance)
    end

    def click_docs_learn_more
      docs_learn_more_link_element.click
      SiteForBusinessDocsEnterpriseEdition.new(@instance)
    end

    def click_docs_see_prices
      docs_see_prices_link_element.click
      SitePriceDocsEnterprise.new(@instance)
    end

    def click_workspace_try_now
      workspace_try_now_link_element.click
      SiteGetOnlyofficeWorkspaceEnterprise.new(@instance)
    end

    def click_workspace_see_prices
      workspace_see_prices_link_element.click
      SitePricingWorkSpace.new(@instance)
    end

    def click_workspace_learn_more
      workspace_learn_more_link_element.click
      SiteEnterpriseEdition.new(@instance)
    end

    def click_desktop_download_now
      desktop_download_now_element.click
      SiteGetOnlyofficeDesktopApps.new(@instance)
    end

    def click_desktop_learn_more
      desktop_learn_more_element.click
      SiteFeaturesDesktop.new(@instance)
    end

    def click_mobile_ios_learn_more
      mobile_ios_learn_more_element.click
      SiteFeaturesIos.new(@instance)
    end

    def click_mobile_android_learn_more
      mobile_android_learn_more_element.click
      SiteFeaturesAndroid.new(@instance)
    end

    def click_mobile_download_now
      mobile_download_now_element.click
      SiteMobileApps.new(@instance)
    end
  end
end
