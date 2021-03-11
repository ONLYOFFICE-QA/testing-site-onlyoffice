shared_examples_for 'document_builder_download' do |installers_list|
  installers_list.each do |installer|
    describe installer.to_s do
      before do
        @current_installation = installers_download_page.installer_document_builder_block(installer)
      end

      it "[Site][DownloadDocumentBuilder][#{installer}] 'Download' button for`#{installer}`/download.aspx#builder" do
        expect(installers_download_page).to be_link_alive(@current_installation.download_xpath)
        expect(installers_download_page).to be_download_link_valid(@current_installation.download_xpath, @current_installation.get_extension[installer])
      end

      it "[Site][DownloadDocumentBuilder][#{installer}] 'Read installation instructions' works for`#{installer}`/download.aspx#builder" do
        @current_installation.click_read_instruction
        expect(installers_download_page.check_opened_page_title).to eq(TestingSiteOnlyoffice::SiteDownloadData::DOCUMENT_BUILDER_INSTRUCTION)
      end

      it "[Site][DownloadDocumentBuilder][#{installer}] version and realise date is not empty for `#{installer}`/download.aspx#builder" do
        expect(@current_installation.get_installer_release_date).not_to be_empty
        expect(@current_installation.get_installer_version).not_to be_empty
      end
    end
  end
end
