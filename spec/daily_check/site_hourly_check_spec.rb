require 'spec_helper'

describe 'SiteHourlyCheck' do
  language = 'en-US'
  StaticDataTeamLab.set_portal_type('.com')
  StaticDataTeamLab.set_current_language(language)

  test_run = "Site Hourly Checks version: #{TestingSiteOnlyoffice::SiteHelper.fetch_site_version}, time: #{Time.new}, region: #{StaticDataTeamLab.server_region}"
  testrail = DailyCheckHelper.init_testrail('[Studio] Site Hourly Checks', test_run, 'Site Hourly Check')
  run_name = nil

  describe 'Site onlyoffice.com' do
    before do
      @site_home_page, @test = TestingSiteOnlyoffice::PortalHelper.new.open_page_teamlab_office('http://www.onlyoffice.com')
      @site_home_page.set_page_language(language)
    end

    it '[Site] Check exists languages' do
      expect(@site_home_page.get_all_language_from_site).to eq(TestingSiteOnlyoffice::SiteData.site_languages)
    end

    it '[Site] Check link Personal Office' do
      tour_page = @site_home_page.click_link_on_toolbar(:home_use).open_personal
      expect(tour_page.login_visible?).to be true
    end

    it '[Site] Check Products' do
      page = @site_home_page.click_link_on_toolbar(:products_workspace)
      expect(page).to be_a TestingSiteOnlyoffice::SiteProductsWorkspace
      page = @site_home_page.click_link_on_toolbar(:products_docs)
      expect(page).to be_a TestingSiteOnlyoffice::SiteProductsDocs
      page = @site_home_page.click_link_on_toolbar(:products_document_editor)
      expect(page).to be_a TestingSiteOnlyoffice::SiteProductsDocumentEditor
      page = @site_home_page.click_link_on_toolbar(:products_spreadsheet_editor)
      expect(page).to be_a TestingSiteOnlyoffice::SiteProductsSpreadsheetEditor
      page = @site_home_page.click_link_on_toolbar(:products_presentation_editor)
      expect(page).to be_a TestingSiteOnlyoffice::SiteProductsPresentationEditor
      page = @site_home_page.click_link_on_toolbar(:products_desktop)
      expect(page).to be_a TestingSiteOnlyoffice::SiteProductsDesktop
      page = @site_home_page.click_link_on_toolbar(:products_ios)
      expect(page).to be_a TestingSiteOnlyoffice::SiteProductsIos
      page = @site_home_page.click_link_on_toolbar(:products_android)
      expect(page).to be_a TestingSiteOnlyoffice::SiteProductsAndroid
      page = @site_home_page.click_link_on_toolbar(:products_groups)
      expect(page).to be_a TestingSiteOnlyoffice::SiteProductsGroups
      page = @site_home_page.click_link_on_toolbar(:products_doc_manager)
      expect(page).to be_a TestingSiteOnlyoffice::SiteProductsDocumentManager
      page = @site_home_page.click_link_on_toolbar(:products_mail)
      expect(page).to be_a TestingSiteOnlyoffice::SiteProductsMail
      page = @site_home_page.click_link_on_toolbar(:products_crm)
      expect(page).to be_a TestingSiteOnlyoffice::SiteProductsCRM
      page = @site_home_page.click_link_on_toolbar(:products_projects)
      expect(page).to be_a TestingSiteOnlyoffice::SiteProductsProjects
      page = @site_home_page.click_link_on_toolbar(:products_calendar)
      expect(page).to be_a TestingSiteOnlyoffice::SiteProductsCalendar
      page = @site_home_page.click_link_on_toolbar(:products_community)
      expect(page).to be_a TestingSiteOnlyoffice::SiteProductsCommunity
    end

    it '[Site] Check cloud' do
      page = @site_home_page.click_link_on_toolbar(:pricing_cloud)
      expect(page).to be_a TestingSiteOnlyoffice::SitePricingCloud
      page = @site_home_page.click_link_on_toolbar(:pricing_server)
      expect(page).to be_a TestingSiteOnlyoffice::SitePriceServerEnterprise
      page = @site_home_page.click_link_on_toolbar(:pricing_enterprise)
      expect(page).to be_a TestingSiteOnlyoffice::SitePriceDocsEnterprise
      page = @site_home_page.click_link_on_toolbar(:pricing_developer)
      expect(page).to be_a TestingSiteOnlyoffice::SitePriceDocsDeveloper
    end

    it '[Site] Check link HelpCenter' do
      help_center_page = @site_home_page.click_help_center
      expect(help_center_page).to be_help_center_site_map_visible
    end

    it '[Site] Check notify about forgot password' do
      @site_home_page.mail_for_forgotten_password.delete_all_messages
      @site_home_page.send_forgot_password_from_sign_in
      expect(TestingSiteOnlyoffice::SiteNotificationHelper.check_site_notification(language: language,
                                                                                   pattern: 'teamlab_pwd_reminder',
                                                                                   module: 'WebStudio',
                                                                                   search: @site_home_page.portal_of_forgotten_password,
                                                                                   mail: @site_home_page.mail_for_forgotten_password,
                                                                                   move_out: true)).to be_truthy
    end

    describe 'Site Downloads' do
      context 'download desktop editors /download-desktop.aspx' do
        before { @desktop_editors_download_page = @site_home_page.click_link_on_toolbar(:desktop_mobile_apps) }

        it '[Download Desktop Editors] /download-desktop.aspx: Windows 10/8.1/8/7 x86 download link works' do
          expect(@desktop_editors_download_page).to be_download_link_alive(:desktop_win_10_86)
        end

        it '[Download Desktop Editors] /download-desktop.aspx: Windows 10/8.1/8/7 x64 download link works' do
          expect(@desktop_editors_download_page).to be_download_link_alive(:desktop_win_10_64)
        end

        it '[Download Desktop Editors] /download-desktop.aspx: Windows XP/Vista x86 download link works' do
          expect(@desktop_editors_download_page).to be_download_link_alive(:desktop_win_xp_86)
        end

        it '[Download Desktop Editors] /download-desktop.aspx: Windows XP/Vista x64 download link works' do
          expect(@desktop_editors_download_page).to be_download_link_alive(:desktop_win_xp_64)
        end

        it '[Download Desktop Editors] /download-desktop.aspx: Mac OS download link works' do
          expect(@desktop_editors_download_page).to be_download_link_alive(:desktop_mac)
        end

        it '[Download Desktop Editors] /download-desktop.aspx: Debian 8, Ubuntu 14.04, 16.04 download link works' do
          expect(@desktop_editors_download_page).to be_download_link_alive(:desktop_deb_new)
          expect(@desktop_editors_download_page).to be_download_link_valid(
            @desktop_editors_download_page.download_xpath(:desktop_deb_new), :deb
          )
        end

        it '[Download Desktop Editors] /download-desktop.aspx: Debian 7, Ubuntu 12.04 download link works' do
          expect(@desktop_editors_download_page).to be_download_link_alive(:desktop_deb_old)
          expect(@desktop_editors_download_page).to be_download_link_valid(
            @desktop_editors_download_page.download_xpath(:desktop_deb_old), :deb
          )
        end

        it '[Download Desktop Editors] /download-desktop.aspx: Centos 7, Redhat 7, Fedora 23, 24 download link works' do
          expect(@desktop_editors_download_page).to be_download_link_alive(:desktop_rpm)
          expect(@desktop_editors_download_page).to be_download_link_valid(
            @desktop_editors_download_page.download_xpath(:desktop_rpm), :rpm
          )
        end

        it '[Download Desktop Editors] /download-desktop.aspx: AppImage' do
          expect(@desktop_editors_download_page).to be_download_link_alive(:desktop_appimage)
        end

        it '[Download Desktop Editors] /download-desktop.aspx: FlatPak' do
          expect(@desktop_editors_download_page).to be_download_link_alive(:desktop_flatpak)
        end

        it '[Download Desktop Editors] /download-desktop.aspx: Snap' do
          expect(@desktop_editors_download_page).to be_download_link_alive(:desktop_snap)
        end

        it '[Download Desktop Editors] /download-desktop.aspx: Windows 10/8.1/8/7 instruction link alive' do
          expect(@desktop_editors_download_page).to be_instruction_link_alive(:desktop_win_10_instruction)
        end

        it '[Download Desktop Editors] /download-desktop.aspx: Windows XP/Vista instruction link alive' do
          expect(@desktop_editors_download_page).to be_instruction_link_alive(:desktop_win_xp_instruction)
        end

        it '[Download Desktop Editors] /download-desktop.aspx: MacOS instruction link alive' do
          expect(@desktop_editors_download_page).to be_instruction_link_alive(:desktop_mac_instruction)
        end

        it '[Download Desktop Editors] /download-desktop.aspx: Debian 8, Ubuntu 14.04, 16.04 instruction link alive' do
          expect(@desktop_editors_download_page).to be_instruction_link_alive(:desktop_deb_new_instruction)
        end

        it '[Download Desktop Editors] /download-desktop.aspx: Debian 7, Ubuntu 12.04 instruction link alive' do
          expect(@desktop_editors_download_page).to be_instruction_link_alive(:desktop_deb_old_instruction)
        end

        it '[Download Desktop Editors] /download-desktop.aspx: Centos 7, Redhat 7, Fedora 23, 24 instruction link alive' do
          expect(@desktop_editors_download_page).to be_instruction_link_alive(:desktop_rpm_instruction)
        end

        it '[Download Desktop Editors] /download-desktop.aspx: AppImage instruction link alive' do
          expect(@desktop_editors_download_page).to be_instruction_link_alive(:desktop_appimage_instruction)
        end

        it '[Download Desktop Editors] /download-desktop.aspx: FlatPak instruction link alive' do
          expect(@desktop_editors_download_page).to be_instruction_link_alive(:desktop_flatpak_instruction)
        end

        it '[Download Desktop Editors] /download-desktop.aspx: Snap instruction link alive' do
          expect(@desktop_editors_download_page).to be_instruction_link_alive(:desktop_snap_instruction)
        end
      end

      context 'download mobile editors /download-desktop.aspx' do
        before do
          @mobile_editors_download_page = @site_home_page.click_link_on_toolbar(:desktop_mobile_apps).open_mobile_apps
        end

        it '[Download Mobile Editors] /download-desktop.aspx: "Get it on Google play" link works' do
          expect(@mobile_editors_download_page).to be_download_link_alive(:mobile_android)
        end

        it '[Download Mobile Editors] /download-desktop.aspx: "Download on the app store" link works' do
          expect(@mobile_editors_download_page).to be_download_link_alive(:mobile_ios)
        end
      end

      describe 'download commercial /download-commercial.aspx' do
        before { @download_commercial_page = @site_home_page.click_link_on_toolbar(:commercial_packages) }

        describe 'workspace' do
          before { @commercial_workspace_page = @download_commercial_page.open_commercial_workspace }

          it_behaves_like 'commercial_installer_download', 'Workspace',
                          TestingSiteOnlyoffice::SiteDownloadData.commercial_workspace_list_type do
            let(:installers_download_page) { @commercial_workspace_page }
          end
        end

        describe 'docs' do
          describe 'Enterprise edition' do
            it_behaves_like 'commercial_installer_download', 'Docs_Enterprise',
                            TestingSiteOnlyoffice::SiteDownloadData.commercial_enterprise_docs_list_type do
              let(:installers_download_page) { @download_commercial_page }
            end
          end

          describe 'Developer edition' do
            it_behaves_like 'commercial_installer_download', 'Docs_Developer',
                            TestingSiteOnlyoffice::SiteDownloadData.commercial_developer_docs_list_type do
              let(:installers_download_page) { @download_commercial_page }
            end
          end
        end
      end

      describe 'download open source /download.aspx' do
        before { @download_opensource_page = @site_home_page.click_link_on_toolbar(:open_source_packages) }

        describe 'open source bundles /download.aspx' do
          before { @opensource_bundles_page = @download_opensource_page.open_opensource_bundles }

          TestingSiteOnlyoffice::SiteDownloadData.open_source_bundles_list.each do |installer|
            it "[Site][DownloadOpenSource][Bundlers] download link for `#{installer}` alive /download.aspx" do
              expect(@opensource_bundles_page).to be_download_link_alive(installer.to_sym)
            end

            it "[Site][DownloadOpenSource][Bundlers] `#{installer}` instruction link alive /download.aspx" do
              expect(@opensource_bundles_page).to be_instruction_link_alive(installer.to_sym)
            end
          end
        end

        describe 'open source groups /download.aspx' do
          before { @opensource_groups_page = @download_opensource_page.open_opensource_groups }

          TestingSiteOnlyoffice::SiteDownloadData.open_source_groups_list.each do |installer|
            it "[Site][DownloadOpenSource][Groups] download link for `#{installer}` alive /download.aspx" do
              expect(@opensource_groups_page).to be_download_link_alive(installer.to_sym)
              expect(@opensource_groups_page).to be_download_link_valid(
                @opensource_groups_page.download_xpath(installer), installer
              )
            end

            it "[Site][DownloadOpenSource][Groups] `#{installer}` instruction link alive /download.aspx" do
              expect(@opensource_groups_page).to be_instruction_link_alive(installer.to_sym)
            end
          end
        end

        describe 'open source docs /download.aspx' do
          TestingSiteOnlyoffice::SiteDownloadData.open_source_docs_list.each do |installer|
            describe installer.to_s do
              before { @current_installation = @download_opensource_page.installer_type_block(installer) }

              it "[Site][DownloadOpenSource][Docs] download link for `#{installer}` alive /download.aspx" do
                expect(@download_opensource_page).to be_link_alive(@current_installation.download_xpath)
              end

              it "[Site][DownloadOpenSource][Docs] `#{installer}` instruction link alive /download.aspx" do
                expect(@download_opensource_page).to be_link_alive(@current_installation.instruction_xpath)
              end
            end
          end

          it '[Site][DownloadOpenSource][Docs] `windows` instruction link valid /download.aspx' do
            windows_installation = @download_opensource_page.installer_type_block(:windows)
            expect(@download_opensource_page).to be_download_link_valid(windows_installation.download_xpath, :windows)
          end
        end
      end

      describe 'debian repo' do
        it 'OnlyOffice Debian repo alive `Release file can be downloaded`, see http://helpcenter.onlyoffice.com/server/linux/community/linux-installation.aspx' do
          debian_repo_response_code = HTTParty.head('http://download.onlyoffice.com/repo/debian/dists/squeeze/Release').response.code
          expect(debian_repo_response_code).to match(/^2\d{2}$/), 'link http://download.onlyoffice.com/repo/debian/dists/squeeze/Release dead' \
                                                                  "\nhead request response code: #{debian_repo_response_code}"
        end

        it 'OnlyOffice Debian repo alive `InRelease file can be downloaded`, see http://helpcenter.onlyoffice.com/server/linux/community/linux-installation.aspx' do
          debian_repo_response_code = HTTParty.head('http://download.onlyoffice.com/repo/debian/dists/squeeze/InRelease').response.code
          expect(debian_repo_response_code).to match(/^2\d{2}$/), 'link http://download.onlyoffice.com/repo/debian/dists/squeeze/InRelease dead' \
                                                                  "\nhead request response code: #{debian_repo_response_code}"
        end
      end

      describe 'document builder' do
        before do
          builder_page = @site_home_page.click_document_builder
          @download_builder_page = builder_page.click_download_now
        end

        TestingSiteOnlyoffice::SiteDownloadData.document_builder_list.each do |installer|
          describe installer.to_s do
            before do
              @current_installation = @download_builder_page.installer_document_builder_type_block(installer)
            end

            it "[Site][DownloadDocumentBuilder][#{installer}] download link for `#{installer}` alive /document-builder.aspx" do
              expect(@download_builder_page).to be_link_alive(@current_installation.download_xpath)
            end

            it "[Site][DownloadDocumentBuilder][#{installer}] read instruction link for `#{installer}` alive /document-builder.aspx" do
              expect(@download_builder_page).to be_link_alive(@current_installation.instruction_xpath)
            end
          end
        end

        it_behaves_like 'document_builder_version_and_realise_date', TestingSiteOnlyoffice::SiteDownloadData.document_builder_list do
          let(:installers_download_page) { @download_builder_page }
        end
      end

      describe '#download_connectors' do
        before do
          @connectors_page = @site_home_page.click_link_on_toolbar(:open_source_packages).open_opensource_connectors
        end

        TestingSiteOnlyoffice::SiteDownloadData.connectors_list.each do |connector|
          it "[Site][DownloadConnectors] download link `#{connector}` alive /download.aspx" do
            expect(@connectors_page).to be_download_link_alive(connector.to_sym)
          end

          it "[Site][DownloadConnectors]`#{connector}` instruction link alive /download.aspx" do
            expect(@connectors_page).to be_instruction_link_alive(connector.to_sym)
          end

          it "[Site][DownloadConnectors] release info for `#{connector}` on site matches github data /download.aspx" do
            site_data = TestingSiteOnlyoffice::SiteConnectorReleaseData.new(version: @connectors_page.site_version(connector),
                                                                            date: @connectors_page.site_date(connector))
            github_data = TestingSiteOnlyoffice::SiteConnectorReleaseData.new(version: @connectors_page.github_version(connector),
                                                                              date: @connectors_page.github_date(connector))
            error = @connectors_page.error_message(connector: connector, github_date: github_data.date,
                                                   github_version: github_data.version, site_date: site_data.date, site_version: site_data.version)
            expect(github_data == site_data).to be_truthy, error
          end
        end
      end
    end

    context 'BLOG' do
      before { @blog_page = @site_home_page.click_link_on_toolbar(:blog) }

      it '[BLOG] Check click Blog link' do
        expect(@blog_page).to be_a TestingSiteOnlyoffice::SiteBlog
      end

      it '[BLOG] Check click Home logo' do
        pending('Home logo button doesnt work for blog page')
        home_page = @blog_page.click_home_logo
        expect(home_page).to be_a TestingSiteOnlyoffice::SiteHomePage
      end
    end
  end

  after do |example|
    testrail&.add_result_to_test_case example
    @test&.webdriver&.quit
    @test&.webdriver&.quit
    WebDriver.clean_up

    unless OnlyofficeFileHelper::RubyHelper.debug?
      fail = example.exception
      if fail && run_name == example.description && !run_name.include?('[Info]') && !TeamlabFailNotifier.should_be_ignored?(example)
        message_body = "#{test_run}\n#{run_name}\n#{fail}\n#{testrail&.run&.url}"
        message_report = { subject: '[Error] Site Hourly', body: message_body }
        they_want_to_know = %w[nct.tester@yandex.ru test.teamlab@yandex.ru shockwavenn@gmail.com
                               denis.spitsyn.nct@gmail.com]
        they_want_to_know.push('alexey.safronov@onlyoffice.com') if run_name.include?('[Mail][Socket.IO]')
        TeamlabFailNotifier.send(message_body)
        Gmail_helper.new('onlyoffice.daily.report@gmail.com', 'onlyoffice.daily.report1').send_mail(they_want_to_know,
                                                                                                    message_report[:subject], message_report[:body])
      end
      run_name = example.description
    end
  end
end
