# frozen_string_literal: true

require 'spec_helper'

test_manager = TestingSiteOnlyoffice::TestManager.new(suite_name: File.basename(__FILE__))

describe 'Open source bundlers download' do
  before do
    site_home_page, @test = TestingSiteOnlyoffice::SiteHelper.new.open_page_teamlab_office(config)
    @bundlers_page = site_home_page.click_link_on_toolbar(:open_source_packages).open_opensource_bundles
  end

  TestingSiteOnlyoffice::SiteDownloadData.open_source_bundles_list.each do |installer|
    it "[Site][DownloadOpenSource][Bundlers] Check `#{installer}`'Read instructions' link /download.aspx" do
      @bundlers_page.read_instruction_connector(installer)
      instruction_title = TestingSiteOnlyoffice::SiteDownloadData.open_source_bundlers_info[installer.to_s]['instruction']
      expect(@bundlers_page.check_opened_page_title).to eq(instruction_title)
    end

    it "[Site][DownloadOpenSource][Bundlers] Check `#{installer}` 'Install now' link /download.aspx" do
      expect(@bundlers_page).to be_file_can_be_downloaded(installer)
    end
  end

  after do |example|
    test_manager.add_result(example, @test)
    @test.webdriver.quit
  end
end
