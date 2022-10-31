# frozen_string_literal: true

require 'spec_helper'

test_manager = TestingSiteOnlyoffice::TestManager.new(suite_name: File.basename(__FILE__))

describe 'Other Products Bundles download' do
  before do
    site_home_page, @test = TestingSiteOnlyoffice::SiteHelper.new.open_page_teamlab_office(config)
    for_developers_page = site_home_page.footer_developers
    @bundles_page = for_developers_page.click_download_now_button('bundles')
  end

  TestingSiteOnlyoffice::SiteDownloadData.other_products_bundles_list.each do |installer|
    it "[Site][OtherProducts][Bundlers] Check `#{installer}` 'Read instructions' link /download.aspx#bundles" do
      @bundles_page.read_instruction_connector(installer)
      instruction_title = TestingSiteOnlyoffice::SiteDownloadData.open_source_bundlers_info[installer.to_s]['instruction']
      expect(@bundles_page.check_opened_page_title).to eq(instruction_title)
    end

    it "[Site][OtherProducts][Bundlers] Check `#{installer}` 'Install now' link /download.aspx#bundles" do
      expect(@bundles_page).to be_file_can_be_downloaded(installer)
    end
  end

  after do |example|
    test_manager.add_result(example, @test)
    @test.webdriver.quit
  end
end
