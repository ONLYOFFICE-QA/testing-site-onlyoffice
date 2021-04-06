require 'spec_helper'

test_manager = TestingSiteOnlyoffice::TestManager.new(suite_name: File.basename(__FILE__))

describe 'Open source Document builder download' do
  before do
    @site_home_page, @test = TestingSiteOnlyoffice::SiteHelper.new.open_page_teamlab_office(config)
  end

  describe 'open download page from top toolbar' do
    before do
      download_open_source_page = @site_home_page.click_link_on_toolbar(:open_source_packages)
      @document_builder_download_page = download_open_source_page.open_opensource_document_builder
    end

    TestingSiteOnlyoffice::SiteDownloadData.document_builder_list.each do |installer|
      it "[Site][DownloadDocumentBuilder][#{installer}] 'Whats new' button works for`#{installer}`/download.aspx#builder" do
        @current_installation = @document_builder_download_page.installer_document_builder_block(installer)
        @document_builder_download_page.click_constructor_link(@current_installation.whats_new_xpath)
        expected_whats_new = TestingSiteOnlyoffice::SiteDownloadData.document_builder_info['whats_new']
        expect(@document_builder_download_page.check_opened_page_title).to eq(expected_whats_new)
      end
    end

    it_behaves_like 'document_builder_download',
                    TestingSiteOnlyoffice::SiteDownloadData.document_builder_list do
      let(:installers_download_page) { @document_builder_download_page }
    end
  end

  describe 'open download page from footer' do
    it 'Open download document builder page from footer' do
      document_builder_info_page = @site_home_page.click_document_builder_info
      document_builder_download_page = document_builder_info_page.click_download_now
      expect(document_builder_download_page).to be_a TestingSiteOnlyoffice::SiteOpenSourceDocumentBuilder
    end
  end

  after do |example|
    test_manager.add_result(example)
    @test.webdriver.quit
  end
end
