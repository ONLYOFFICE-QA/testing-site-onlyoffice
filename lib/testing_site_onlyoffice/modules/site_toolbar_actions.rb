# frozen_string_literal: true

module TestingSiteOnlyoffice
  # Top toolbar action buttons (right part of top toolbar)
  # https://github.com/ONLYOFFICE-QA/testing-site-onlyoffice/assets/99170537/132a802d-dd6f-47fc-afe3-0caf3b91c644
  module SiteToolbarActions
    include PageObject

    link(:phone_icon, xpath: "//a[@id='navitem_call_phone']")
    link(:login_icon, xpath: "//a[@id='navitem_sign_in_header']")
    div(:request_call_button, xpath: "//div[@id='navitem_request_call']")
    link(:docs_cloud_login, xpath: "//a[@id='navitem_sign_in_docs_cloud']")
    link(:docspace_cloud_login, xpath: "//a[@id='navitem_sign_in_docspace']")
    link(:workspace_cloud_login, xpath: "//a[@id='navitem_sign_in_workspace']")

    def click_request_call
      @instance.webdriver.move_to_element_by_locator(phone_icon_element.selector[:xpath])
      request_call_button_element.click
      SiteCallback.new(@instance)
    end

    def move_to_login_icon
      @instance.webdriver.move_to_element_by_locator(login_icon_element.selector[:xpath])
    end

    def click_login_docs_cloud
      move_to_login_icon
      docs_cloud_login_element.click
      SiteDocsSignInPage.new(@instance)
    end

    def click_login_docspace_cloud
      move_to_login_icon
      docspace_cloud_login_element.click
      SiteDocSpaceSignIn.new(@instance)
    end

    def click_login_workspace_cloud
      move_to_login_icon
      workspace_cloud_login_element.click
      SiteGetOnlyofficeSignIn.new(@instance)
    end
  end
end
