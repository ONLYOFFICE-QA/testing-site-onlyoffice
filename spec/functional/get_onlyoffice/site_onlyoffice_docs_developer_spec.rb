# frozen_string_literal: true

require 'spec_helper'

test_manager = TestingSiteOnlyoffice::TestManager.new(suite_name: File.basename(__FILE__))

describe 'Onlyoffice Docs Developer edition download' do
  before do
    site_home_page, @test = TestingSiteOnlyoffice::SiteHelper.new.open_page_teamlab_office(config)
    @download_onlyoffice_docs_page = site_home_page.click_link_on_toolbar(:get_onlyoffice_docs_developer)
  end

  after do |example|
    test_manager.add_result(example, @test)
    @test.webdriver.quit
  end

  it_behaves_like 'commercial_installer_download', 'Docs_Developer',
                  TestingSiteOnlyoffice::SiteDownloadData.commercial_developer_docs_list_type do
    let(:installers_download_page) { @download_onlyoffice_docs_page }
  end

  it "[Site][GetOnlyoffice][Docs Developer] Installers number didn't change" do
    expect(@download_onlyoffice_docs_page.developer_installers_block_number).to eq(TestingSiteOnlyoffice::SiteDownloadData.commercial_info['docs_developer'].count)
  end
end
