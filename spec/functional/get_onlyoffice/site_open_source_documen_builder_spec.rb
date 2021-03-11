require 'spec_helper'

test_manager = TestManager.new(suite_name: File.basename(__FILE__))

describe 'Open source Document builder download' do
  before do
    @site_home_page, @test = TestingSiteOnlyoffice::PortalHelper.new.open_page_teamlab_office
  end

  context 'open download page from top toolbar' do
    before do
      download_open_source_page = @site_home_page.click_link_on_toolbar(:open_source_packages)
      @document_builder_download_page = download_open_source_page.open_opensource_document_builder
    end

    TestingSiteOnlyoffice::SiteDownloadData.document_builder_list do |installer|
      it "[Site][DownloadDocumentBuilder][#{installer}] 'Whats new' button works for`#{installer}`/download.aspx#builder" do
        @current_installation = @document_builder_download_page.installer_document_builder_block(installer)
        @current_installation.click_whats_new_link
        expect(@document_builder_download_page).to eq(TestingSiteOnlyoffice::SiteDownloadData::DOCUMENT_BUILDER_CHANGELOG)
      end
    end

    it_behaves_like 'document_builder_download',
                    TestingSiteOnlyoffice::SiteDownloadData.document_builder_list do
      let(:installers_download_page) { @document_builder_download_page }
    end
  end

  context 'open download page from footer' do
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
