# frozen_string_literal: true

require 'spec_helper'

test_manager = TestingSiteOnlyoffice::TestManager.new(suite_name: File.basename(__FILE__))

describe 'Onlyoffice Workspace Community edition download' do
  before do
    site_home_page, @test = TestingSiteOnlyoffice::SiteHelper.new.open_page_teamlab_office(config)
    @workspace_community_page = site_home_page.click_link_on_toolbar(:get_onlyoffice_workspace_on_premises).site_workspace_community_download
  end

  TestingSiteOnlyoffice::SiteDownloadData.workspace_community.each do |installer|
    it "[Site][WorkspaceCommunity] Check `#{installer}` 'Read instructions' link /download-workspace.aspx#workspace-community" do
      @workspace_community_page.read_instruction_connector(installer)
      instruction_title = TestingSiteOnlyoffice::SiteDownloadData.open_source_bundlers_info[installer.to_s]['instruction']
      expect(@workspace_community_page.check_opened_page_title).to eq(instruction_title)
    end

    it "[Site][WorkspaceCommunity] Check `#{installer}` 'Install now' link /download-workspace.aspx#workspace-community" do
      expect(@workspace_community_page).to be_file_can_be_downloaded(installer)
    end
  end

  after do |example|
    test_manager.add_result(example, @test)
    @test.webdriver.quit
  end
end
