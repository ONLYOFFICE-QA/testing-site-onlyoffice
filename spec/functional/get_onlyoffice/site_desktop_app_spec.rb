# frozen_string_literal: true

require 'spec_helper'

test_manager = TestingSiteOnlyoffice::TestManager.new(suite_name: File.basename(__FILE__))

describe 'Desktop apps' do
  before do
    site_home_page, @test = TestingSiteOnlyoffice::SiteHelper.new.open_page_teamlab_office(config)
    @desktop_app_page = site_home_page.click_link_on_toolbar(:get_onlyoffice_desktop_mobile)
  end

  it_behaves_like 'desktop_installer_download', TestingSiteOnlyoffice::SiteDownloadData.desktop_download_list_type do
   let(:installers_download_page) { @desktop_app_page }
  end

  TestingSiteOnlyoffice::SiteDownloadData.desktop_download_list.each do |installer|
    describe installer.to_s do
      let(:current_installation) { @desktop_app_page.desktop_installer_block(installer) }

      it "[Site][DownloadDesktop] 'Github' link works for `#{installer}`/download-desktop.aspx#desktop" do
        @desktop_app_page.click_constructor_link(current_installation.github_link, installer.to_s)
        github_title = TestingSiteOnlyoffice::SiteDownloadData.desktop_mobile_info['desktop'][installer.to_s]['github']
        expect(@desktop_app_page.check_opened_page_title).to eq(github_title)
      end

      it "[Site][DownloadDesktop] 'Whats new' link works for `#{installer}`/download-desktop.aspx#desktop" do
        @desktop_app_page.click_constructor_link(current_installation.whats_new_link, installer.to_s)
        whats_new_title = TestingSiteOnlyoffice::SiteDownloadData.desktop_mobile_info['desktop']['whats_new']
        expect(@desktop_app_page.check_opened_page_title).to eq(whats_new_title)
      end
    end
  end

  after do |example|
    test_manager.add_result(example, @test)
    @test.webdriver.quit
  end

  it "[Site][DownloadDesktop] Desktop block number didn't change /download-desktop.aspx#desktop" do
    expect(@desktop_app_page.desktop_block_number).to eq(TestingSiteOnlyoffice::SiteDownloadData.desktop_download_list.count)
  end
end
