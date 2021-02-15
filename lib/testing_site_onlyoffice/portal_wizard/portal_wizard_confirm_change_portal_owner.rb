module TestingSiteOnlyffice
  class PortalWizardConfirmChangePortalOwner
    include PageObject
    link(:save_link, xpath: '//a[contains(@onclick,"submit")]')
    link(:cancel_link, xpath: '//a[contains(@href,"./")]')

    def initialize(instance)
      super(instance.webdriver.driver)
      @instance = instance
      wait_to_load
    end

    def wait_to_load
      @instance.webdriver.wait_until do
        save_link_element.present?
      end
    end

    def save_change_portal_owner
      save_link
      @instance.webdriver.wait_until do
        !cancel_link_element.present?
      end
      LoginPage.new(@instance)
    end
  end
end
