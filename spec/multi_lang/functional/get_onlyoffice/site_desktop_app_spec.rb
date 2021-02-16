require 'spec_helper'

test_manager = TestManager.new(suite_name: File.basename(__FILE__))

describe 'Desktop apps' do
  before do
    site_home_page, @test = TestingSiteOnlyffice::PortalHelper.new.open_page_teamlab_office
    @desktop_app_page = site_home_page.click_link_on_toolbar(:desktop_mobile_apps)
  end

  context 'Windows 10/8.1/8/7' do
    it '[Desktop][Windows 10]Check download х64' do
      @desktop_app_page.site_desktop_download_windows_10_x64
      expect(@desktop_app_page).to be_file_downloaded(TestingSiteOnlyffice::SiteDownloadData::DESKTOP_WINDOWS_10_X64)
    end

    it '[Desktop][Windows 10]Check download х86' do
      @desktop_app_page.site_desktop_download_windows_10_x86
      expect(@desktop_app_page).to be_file_downloaded(TestingSiteOnlyffice::SiteDownloadData::DESKTOP_WINDOWS_10_X86)
    end

    it '[Desktop][Windows 10]Check "Read instructions" link' do
      @desktop_app_page.site_desktop_windows_10_instructions
      expect(@desktop_app_page.check_opened_page_title).to eq(TestingSiteOnlyffice::SiteDownloadData::DESKTOP_WINDOWS_INSTRUCTION)
    end
  end

  context 'Windows XP/Vista' do
    it '[Desktop][Windows XP]Check download х64' do
      @desktop_app_page.site_desktop_download_windows_xp_x64
      expect(@desktop_app_page).to be_file_downloaded(TestingSiteOnlyffice::SiteDownloadData::DESKTOP_WINDOWS_XP_X64)
    end

    it '[Desktop][Windows XP]Check download х86' do
      @desktop_app_page.site_desktop_download_windows_xp_x86
      expect(@desktop_app_page).to be_file_downloaded(TestingSiteOnlyffice::SiteDownloadData::DESKTOP_WINDOWS_XP_X86)
    end

    it '[Desktop][Windows XP]Check "Read instructions" link' do
      @desktop_app_page.site_desktop_windows_xp_instructions
      expect(@desktop_app_page.check_opened_page_title).to eq(TestingSiteOnlyffice::SiteDownloadData::DESKTOP_WINDOWS_INSTRUCTION)
    end
  end

  context 'Mac' do
    it '[Desktop][MacOS]Check download' do
      expect(@desktop_app_page).to be_download_link_alive(:desktop_mac)
      expect(@desktop_app_page).to be_download_link_valid(@desktop_app_page.download_xpath(:desktop_mac), :mac)
    end

    it '[Desktop][MacOS]Check "Read instructions" link' do
      @desktop_app_page.site_desktop_mac_instructions
      expect(@desktop_app_page.check_opened_page_title).to eq(TestingSiteOnlyffice::SiteDownloadData::DESKTOP_MACOS_INSTRUCTION)
    end
  end

  context 'Debian 8' do
    it '[Desktop][Debian 8]Check download' do
      expect(@desktop_app_page).to be_download_link_alive(:desktop_deb_new)
      expect(@desktop_app_page).to be_download_link_valid(@desktop_app_page.download_xpath(:desktop_deb_new), :deb)
    end

    it '[Desktop][Debian 8]Check "Read instructions" link' do
      @desktop_app_page.site_desktop_deb_new_instructions
      expect(@desktop_app_page.check_opened_page_title).to eq(TestingSiteOnlyffice::SiteDownloadData::DESKTOP_DEB_INSTRUCTION)
    end
  end

  context 'Debian 7' do
    it '[Desktop][Debian 7]Check download' do
      expect(@desktop_app_page).to be_download_link_alive(:desktop_deb_old)
      expect(@desktop_app_page).to be_download_link_valid(@desktop_app_page.download_xpath(:desktop_deb_old), :deb)
    end

    it '[Desktop][Debian 7]Check "Read instructions" link' do
      @desktop_app_page.site_desktop_deb_old_instructions
      expect(@desktop_app_page.check_opened_page_title).to eq(TestingSiteOnlyffice::SiteDownloadData::DESKTOP_DEB_INSTRUCTION)
    end
  end

  context 'CentOS' do
    it '[Desktop][CentOS]Check download' do
      expect(@desktop_app_page).to be_download_link_alive(:desktop_rpm)
      expect(@desktop_app_page).to be_download_link_valid(@desktop_app_page.download_xpath(:desktop_rpm), :rpm)
    end

    it '[Desktop][CentOS]Check "Read instructions" link' do
      @desktop_app_page.site_desktop_rpm_instructions
      expect(@desktop_app_page.check_opened_page_title).to eq(TestingSiteOnlyffice::SiteDownloadData::DESKTOP_RPM_INSTRUCTION)
    end
  end

  context 'AppImage' do
    it '[Desktop][AppImage]Check download' do
      @desktop_app_page.site_desktop_download_appimage
      expect(@desktop_app_page).to be_file_downloaded(TestingSiteOnlyffice::SiteDownloadData::DESKTOP_APPIMAGE)
    end

    it '[Desktop][AppImage]Check "Read instructions" link' do
      @desktop_app_page.site_desktop_appimage_instructions
      expect(@desktop_app_page.check_opened_page_title).to eq(TestingSiteOnlyffice::SiteDownloadData::DESKTOP_APPIMAGE_INSTRUCTION)
    end
  end

  context 'Snap' do
    it '[Desktop][Snap]Check install from snap store' do
      @desktop_app_page.site_desktop_install_from_snap_store
      expect(@desktop_app_page.check_opened_page_title).to eq(TestingSiteOnlyffice::SiteDownloadData::DESKTOP_INSTALL_FROM_SNAP)
    end

    it '[Desktop][Snap]Check "Read instructions" link' do
      @desktop_app_page.site_desktop_snap_instructions
      expect(@desktop_app_page.check_opened_page_title).to eq(TestingSiteOnlyffice::SiteDownloadData::DESKTOP_SNAP_INSTRUCTION)
    end
  end

  context 'Flatpak' do
    it '[Desktop][Flatpak]Check install from Flatpak' do
      @desktop_app_page.site_desktop_install_from_flatpak
      expect(@desktop_app_page.check_opened_page_title).to eq(TestingSiteOnlyffice::SiteDownloadData::DESKTOP_INSTALL_FROM_FLATPAK)
    end

    it '[Desktop][Flatpak]Check "Read instructions" link' do
      @desktop_app_page.site_desktop_flatpak_instructions
      expect(@desktop_app_page.check_opened_page_title).to eq(TestingSiteOnlyffice::SiteDownloadData::DESKTOP_FLATPAK_INSTRUCTION)
    end
  end

  after do |example|
    test_manager.add_result(example)
    @test.webdriver.quit
  end
end
