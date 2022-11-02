# frozen_string_literal: true

require 'spec_helper'

test_manager = TestingSiteOnlyoffice::TestManager.new(suite_name: File.basename(__FILE__))

describe 'Open source workspace download' do
  before do
    site_home_page, @test = TestingSiteOnlyoffice::SiteHelper.new.open_page_teamlab_office(config)
    for_developers_page = site_home_page.footer_developers
    @groups_page = for_developers_page.click_download_now_button('workspace')
  end

  TestingSiteOnlyoffice::SiteDownloadData.open_source_groups_list.each do |installer|
    it "[Site][OtherProducts][Groups] Check `#{installer}` download link /download.aspx#workspace" do
      expect(@groups_page).to be_download_link_alive(installer)
      expect(@groups_page).to be_download_link_valid(@groups_page.download_xpath(installer), installer)
    end

    it "[Site][OtherProducts][Groups] Check `#{installer}`'Read instructions' link /download.aspx#workspace" do
      @groups_page.click_groups_instruction_link(installer)
      instruction_title = TestingSiteOnlyoffice::SiteDownloadData.open_source_groups_info[installer.to_s]['instruction']
      expect(@groups_page.check_opened_page_title).to eq(instruction_title)
    end

    it "[Site][OtherProducts][Groups] Check `#{installer}`'Github' link /download.aspx#workspace" do
      @groups_page.click_groups_github_link(installer)
      github_title = TestingSiteOnlyoffice::SiteDownloadData.open_source_groups_info[installer.to_s]['github']
      expect(@groups_page.check_opened_page_title).to eq(github_title)
    end
  end

  after do |example|
    test_manager.add_result(example, @test)
    @test.webdriver.quit
  end
end
