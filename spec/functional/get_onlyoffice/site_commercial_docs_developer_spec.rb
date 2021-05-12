require 'spec_helper'

test_manager = TestingSiteOnlyoffice::TestManager.new(suite_name: File.basename(__FILE__))

describe 'Commercial packages Onlyoffice Docs Developer edition download' do
  before do
    site_home_page, @test = TestingSiteOnlyoffice::SiteHelper.new.open_page_teamlab_office(config)
    @download_commercial_page = site_home_page.click_link_on_toolbar(:commercial_packages)
  end

  it_behaves_like 'commercial_installer_download', 'Docs_Developer',
                  TestingSiteOnlyoffice::SiteDownloadData.commercial_developer_docs_list_type do
    let(:installers_download_page) { @download_commercial_page }
  end

  after do |example|
    test_manager.add_result(example, @test)
    @test.webdriver.quit
  end
end
