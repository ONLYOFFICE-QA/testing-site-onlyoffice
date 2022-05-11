# frozen_string_literal: true

module TestingSiteOnlyoffice
  # methods for products workspace group
  module SiteProductsMethods
    def xpath_section(section)
      "//div[contains(@class, 'cms_block oses_#{section} menuitem')]"
    end

    def check_select?(section)
      attribute = @instance.webdriver.get_attribute(xpath_section(section), 'class')
      return true if attribute.include?('selected')

      @instance.webdriver.webdriver_error('Unselected section')
    end
  end
end
