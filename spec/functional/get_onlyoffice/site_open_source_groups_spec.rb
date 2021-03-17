require 'spec_helper'

test_manager = TestingSiteOnlyoffice::TestManager.new(suite_name: File.basename(__FILE__))

describe 'Open source groups download' do
  before do
    site_home_page, @test = TestingSiteOnlyoffice::PortalHelper.new.open_page_teamlab_office(config)
    @groups_page = site_home_page.click_link_on_toolbar(:open_source_packages).open_opensource_groups
  end

  TestingSiteOnlyoffice::SiteDownloadData.open_source_groups_list.each do |installer|
    it "[Site][DownloadOpenSource][Groups] Check `#{installer}` download link /download.aspx" do
      expect(@groups_page).to be_download_link_alive(installer)
      expect(@groups_page).to be_download_link_valid(@groups_page.download_xpath(installer), installer)
    end

    it "[Site][DownloadOpenSource][Groups] Check `#{installer}`'Read instructions' link /download.aspx" do
      @groups_page.click_groups_instruction_link(installer)
      instruction_title = TestingSiteOnlyoffice::SiteDownloadData.open_source_groups_info[installer.to_s]['instruction']
      expect(@groups_page.check_opened_page_title).to eq(instruction_title)
    end

    it "[Site][DownloadOpenSource][Groups] Check `#{installer}`'Github' link /download.aspx" do
      @groups_page.click_groups_github_link(installer)
      github_title = TestingSiteOnlyoffice::SiteDownloadData.open_source_groups_info[installer.to_s]['github']
      expect(@groups_page.check_opened_page_title).to eq(github_title)
    end
  end

  after do |example|
    test_manager.add_result(example)
    @test.webdriver.quit
  end
end
