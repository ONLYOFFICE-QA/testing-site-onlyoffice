require 'spec_helper'

test_manager = TestingSiteOnlyoffice::TestManager.new(suite_name: File.basename(__FILE__))

describe 'Connectors download' do
  before do
    site_home_page, @test = TestingSiteOnlyoffice::PortalHelper.new.open_page_teamlab_office(config)
    @connectors_page = site_home_page.click_link_on_toolbar(:open_source_packages).open_opensource_connectors
  end

  it_behaves_like 'connector_download', TestingSiteOnlyoffice::SiteDownloadData.connectors_list do
    let(:connectors_page) { @connectors_page }
  end

  TestingSiteOnlyoffice::SiteDownloadData.connectors_list.each do |connector|
    describe connector.to_s do
      before { @current_connector = @connectors_page.installer_open_source_connector_block(connector) }

      it "[Site][OpenSource][Connectors][#{connector}] 'Whats new' link works /download.aspx#connectors" do
        @connectors_page.click_constructor_link(@current_connector.whats_new_xpath)
        whats_new_title = TestingSiteOnlyoffice::SiteDownloadData.connectors_info[connector.to_s]['whats_new']
        expect(@connectors_page.check_opened_page_title).to eq(whats_new_title)
      end
    end
  end

  it "[Site][OpenSource][Connectors] Connectors number didn't change /download.aspx#connectors" do
    expect(@connectors_page.connectors_block_number).to eq(TestingSiteOnlyoffice::SiteDownloadData.connectors_list.count)
  end

  after do |example|
    test_manager.add_result(example)
    @test.webdriver.quit
  end
end
