# frozen_string_literal: true

require 'spec_helper'
test_manager = TestingSiteOnlyoffice::TestManager.new(suite_name: File.basename(__FILE__))

describe 'Connectors download' do
  before do
    site_home_page, @test = TestingSiteOnlyoffice::SiteHelper.new.open_page_teamlab_office(config)
    @connectors_page = site_home_page.click_link_on_toolbar(:features_connectors)
  end

  after do |example|
    test_manager.add_result(example, @test)
    @test.webdriver.quit
  end

  it_behaves_like 'connector_download', TestingSiteOnlyoffice::SiteDownloadData.connectors_info.keys do
    let(:connectors_page) { @connectors_page }
  end

  it "[Site][Get Onlyoffice][Connectors] Connectors number didn't change /download-connectors.aspx" do
    expect(@connectors_page.connectors_block_number(:onlyoffice)).to eq(TestingSiteOnlyoffice::SiteDownloadData.connectors_info.keys.count)
  end

  it '[Site][Get Onlyoffice][Connectors] Filter by developers works /all-connectors.aspx' do
    @connectors_page.select_onlyoffice_developers
    expect(@connectors_page.verify_elements_hidden(:partners)).to be_truthy
  end

  TestingSiteOnlyoffice::SiteDownloadData.connectors_info.each_key do |connector|
    describe connector.to_s do
      let(:current_connector) { @connectors_page.onlyoffice_connector_block(connector) }

      it "[Site][Get Onlyoffice][OnlyofficeConnectors][#{connector}] 'More info' link works" do
        connector_info_page = @connectors_page.click_more_info_link(current_connector.more_info_xpath, connector.to_s)
        expect(connector_info_page).to be_logo_element_present
      end

      it "[Site][Get Onlyoffice][OnlyofficeConnectors][#{connector}] 'Developer website link' works" do
        @connectors_page.click_developers_site_link(current_connector.developer_website_xpath)
        expect(@connectors_page).to be_onlyoffice_opened
      end
    end
  end
end
