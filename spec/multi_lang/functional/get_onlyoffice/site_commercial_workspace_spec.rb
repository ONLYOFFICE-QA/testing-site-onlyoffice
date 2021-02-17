require 'spec_helper'

test_manager = TestManager.new(suite_name: File.basename(__FILE__))

describe 'Commercial packages workspace download' do
  before do
    site_home_page, @test = TestingSiteOnlyoffice::PortalHelper.new.open_page_teamlab_office
    download_commercial_page = site_home_page.click_link_on_toolbar(:commercial_packages)
    @commercial_workspace_page = download_commercial_page.open_commercial_workspace
  end

  it_behaves_like 'commercial_installer_download', 'Workspace', TestingSiteOnlyoffice::SiteDownloadData.commercial_workspace_list_type do
    let(:installers_download_page) { @commercial_workspace_page }
  end

  after do |example|
    test_manager.add_result(example)
    @test.webdriver.quit
  end
end
