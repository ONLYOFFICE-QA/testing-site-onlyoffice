# frozen_string_literal: true

require 'spec_helper'

test_manager = TestingSiteOnlyoffice::TestManager.new(suite_name: File.basename(__FILE__))

describe 'Commercial packages workspace download' do
  before do
    site_home_page, @test = TestingSiteOnlyoffice::SiteHelper.new.open_page_teamlab_office(config)
    @workspace_enterprise_page = site_home_page.click_link_on_toolbar(:onlyoffice_workspace)
  end

  it_behaves_like 'commercial_installer_download', 'Workspace_Enterprise',
                  TestingSiteOnlyoffice::SiteDownloadData.commercial_workspace_list_type do
    let(:installers_download_page) { @workspace_enterprise_page }
  end

  after do |example|
    test_manager.add_result(example, @test)
    @test.webdriver.quit
  end
end
