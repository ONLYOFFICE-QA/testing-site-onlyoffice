# frozen_string_literal: true

require 'spec_helper'

describe 'SiteHourlyCheck' do
  test_run = "Site Hourly Checks version: #{TestingSiteOnlyoffice::SiteVersionHelper.full_site_version}, time: #{Time.new}, region: #{config.region}"
  test_manager = TestingSiteOnlyoffice::TestManager.new(suite_name: File.basename(__FILE__), plan_name: test_run, plan_name_testrail: test_run, product_name: 'Site Hourly Check')

  after do |example|
    test_manager&.add_result(example, @test)
    @test&.webdriver&.quit

    if TestingSiteOnlyoffice::TeamlabFailNotifier.should_be_notified?(example)
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
      docspace_main_page = @site_home_page.click_link_on_toolbar(:features_docspace)
      docspace_registration_page = docspace_main_page.click_registration_button
      expect(docspace_registration_page).to be_a TestingSiteOnlyoffice::SiteDocSpaceSignUp
    end

    describe '[Site] Check Features' do
      it '[Site] Check Features document overview' do
        page = @site_home_page.click_link_on_toolbar(:features_document_overview)
        expect(page).to be_a TestingSiteOnlyoffice::SiteFeaturesDocsOverview
      end

      it '[Site] Check Features document editor' do
        page = @site_home_page.click_document_editor
        expect(page).to be_a TestingSiteOnlyoffice::SiteFeaturesDocumentEditor
      end

      it '[Site] Check Features spreadsheet editor' do
        page = @site_home_page.click_spreadsheet_editor
        expect(page).to be_a TestingSiteOnlyoffice::SiteFeaturesSpreadsheetEditor
      end

      it '[Site] Check Features presentation editor' do
        page = @site_home_page.click_presentation_editor
        expect(page).to be_a TestingSiteOnlyoffice::SiteFeaturesPresentationEditor
      end

      it '[Site] Check Features form creator' do
        page = @site_home_page.click_form_creator
        expect(page).to be_a TestingSiteOnlyoffice::SiteFeaturesFormCreator
      end

      it '[Site] Check Features PDF reader and converter' do
        page = @site_home_page.click_pdf_reader_converter
        expect(page).to be_a TestingSiteOnlyoffice::SiteFeaturesPDFReaderConverter
      end

      it '[Site] Check Features desktop windows' do
        page = @site_home_page.click_link_on_toolbar(:features_desktop)
        expect(page).to be_a TestingSiteOnlyoffice::SiteFeaturesDesktop
      end

      it '[Site] Check Features ios' do
        page = @site_home_page.click_link_on_toolbar(:features_ios)
        expect(page).to be_a TestingSiteOnlyoffice::SiteFeaturesIos
      end

      it '[Site] Check Features android' do
        page = @site_home_page.click_link_on_toolbar(:features_android)
        expect(page).to be_a TestingSiteOnlyoffice::SiteFeaturesAndroid
      end

      it '[Site] Check Oforms' do
        page = @site_home_page.click_link_on_toolbar(:features_oforms)
        expect(page).to be_a TestingSiteOnlyoffice::SiteFeaturesOforms
      end
    end

    it '[Site] Check cloud' do
      page = @site_home_page.click_link_on_toolbar(:pricing_enterprise)
      expect(page).to be_a TestingSiteOnlyoffice::SitePriceDocsEnterprise
      page = @site_home_page.click_link_on_toolbar(:pricing_docspace)
      expect(page).to be_a TestingSiteOnlyoffice::SitePricingDocSpacePrices
      page = @site_home_page.click_link_on_toolbar(:pricing_developer)
      expect(page).to be_a TestingSiteOnlyoffice::SitePriceDocsDeveloper
      page = @site_home_page.click_link_on_toolbar(:pricing_workspace)
      expect(page).to be_a TestingSiteOnlyoffice::SitePricingWorkSpace
    end

    it '[Site] Check link HelpCenter' do
      help_center_page = @site_home_page.click_link_on_toolbar(:about_help_center)
      expect(help_center_page).to be_help_center_site_map_visible
    end

    it '[Site] Check notify about forgot password' do
      pending('awaiting the fix of test mailboxes')
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
        let(:desktop_app_page) { @site_home_page.click_link_on_toolbar(:get_onlyoffice_desktop_mobile) }

        it_behaves_like 'desktop_installer_download', TestingSiteOnlyoffice::SiteDownloadData.desktop_download_list_type do
          let(:installers_download_page) { desktop_app_page }
        end
      end

      describe 'download mobile editors /download-desktop.aspx' do
        let(:mobile_editors_download_page) { @site_home_page.click_link_on_toolbar(:get_onlyoffice_desktop_mobile).open_mobile_apps }

        it '[Download Mobile Editors] /download-desktop.aspx: "Get it on Google play" link works' do
          expect(mobile_editors_download_page).to be_download_link_alive(:mobile_android)
        end

        it '[Download Mobile Editors] /download-desktop.aspx: "Download on the app store" link works' do
          expect(mobile_editors_download_page).to be_download_link_alive(:mobile_ios)
        end

        it 'Download Mobile Editors] /download-desktop.aspx: "Explore it on AppGallery" link works' do
          mobile_editors_download_page.open_mobile_app_gallery
          expect(mobile_editors_download_page.check_opened_page_title).to include(TestingSiteOnlyoffice::SiteDownloadData::MOBILE_DOCUMENTS_APP_GALLERY)
        end
      end

      describe 'download onlyoffice docs /download-docs.aspx' do
        let(:onlyoffice_docs_enterprise_page) { @site_home_page.click_link_on_toolbar(:get_onlyoffice_docs_enterprise) }

        describe 'enterprise' do
          it_behaves_like 'commercial_installer_download', 'Docs_Enterprise',
                          TestingSiteOnlyoffice::SiteDownloadData.commercial_enterprise_docs_list_type do
            let(:installers_download_page) { onlyoffice_docs_enterprise_page }
          end
        end

        describe 'developer' do
          let(:onlyoffice_docs_developer_page) { @site_home_page.click_link_on_toolbar(:get_onlyoffice_docs_developer) }

          it_behaves_like 'commercial_installer_download', 'Docs_Developer',
                          TestingSiteOnlyoffice::SiteDownloadData.commercial_developer_docs_list_type do
            let(:installers_download_page) { onlyoffice_docs_developer_page }
          end
        end

        describe 'community' do
          let(:onlyoffice_docs_community_page) { @site_home_page.click_link_on_toolbar(:get_onlyoffice_docs_community) }

          TestingSiteOnlyoffice::SiteDownloadData.open_source_docs_list.each do |installer|
            describe installer.to_s do
              let(:current_installation) { onlyoffice_docs_community_page.installer_type_block(installer) }

              it "[Site][Docs_Community] download link for `#{installer}` alive /download-docs.aspx#docs-community" do
                skip 'due to excessively long file download time' if installer == :windows
                skip 'due to API protections causing a 403 error' if installer == :vultr
                current_installation.click_install_button
                expect(onlyoffice_docs_community_page).to be_install_button_works(installer)
              end

              it "[Site][Docs_Community] `#{installer}` instruction link alive /download-docs.aspx#docs-community" do
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
        let(:onlyoffice_workspace_page) { @site_home_page.click_link_on_toolbar(:get_onlyoffice_workspace_on_premises) }

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

      describe 'connectors' do
        it_behaves_like 'connector_download', TestingSiteOnlyoffice::SiteDownloadData.connectors_info.keys do
          let(:connectors_page) { @site_home_page.click_link_on_toolbar(:get_onlyoffice_connectors) }
        end
      end

      describe 'document builder' do
        let(:other_products_document_builder_page) { @site_home_page.click_link_on_toolbar(:get_onlyoffice_document_builder) }

        it_behaves_like 'document_builder_download',
                        TestingSiteOnlyoffice::SiteDownloadData.document_builder_list do
          let(:installers_download_page) { other_products_document_builder_page }
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
        expect(blog_page).to be_a TestingSiteOnlyoffice::SiteAboutBlog
      end

      it '[BLOG] Check click Home logo' do
        home_page = blog_page.click_home_logo
        expect(home_page).to be_a TestingSiteOnlyoffice::SiteHomePage
      end
    end

    describe 'Сhecking for a product version logging error' do
      before do
        @download_commercial_page = @site_home_page.click_link_on_toolbar(:get_onlyoffice_docs_enterprise)
      end

      it_behaves_like 'сhecking_logger_errors' do
        let(:сhecking_logger_errors) { @download_commercial_page }
      end
    end
  end
end
