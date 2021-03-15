require 'spec_helper'

test_manager = TestingSiteOnlyoffice::TestManager.new(suite_name: File.basename(__FILE__))

describe 'Open source bundlers download' do
  before do
    site_home_page, @test = TestingSiteOnlyoffice::PortalHelper.new.open_page_teamlab_office
    @docs_page = site_home_page.click_link_on_toolbar(:open_source_packages)
  end

  TestingSiteOnlyoffice::SiteDownloadData.open_source_docs_list.each do |installer|
    describe installer.to_s do
      before { @current_installation = @docs_page.installer_type_block(installer) }

      it "[Site][DownloadOpenSource][Docs] Check `#{installer}`'Read instructions' link /download.aspx" do
        @current_installation.click_read_instruction
        instruction_title = TestingSiteOnlyoffice::SiteDownloadData.open_source_docs_info[installer.to_s]['instruction']
        expect(@docs_page.check_opened_page_title).to eq(instruction_title)
      end

      it "[Site][DownloadOpenSource][Docs] Check `#{installer}` 'Install now' link /download.aspx" do
        @current_installation.click_install_button
        expect(@docs_page).to be_install_button_works(installer)
      end
    end
  end

  TestingSiteOnlyoffice::SiteDownloadData.open_source_docs_list_type[:with_github].each do |installer|
    it "[Site][DownloadOpenSource][Docs] Check `#{installer}`'Github' link /download.aspx" do
      @docs_page.installer_type_block(installer).click_github_link
      github_title = TestingSiteOnlyoffice::SiteDownloadData.open_source_docs_info[installer.to_s]['github']
      expect(@docs_page.check_opened_page_title).to eq(github_title)
    end
  end

  # tests check that Github links are still not added to installer block
  TestingSiteOnlyoffice::SiteDownloadData.open_source_docs_list_type[:without_github].each do |installer|
    it "[Site][DownloadOpenSource][Docs] Check `#{installer}`'Github' link not visible /download.aspx" do
      @current_installation = @docs_page.installer_type_block(installer)
      expect(@current_installation).not_to be_github_link_visible
    end
  end

  after do |example|
    test_manager.add_result(example)
    @test.webdriver.quit
  end
end
