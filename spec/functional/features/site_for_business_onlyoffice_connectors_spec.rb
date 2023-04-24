# frozen_string_literal: true

require 'spec_helper'
test_manager = TestingSiteOnlyoffice::TestManager.new(suite_name: File.basename(__FILE__))

describe 'Site For Business connectors' do
  before do
    site_home_page, @test = TestingSiteOnlyoffice::SiteHelper.new.open_page_teamlab_office(config)
    @connectors_page = site_home_page.click_link_on_toolbar(:features_connectors)
  end

  after do |example|
    test_manager.add_result(example, @test)
    @test.webdriver.quit
  end

  TestingSiteOnlyoffice::SiteDownloadData.connectors_info.each_key do |connector|
    describe connector.to_s do
      let(:current_connector) { @connectors_page.onlyoffice_connector_block(connector) }

      it "[Site][For Business][OnlyofficeConnectors][#{connector}] 'More info' link works /all-connectors.aspx" do
        connector_info_page = @connectors_page.click_more_info_link(current_connector.more_info_xpath, connector.to_s)
        expect(connector_info_page).to be_logo_element_present
      end

      it "[Site][For Business][OnlyofficeConnectors][#{connector}] Developer website link works /all-connectors.aspx" do
        @connectors_page.click_constructor_link(current_connector.developer_website_xpath)
        expect(@connectors_page).to be_onlyoffice_opened
      end

      it "[Site][For Business][OnlyofficeConnectors][#{connector}] 'Get it now' button works /all-connectors.aspx" do
        download_connectors_page = @connectors_page.click_get_it_now_link(current_connector.get_it_now_xpath)
        expect(download_connectors_page).to be_a TestingSiteOnlyoffice::SiteGetOnlyofficeConnectors
      end
    end
  end
end
