# frozen_string_literal: true

require 'spec_helper'

test_manager = TestingSiteOnlyoffice::TestManager.new(suite_name: File.basename(__FILE__))

describe 'Get Onlyoffice - Docs Community Bundles' do
  before do
    site_home_page, @test = TestingSiteOnlyoffice::SiteHelper.new.open_page_teamlab_office(config)
    @docs_community_bundles_page = site_home_page.open_community_download_page
  end

  after do |example|
    test_manager.add_result(example, @test)
    @test.webdriver.quit
  end

  TestingSiteOnlyoffice::SiteDownloadData.docs_community_bundles_list.each do |installer|
    it "[Site][Docs Community][Bundles] Check `#{installer}` 'Read instructions' link works" do
      @docs_community_bundles_page.read_instruction_connector(installer)
      instruction_title = TestingSiteOnlyoffice::SiteDownloadData.open_source_bundlers_info[installer.to_s]['instruction']
      expect(@docs_community_bundles_page.check_opened_page_title).to eq(instruction_title)
    end

    it "[Site][Docs Community][Bundles] Check `#{installer}` 'Install now' link works" do
      expect(@docs_community_bundles_page).to be_file_can_be_downloaded(installer)
    end
  end

  it "[Site][GetOnlyoffice][Docs Community] Owncloud bundles number didn't change" do
    expect(@docs_community_bundles_page.owncloud_bundles_block_number).to eq(TestingSiteOnlyoffice::SiteDownloadData.open_source_bundlers_info.keys.count { |key| key.include?('owncloud') })
  end

  it "[Site][GetOnlyoffice][Docs Community] Nextcloud bundles number didn't change" do
    expect(@docs_community_bundles_page.nextcloud_bundles_block_number).to eq(TestingSiteOnlyoffice::SiteDownloadData.open_source_bundlers_info.keys.count { |key| key.include?('nextcloud') })
  end
end
