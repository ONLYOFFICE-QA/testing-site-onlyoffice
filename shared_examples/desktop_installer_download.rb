# frozen_string_literal: true

shared_examples_for 'desktop_installer_download' do |installers_list|
  installers_list[:download_file].each do |installer|
    describe installer.to_s do
      before { @current_installation = installers_download_page.desktop_installer_block(installer) }

      it "[Site][DownloadDesktop] download link for `#{installer}` alive /download-desktop.aspx#desktop" do
        download_file = TestingSiteOnlyoffice::SiteDownloadData.desktop_mobile_info['desktop'][installer.to_s]['download']
        expect(installers_download_page).to be_link_alive_and_valid(@current_installation.download_xpath, download_file)
      end
    end
  end

  installers_list[:three_download_windows_files][0..1].each do |installer|
    describe installer.to_s do
      before { @current_installation = installers_download_page.desktop_installer_block(installer) }

      it "[Site][DownloadDesktop] download link for `#{installer}` exe and msi` alive /download-desktop.aspx#desktop" do
        download_file_exe = TestingSiteOnlyoffice::SiteDownloadData.desktop_mobile_info['desktop'][installer.to_s]['exe']
        expect(installers_download_page).to be_link_alive_and_valid(@current_installation.download_xpath, download_file_exe)
        download_file_x86 = TestingSiteOnlyoffice::SiteDownloadData.desktop_mobile_info['desktop'][installer.to_s]['msi']
        expect(installers_download_page).to be_link_alive_and_valid(@current_installation.download_xpath_x86, download_file_x86)
      end
    end
  end

  installers_list[:three_download_windows_files][2] do |installer|
    describe installer.to_s do
      before { @current_installation = installers_download_page.desktop_installer_block(installer) }

      it "[Site][DownloadDesktop] download link for `#{installer}` x64 and x86` alive /download-desktop.aspx#desktop" do
        download_file_x64 = TestingSiteOnlyoffice::SiteDownloadData.desktop_mobile_info['desktop'][installer.to_s]['x64']
        expect(installers_download_page).to be_link_alive_and_valid(@current_installation.download_xpath, download_file_x64)
        download_file_x86 = TestingSiteOnlyoffice::SiteDownloadData.desktop_mobile_info['desktop'][installer.to_s]['x86']
        expect(installers_download_page).to be_link_alive_and_valid(@current_installation.download_xpath_x86, download_file_x86)
      end
    end
  end

  installers_list[:two_download_mac_files].each do |installer|
    describe installer.to_s do
      before { @current_installation = installers_download_page.desktop_installer_block(installer) }

      it "[Site][DownloadDesktop] download link for `#{installer}` intel and apple chips` alive /download-desktop.aspx#desktop" do
        download_file_intel = TestingSiteOnlyoffice::SiteDownloadData.desktop_mobile_info['desktop'][installer.to_s]['download_intel']
        expect(installers_download_page).to be_link_alive_and_valid(@current_installation.download_xpath, download_file_intel)
        download_file_apple = TestingSiteOnlyoffice::SiteDownloadData.desktop_mobile_info['desktop'][installer.to_s]['download_apple']
        expect(installers_download_page).to be_link_alive_and_valid(@current_installation.download_xpath_apple, download_file_apple)
      end
    end
  end

  installers_list[:download_from_store].each do |installer|
    describe installer.to_s do
      before { @current_installation = installers_download_page.desktop_installer_block(installer) }

      it "[Site][DownloadDesktop] download link for `#{installer}` alive /download-desktop.aspx#desktop" do
        installers_download_page.click_constructor_link(@current_installation.download_xpath, installer.to_s)
        marketplace_title = TestingSiteOnlyoffice::SiteDownloadData.desktop_mobile_info['desktop'][installer.to_s]['download']
        expect(installers_download_page.check_opened_page_title).to eq(marketplace_title)
      end
    end
  end

  TestingSiteOnlyoffice::SiteDownloadData.desktop_download_list.each do |installer|
    describe installer.to_s do
      before { @current_installation = installers_download_page.desktop_installer_block(installer) }

      it "[Site][DownloadDesktop] 'Read instructions' works for `#{installer}`/download-desktop.aspx#desktop" do
        installers_download_page.click_constructor_link(@current_installation.instruction_xpath, installer.to_s)
        instruction_title = TestingSiteOnlyoffice::SiteDownloadData.desktop_mobile_info['desktop'][installer.to_s]['instruction']
        expect(installers_download_page.check_opened_page_title).to eq(instruction_title)
      end

      it "[Site][DownloadDesktop] version and realise date is not empty for `#{installer}`/download-desktop.aspx#desktop" do
        skip "Skipping version and release date checks temporarily"
        expect(installers_download_page.get_installer_release_date_or_version(@current_installation.release_date_xpath)).not_to be_empty
        expect(installers_download_page.get_installer_release_date_or_version(@current_installation.version_xpath)).not_to be_empty
      end
    end
  end
end
