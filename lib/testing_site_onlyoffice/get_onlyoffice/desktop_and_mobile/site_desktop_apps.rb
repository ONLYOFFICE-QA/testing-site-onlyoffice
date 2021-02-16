# Download Desktop
# https://user-images.githubusercontent.com/40513035/96171228-4aee2c80-0f2d-11eb-80f9-5be447890300.png
require_relative 'modules/site_desktop_mobiles_toolbar'
require_relative '../modules/site_download_helper'
require_relative '../../modules/site_toolbar'

module TestingSiteOnlyffice
  class SiteDesktopApps
    include PageObject
    include SiteDownloadHelper
    include SiteToolbar
    include SiteToolbarDesktopMobiles

    link(:site_desktop_download_windows_10_x64, xpath: '//a[contains(@href, "DesktopEditors_x64.exe")]')
    link(:site_desktop_download_windows_10_x86, xpath: '//a[contains(@href, "DesktopEditors_x86.exe")]')
    link(:site_desktop_windows_10_instructions,
         xpath: '//a[contains(@href, "DesktopEditors_x64.exe")]/../..//a[contains(@href, "installation")]')
    link(:site_desktop_windows_10_github,
         xpath: '//a[contains(@href, "DesktopEditors_x64.exe")]/../..//a[contains(@href, "github")]')
    link(:site_desktop_windows_10_whats_new,
         xpath: '//a[contains(@href, "DesktopEditors_x64.exe")]/../..//a[contains(@href, "changelog")]')

    link(:site_desktop_download_windows_xp_x64, xpath: '//a[contains(@href, "DesktopEditors_x64_xp.exe")]')
    link(:site_desktop_download_windows_xp_x86, xpath: '//a[contains(@href, "DesktopEditors_x86_xp.exe")]')
    link(:site_desktop_windows_xp_instructions,
         xpath: '//a[contains(@href, "DesktopEditors_x64.exe")]/../..//a[contains(@href, "installation")]')

    link(:site_desktop_download_mac, xpath: '//a[contains(@href, "ONLYOFFICE.dmg")]')
    link(:site_desktop_mac_instructions,
         xpath: '//a[contains(@href, "ONLYOFFICE.dmg")]/../..//a[contains(@href, "installation")]')

    link(:site_desktop_download_deb_new, xpath: '//a[contains(@href, "linux/onlyoffice-desktopeditors_amd64.deb")]')
    link(:site_desktop_deb_new_instructions,
         xpath: '//a[contains(@href, "linux/onlyoffice-desktopeditors_amd64.deb")]/../..//a[contains(@href, "installation")]')

    link(:site_desktop_download_deb_old, xpath: '//a[contains(@href, "linux/old/onlyoffice-desktopeditors_amd64.deb")]')
    link(:site_desktop_deb_old_instructions,
         xpath: '//a[contains(@href, "linux/old/onlyoffice-desktopeditors_amd64.deb")]/../..//a[contains(@href, "installation")]')

    link(:site_desktop_download_rpm, xpath: '//a[contains(@href, "linux/onlyoffice-desktopeditors.x86_64.rpm")]')
    link(:site_desktop_rpm_instructions,
         xpath: '//a[contains(@href, "linux/onlyoffice-desktopeditors.x86_64.rpm")]/../..//a[contains(@href, "installation")]')

    link(:site_desktop_download_appimage, xpath: '//a[contains(@href, "linux/DesktopEditors-x86_64.AppImage")]')
    link(:site_desktop_appimage_instructions,
         xpath: '//a[contains(@href, "linux/DesktopEditors-x86_64.AppImage")]/../..//a[contains(@href, "appimage.github")]')

    link(:site_desktop_install_from_snap_store, xpath: '//a[contains(@href, "snapcraft")]')
    link(:site_desktop_snap_instructions,
         xpath: '//a[contains(@href, "snapcraft")]/../..//a[contains(@href, "installation")]')

    link(:site_desktop_install_from_flatpak, xpath: '//a[contains(@href, "flathub.org")]')
    link(:site_desktop_flatpak_instructions,
         xpath: '//a[contains(@href, "flathub.org")]/../..//a[contains(@href, "installation")]')

    def initialize(instance)
      super(instance.webdriver.driver)
      @instance = instance
      wait_to_load
    end

    def wait_to_load
      @instance.webdriver.wait_until do
        site_desktop_download_windows_10_x64_element.present?
      end
    end

    def download_links
      {
        desktop_win_10_64: site_desktop_download_windows_10_x64_element,
        desktop_win_10_86: site_desktop_download_windows_10_x86_element,
        desktop_win_xp_64: site_desktop_download_windows_xp_x64_element,
        desktop_win_xp_86: site_desktop_download_windows_xp_x86_element,
        desktop_mac: site_desktop_download_mac_element,
        desktop_deb_new: site_desktop_download_deb_new_element,
        desktop_deb_old: site_desktop_download_deb_old_element,
        desktop_rpm: site_desktop_download_rpm_element,
        desktop_appimage: site_desktop_download_appimage_element,
        desktop_snap: site_desktop_install_from_snap_store_element,
        desktop_flatpak: site_desktop_install_from_flatpak_element
      }
    end

    def instruction_links
      {
        desktop_win_10_instruction: site_desktop_windows_10_instructions_element,
        desktop_win_xp_instruction: site_desktop_windows_xp_instructions_element,
        desktop_mac_instruction: site_desktop_mac_instructions_element,
        desktop_deb_new_instruction: site_desktop_deb_new_instructions_element,
        desktop_deb_old_instruction: site_desktop_deb_old_instructions_element,
        desktop_rpm_instruction: site_desktop_rpm_instructions_element,
        desktop_appimage_instruction: site_desktop_appimage_instructions_element,
        desktop_snap_instruction: site_desktop_snap_instructions_element,
        desktop_flatpak_instruction: site_desktop_flatpak_instructions_element
      }
    end

    def download_xpath(installer)
      download_links[installer].selector[:xpath]
    end
  end
end
