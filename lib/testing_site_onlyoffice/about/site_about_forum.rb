# frozen_string_literal: true

module TestingSiteOnlyoffice
  # https://forum.onlyoffice.com
  # https://user-images.githubusercontent.com/38238032/197198489-05be7174-6328-4885-9f6b-005113f53003.png
  class SiteAboutForum

    include PageObject
    include SiteToolbar

    link(:forum_rules_link, xpath: '//a[@href = "/t/forum-rules/7"]')

    def initialize(instance)
      super(instance.webdriver.driver)
      @instance = instance
      wait_to_load
    end

    def wait_load
      @instance.webdriver.wait_until do
        @instance.webdriver.element_present?(forum_rules_link_element)
      end
    end
  end
end
