# frozen_string_literal: true

shared_examples_for 'document_builder_download' do |installers_list|
  installers_list.each do |installer|
    describe installer.to_s do
      before do
        @current_installation = installers_download_page.installer_document_builder_block(installer)
      end

      it "[Site][DownloadDocumentBuilder][#{installer}] 'Download' button for`#{installer}`/download.aspx#builder" do
        expected_download_file = TestingSiteOnlyoffice::SiteDownloadData.document_builder_info[installer.to_s]['download']
        expect(installers_download_page).to be_link_alive_and_valid(@current_installation.download_xpath, expected_download_file, doc_builder: true)
      end

      it "[Site][DownloadDocumentBuilder][#{installer}] 'Read installation instructions' works for`#{installer}`/download.aspx#builder" do
        installers_download_page.click_constructor_link(@current_installation.instruction_xpath)
        expected_instruction = TestingSiteOnlyoffice::SiteDownloadData.document_builder_info['instruction']
        expect(installers_download_page.check_opened_page_title).to eq(expected_instruction)
      end

      it "[Site][DownloadDocumentBuilder][#{installer}] version and realise date is not empty for `#{installer}`/download.aspx#builder" do
        expect(installers_download_page.get_installer_release_date_or_version(@current_installation.release_date_xpath)).not_to be_empty
        expect(installers_download_page.get_installer_release_date_or_version(@current_installation.version_xpath)).not_to be_empty
      end
    end
  end
end
