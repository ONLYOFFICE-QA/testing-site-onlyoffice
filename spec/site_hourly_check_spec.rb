# frozen_string_literal: true

require 'spec_helper'

describe 'SiteHourlyCheck' do
  test_run = "Site Hourly Checks version: #{TestingSiteOnlyoffice::SiteVersionHelper.full_site_version}, time: #{Time.new}, region: #{config.region}"
  test_manager = TestingSiteOnlyoffice::TestManager.new(suite_name: File.basename(__FILE__), plan_name: test_run, plan_name_testrail: test_run, product_name: 'Site Hourly Check')

  after do |example|
    test_manager&.add_result(example, @test)
    @test&.webdriver&.quit
    WebDriver.clean_up

    unless OnlyofficeFileHelper::RubyHelper.debug?
      fail = example.exception
      if fail
        message_body = "#{test_run}\n#{example.description}\n#{fail}\n#{test_manager&.testrail&.run&.url}"
        TestingSiteOnlyoffice::TeamlabFailNotifier.send(message_body)
      end
    end
  end

  describe 'Site onlyoffice.com' do
    before do
      @site_home_page, @test = TestingSiteOnlyoffice::SiteHelper.new.open_page_teamlab_office(config)
    end

    it '[Site] Check exists languages' do
      expect(@site_home_page.get_all_language_from_site.sort).to eq(TestingSiteOnlyoffice::SiteData.site_languages.sort)
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
      page = @site_home_page.click_link_on_toolbar(:products_connectors)
      expect(page).to be_a TestingSiteOnlyoffice::SiteProductsConnectorsOnlyoffice
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
      @site_home_page.send_forgot_password_from_sign_in
      expect(TestingSiteOnlyoffice::SiteNotificationHelper.check_site_notification(language: config.language,
                                                                                   pattern: 'teamlab_pwd_reminder',
                                                                                   module: 'WebStudio',
                                                                                   search: @site_home_page.portal_for_hourly_forgotten_password,
                                                                                   mail: @site_home_page.mail_for_forgotten_password,
                                                                                   move_out: true)).to be_truthy
    end

    describe 'Site Downloads' do
      describe 'download desktop editors /download-desktop.aspx' do
        let(:desktop_app_page) { @site_home_page.click_link_on_toolbar(:desktop_mobile_apps) }

        it_behaves_like 'desktop_installer_download', TestingSiteOnlyoffice::SiteDownloadData.desktop_download_list_type do
          let(:installers_download_page) { desktop_app_page }
        end
      end

      describe 'download mobile editors /download-desktop.aspx' do
        let(:mobile_editors_download_page) { @site_home_page.click_link_on_toolbar(:desktop_mobile_apps).open_mobile_apps }

        it '[Download Mobile Editors] /download-desktop.aspx: "Get it on Google play" link works' do
          expect(mobile_editors_download_page).to be_download_link_alive(:mobile_android)
        end

        it '[Download Mobile Editors] /download-desktop.aspx: "Download on the app store" link works' do
          expect(mobile_editors_download_page).to be_download_link_alive(:mobile_ios)
        end

        it 'Download Mobile Editors] /download-desktop.aspx: "Explore it on AppGallery" link works' do
          mobile_editors_download_page.site_mobile_appgallery
          expect(mobile_editors_download_page.check_opened_page_title).to eq(TestingSiteOnlyoffice::SiteDownloadData::MOBILE_APP_GALLERY)
        end
      end

      describe 'download commercial /download-commercial.aspx' do
        let(:download_commercial_page) { @site_home_page.click_link_on_toolbar(:commercial_packages) }

        describe 'workspace' do
          let(:commercial_workspace_page) { download_commercial_page.open_commercial_workspace }

          it_behaves_like 'commercial_installer_download', 'Workspace',
                          TestingSiteOnlyoffice::SiteDownloadData.commercial_workspace_list_type do
            let(:installers_download_page) { commercial_workspace_page }
          end
        end

        describe 'docs' do
          describe 'Enterprise edition' do
            it_behaves_like 'commercial_installer_download', 'Docs_Enterprise',
                            TestingSiteOnlyoffice::SiteDownloadData.commercial_enterprise_docs_list_type do
              let(:installers_download_page) { download_commercial_page }
            end
          end

          describe 'Developer edition' do
            it_behaves_like 'commercial_installer_download', 'Docs_Developer',
                            TestingSiteOnlyoffice::SiteDownloadData.commercial_developer_docs_list_type do
              let(:installers_download_page) { download_commercial_page }
            end
          end
        end
      end

      describe 'download open source /download.aspx' do
        let(:download_opensource_page) { @site_home_page.click_link_on_toolbar(:open_source_packages) }

        describe 'open source bundles /download.aspx' do
          let(:opensource_bundles_page) { download_opensource_page.open_opensource_bundles }

          TestingSiteOnlyoffice::SiteDownloadData.open_source_bundles_list.each do |installer|
            it "[Site][DownloadOpenSource][Bundlers] download link for `#{installer}` alive /download.aspx" do
              expect(opensource_bundles_page).to be_download_link_alive(installer.to_sym)
            end

            it "[Site][DownloadOpenSource][Bundlers] `#{installer}` instruction link alive /download.aspx" do
              expect(opensource_bundles_page).to be_instruction_link_alive(installer.to_sym)
            end
          end
        end

        describe 'open source groups /download.aspx' do
          let(:opensource_groups_page) { download_opensource_page.open_opensource_groups }

          TestingSiteOnlyoffice::SiteDownloadData.open_source_groups_list.each do |installer|
            it "[Site][DownloadOpenSource][Groups] download link for `#{installer}` alive /download.aspx" do
              expect(opensource_groups_page).to be_download_link_alive(installer.to_sym)
              expect(opensource_groups_page).to be_download_link_valid(
                opensource_groups_page.download_xpath(installer), installer
              )
            end

            it "[Site][DownloadOpenSource][Groups] `#{installer}` instruction link alive /download.aspx" do
              expect(opensource_groups_page).to be_instruction_link_alive(installer.to_sym)
            end
          end
        end

        describe 'open source docs /download.aspx' do
          TestingSiteOnlyoffice::SiteDownloadData.open_source_docs_list.each do |installer|
            describe installer.to_s do
              let(:current_installation) { download_opensource_page.installer_type_block(installer) }

              it "[Site][DownloadOpenSource][Docs] download link for `#{installer}` alive /download.aspx" do
                expect(download_opensource_page).to be_link_alive(current_installation.download_xpath)
              end

              it "[Site][DownloadOpenSource][Docs] `#{installer}` instruction link alive /download.aspx" do
                expect(download_opensource_page).to be_link_alive(current_installation.instruction_xpath)
              end
            end
          end

          it '[Site][DownloadOpenSource][Docs] `windows` instruction link valid /download.aspx' do
            windows_installation = download_opensource_page.installer_type_block(:windows)
            expect(download_opensource_page).to be_download_link_valid(windows_installation.download_xpath, :windows)
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
        let(:document_builder_download_page) do
          download_open_source_page = @site_home_page.click_link_on_toolbar(:open_source_packages)
          download_open_source_page.open_opensource_document_builder
        end

        it_behaves_like 'document_builder_download',
                        TestingSiteOnlyoffice::SiteDownloadData.document_builder_list do
          let(:installers_download_page) { document_builder_download_page }
        end
      end

      describe '#download_connectors' do
        let(:site_connectors_page) { @site_home_page.click_link_on_toolbar(:open_source_packages).open_opensource_connectors }

        it_behaves_like 'connector_download', TestingSiteOnlyoffice::SiteDownloadData.connectors_list do
          let(:connectors_page) { site_connectors_page }
        end
      end
    end

    describe 'BLOG' do
      let(:blog_page) { @site_home_page.click_link_on_toolbar(:blog) }

      it '[BLOG] Check click Blog link' do
        expect(blog_page).to be_a TestingSiteOnlyoffice::SiteBlog
      end

      it '[BLOG] Check click Home logo' do
        home_page = blog_page.click_home_logo
        expect(home_page).to be_a TestingSiteOnlyoffice::SiteHomePage
      end
    end
  end
end
