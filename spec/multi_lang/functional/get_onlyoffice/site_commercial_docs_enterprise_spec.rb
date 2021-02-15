require 'spec_helper'

test_manager = TestManager.new(suite_name: File.basename(__FILE__))

describe 'Commercial packages Onlyoffice Docs Enterprise edition download' do
  before do
    site_home_page, @test = TestingSiteOnlyffice::PortalHelper.new.open_page_teamlab_office
    @download_commercial_page = site_home_page.click_link_on_toolbar(:commercial_packages)
  end

  it_behaves_like 'commercial_installer_download', 'Docs_Enterprise',
                  TestingSiteOnlyffice::SiteDownloadData.commercial_enterprise_docs_list_type do
    let(:installers_download_page) { @download_commercial_page }
  end

  after do |example|
    test_manager.add_result(example)
    @test.webdriver.quit
  end
end
