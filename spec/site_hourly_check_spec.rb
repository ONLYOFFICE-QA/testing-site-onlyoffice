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

    it '[Site] Check link Personal Offices' do
      tour_page = @site_home_page.footer_home_use.open_personal
      expect(tour_page.login_visible?).to be true
    end

    describe '[Site] Check Products' do
      it '[Site] Check Products docs' do
        page = @site_home_page.click_link_on_toolbar(:products_docs)
        expect(page).to be_a TestingSiteOnlyoffice::SiteProductsDocs
      end

      it '[Site] Check Products document editor' do
        page = @site_home_page.click_link_on_toolbar(:products_document_editor)
        expect(page).to be_a TestingSiteOnlyoffice::SiteProductsDocumentEditor
      end

      it '[Site] Check Products spreadsheet editor' do
        page = @site_home_page.click_link_on_toolbar(:products_spreadsheet_editor)
        expect(page).to be_a TestingSiteOnlyoffice::SiteProductsSpreadsheetEditor
      end

      it '[Site] Check Products presentation editor' do
        page = @site_home_page.click_link_on_toolbar(:products_presentation_editor)
        expect(page).to be_a TestingSiteOnlyoffice::SiteProductsPresentationEditor
      end

      it '[Site] Check Products form creator' do
        page = @site_home_page.click_link_on_toolbar(:products_form_creator)
        expect(page).to be_a TestingSiteOnlyoffice::SiteProductsFormCreator
      end

      it '[Site] Check Products desktop' do
        page = @site_home_page.click_link_on_toolbar(:products_desktop)
        expect(page).to be_a TestingSiteOnlyoffice::SiteProductsDesktop
      end

      it '[Site] Check Products ios' do
        page = @site_home_page.click_link_on_toolbar(:products_ios)
        expect(page).to be_a TestingSiteOnlyoffice::SiteProductsIos
      end

      it '[Site] Check Products android' do
        page = @site_home_page.click_link_on_toolbar(:products_android)
        expect(page).to be_a TestingSiteOnlyoffice::SiteProductsAndroid
      end

      it '[Site] Check Products workspace' do
        page = @site_home_page.click_link_on_toolbar(:products_workspace)
        expect(page).to be_a TestingSiteOnlyoffice::SiteProductsWorkspace
      end

      it '[Site] Check Products workspace documents' do
        page = @site_home_page.click_link_on_toolbar(:products_workspace_documents)
        expect(page).to be_a TestingSiteOnlyoffice::SiteProductsDocumentManager
      end

      it '[Site] Check Products workspace mail' do
        page = @site_home_page.click_link_on_toolbar(:products_workspace_mail)
        expect(page).to be_a TestingSiteOnlyoffice::SiteProductsMail
      end

      it '[Site] Check Products workspace crm' do
        page = @site_home_page.click_link_on_toolbar(:products_workspace_crm)
        expect(page).to be_a TestingSiteOnlyoffice::SiteProductsCRM
      end

      it '[Site] Check Products workspace projects' do
        page = @site_home_page.click_link_on_toolbar(:products_workspace_projects)
        expect(page).to be_a TestingSiteOnlyoffice::SiteProductsProjects
      end

      it '[Site] Check Products workspace calendar' do
        page = @site_home_page.click_link_on_toolbar(:products_workspace_calendar)
        expect(page).to be_a TestingSiteOnlyoffice::SiteProductsCalendar
      end
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
      help_center_page = @site_home_page.click_link_on_toolbar(:about_help_center)
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
          expect(mobile_editors_download_page.check_opened_page_title).to be_include(TestingSiteOnlyoffice::SiteDownloadData::MOBILE_APP_GALLERY)
        end
      end

      describe 'download onlyoffice docs /download-docs.aspx' do
        let(:onlyoffice_docs_page) { @site_home_page.click_link_on_toolbar(:onlyoffice_docs_download) }

        describe 'enterprise' do
          it_behaves_like 'commercial_installer_download', 'Docs_Enterprise',
                          TestingSiteOnlyoffice::SiteDownloadData.commercial_enterprise_docs_list_type do
            let(:installers_download_page) { onlyoffice_docs_page }
          end
        end

        describe 'developer' do
          let(:onlyoffice_docs_developer_page) { onlyoffice_docs_page.site_docs_developer_download }

          it_behaves_like 'commercial_installer_download', 'Docs_Developer',
                          TestingSiteOnlyoffice::SiteDownloadData.commercial_developer_docs_list_type do
            let(:installers_download_page) { onlyoffice_docs_developer_page }
          end
        end

        describe 'community' do
          let(:onlyoffice_docs_community_page) { onlyoffice_docs_page.site_docs_community_download }

          TestingSiteOnlyoffice::SiteDownloadData.open_source_docs_list.each do |installer|
            describe installer.to_s do
              let(:current_installation) { onlyoffice_docs_community_page.installer_type_block(installer) }

              it "[Site][Docs_Community] download link for `#{installer}` alive /download-docs.aspx#docs-community" do
                skip('https://t.me/c/1440851975/7137') if installer.to_s == 'digitalocean'
                expect(onlyoffice_docs_community_page).to be_link_alive(current_installation.download_xpath)
              end

              it "[Site][Docs_Community] `#{installer}` instruction link alive /download-docs.aspx#docs-community" do
                skip('https://t.me/c/1440851975/7137') if installer.to_s == 'digitalocean'
                expect(onlyoffice_docs_community_page).to be_link_alive(current_installation.instruction_xpath)
              end
            end
          end

          it '[Site][DownloadOpenSource][Docs] `windows` instruction link valid /download.aspx' do
            windows_installation = onlyoffice_docs_community_page.installer_type_block(:windows)
            expect(onlyoffice_docs_community_page).to be_download_link_valid(windows_installation.download_xpath, :windows)
          end
        end
      end

      describe 'download onlyoffice workspace /download-workspace.aspx' do
        let(:onlyoffice_workspace_page) { @site_home_page.click_link_on_toolbar(:onlyoffice_workspace) }

        describe 'enterprice' do
          it_behaves_like 'commercial_installer_download', 'Workspace_Enterprise',
                          TestingSiteOnlyoffice::SiteDownloadData.commercial_workspace_list_type do
            let(:installers_download_page) { onlyoffice_workspace_page }
          end
        end

        describe 'community' do
          let(:onlyoffice_workspace_community_page) { onlyoffice_workspace_page.site_workspace_community_download }

          TestingSiteOnlyoffice::SiteDownloadData.workspace_community.each do |installer|
            it "[Site][WorkspaceCommunity] Check `#{installer}` 'Read instructions' link /download-workspace.aspx#workspace-community" do
              onlyoffice_workspace_community_page.read_instruction_connector(installer)
              instruction_title = TestingSiteOnlyoffice::SiteDownloadData.open_source_bundlers_info[installer.to_s]['instruction']
              expect(onlyoffice_workspace_community_page.check_opened_page_title).to eq(instruction_title)
            end

            it "[Site][WorkspaceCommunity] Check `#{installer}` 'Install now' link /download-workspace.aspx#workspace-community" do
              skip('https://t.me/c/1440851975/7137') if installer.to_s == 'workspace_digitalocean'
              expect(onlyoffice_workspace_community_page).to be_file_can_be_downloaded(installer)
            end
          end
        end
      end

      describe 'download other products /download.aspx' do
        let(:other_products_page) { @site_home_page.click_link_on_toolbar(:other_products) }

        describe 'connectors' do
          it_behaves_like 'connector_download', TestingSiteOnlyoffice::SiteDownloadData.connectors_list do
            let(:connectors_page) { other_products_page }
          end
        end

        describe 'groups' do
          let(:other_products_groups_page) { other_products_page.site_other_products_onlyoffice_groups_download }

          TestingSiteOnlyoffice::SiteDownloadData.open_source_groups_list.each do |installer|
            it "[Site][OtherProducts][Groups] Check `#{installer}` download link /download.aspx#groups" do
              expect(other_products_groups_page).to be_download_link_alive(installer)
              expect(other_products_groups_page).to be_download_link_valid(other_products_groups_page.download_xpath(installer), installer)
            end

            it "[Site][OtherProducts][Groups] Check `#{installer}`'Read instructions' link /download.aspx#groups" do
              other_products_groups_page.click_groups_instruction_link(installer)
              instruction_title = TestingSiteOnlyoffice::SiteDownloadData.open_source_groups_info[installer.to_s]['instruction']
              expect(other_products_groups_page.check_opened_page_title).to eq(instruction_title)
            end
          end
        end

        describe 'bundles' do
          let(:other_products_bundles_page) { other_products_page.site_other_products_bundles_download }

          TestingSiteOnlyoffice::SiteDownloadData.other_products_bundles_list.each do |installer|
            it "[Site][OtherProducts][Bundlers] Check `#{installer}` 'Read instructions' link /download.aspx#bundles" do
              other_products_bundles_page.read_instruction_connector(installer)
              instruction_title = TestingSiteOnlyoffice::SiteDownloadData.open_source_bundlers_info[installer.to_s]['instruction']
              expect(other_products_bundles_page.check_opened_page_title).to eq(instruction_title)
            end

            it "[Site][OtherProducts][Bundlers] Check `#{installer}` 'Install now' link /download.aspx#bundles" do
              expect(other_products_bundles_page).to be_file_can_be_downloaded(installer)
            end
          end
        end

        describe 'document builder' do
          let(:other_products_document_builder_page) { other_products_page.site_other_products_document_builder_download }

          it_behaves_like 'document_builder_download',
                          TestingSiteOnlyoffice::SiteDownloadData.document_builder_list do
            let(:installers_download_page) { other_products_document_builder_page }
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
    end

    describe 'BLOG' do
      let(:blog_page) { @site_home_page.click_link_on_toolbar(:about_blog) }

      it '[BLOG] Check click Blog link' do
        expect(blog_page).to be_a TestingSiteOnlyoffice::SiteBlog
      end

      it '[BLOG] Check click Home logo' do
        home_page = blog_page.click_home_logo
        expect(home_page).to be_a TestingSiteOnlyoffice::SiteHomePage
      end
    end

    describe 'Сhecking for a product version logging error' do
      before do
        @download_commercial_page = @site_home_page.click_link_on_toolbar(:onlyoffice_docs_download)
      end

      it_behaves_like 'сhecking_logger_errors' do
        let(:сhecking_logger_errors) { @download_commercial_page }
      end
    end
  end
end
