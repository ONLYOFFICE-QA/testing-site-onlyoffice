# Get more info, website and Get it now xpath of current connector
# https://user-images.githubusercontent.com/40513035/116356047-97090c00-a7af-11eb-8030-5228f553d2b1.png

module TestingSiteOnlyoffice
  class SiteProductsConnectorConstructor
    attr_accessor :instance, :get_it_now_xpath, :more_info_xpath, :developer_website_xpath

    def initialize(instance, block_xpath, connector)
      @instance = instance
      @get_it_now_xpath = "#{block_xpath}//div[@class='itdn_section_button']/a[contains(@href, '#{connector}')]"
      @more_info_xpath = "#{block_xpath}//div[@class='itdn_section_moreinfo']/a[contains(@href, '#{connector}')]"
      @developer_website_xpath = "#{@more_info_xpath}/../..//div[@class='itdn_section_vendor_web']/a"
      wait_to_load
    end

    def wait_to_load
      @instance.webdriver.wait_until do
        @instance.webdriver.get_element(@get_it_now_xpath).present?
      end
    end
  end
end
