shared_examples_for 'document_builder_version_and_realise_date' do |installers_list|
  installers_list.each do |installer|
    describe installer.to_s do
      before do
        @current_installation = installers_download_page.installer_document_builder_type_block(installer)
      end

      it "[Site][DownloadDocumentBuilder][#{installer}]  version and realise date is not empty for `#{installer}`/document-builder.aspx" do
        version, release_date = @current_installation.get_version_and_release_date
        expect(version).not_to be_nil
        expect(release_date).not_to be_nil
      end
    end
  end
end
