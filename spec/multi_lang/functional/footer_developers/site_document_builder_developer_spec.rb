require 'spec_helper'

test_manager = TestManager.new(suite_name: File.basename(__FILE__))

describe 'Document Builder download' do
  before do
    site_home_page, @test = TestingSiteOnlyffice::PortalHelper.new.open_page_teamlab_office
    builder_page = site_home_page.click_document_builder
    @download_builder_page = builder_page.click_download_now
  end

  TestingSiteOnlyffice::SiteDownloadData.document_builder_list.each do |installer|
    describe installer.to_s do
      before do
        @current_installation = @download_builder_page.installer_document_builder_type_block(installer)
      end

      it "[Site][DownloadDocumentBuilder][#{installer}] download link for `#{installer}` alive /document-builder.aspx" do
        expect(@download_builder_page).to be_link_alive(@current_installation.download_xpath)
        expect(@download_builder_page).to be_download_link_valid(@current_installation.download_xpath, installer)
      end

      it "[Site][DownloadDocumentBuilder][#{installer}] read instruction link for `#{installer}` alive /document-builder.aspx" do
        @current_installation.click_read_instruction
        expect(@download_builder_page.check_opened_page_title).to eq(TestingSiteOnlyffice::SiteDownloadData::DOCUMENT_BUILDER_INSTRUCTION)
      end
    end
  end

  it_behaves_like 'document_builder_version_and_realise_date', TestingSiteOnlyffice::SiteDownloadData.document_builder_list do
    let(:installers_download_page) { @download_builder_page }
  end

  it '[Site][DownloadDocumentBuilder]Check "Fork ma on Github" button' do
    @download_builder_page.fork_me_on_github
    expect(@download_builder_page.check_opened_page_title).to eq(TestingSiteOnlyffice::SiteDownloadData::FORK_ME_ON_GITHUB)
  end

  it '[Site][DownloadDocumentBuilder]Check switching between "DEB-package" and "RPM-package"' do
    @download_builder_page.switch_to_rpm
    expect(@download_builder_page).to be_rpm_currently_selected
    rpm_block = @download_builder_page.installer_document_builder_type_block(:rpm)
    expect(rpm_block).to be_download_button_visible
    @download_builder_page.switch_to_deb
    expect(@download_builder_page).to be_deb_currently_selected
    deb_block = @download_builder_page.installer_document_builder_type_block(:deb)
    expect(deb_block).to be_download_button_visible
  end

  after do |example|
    test_manager.add_result(example)
    @test.webdriver.quit
  end
end
