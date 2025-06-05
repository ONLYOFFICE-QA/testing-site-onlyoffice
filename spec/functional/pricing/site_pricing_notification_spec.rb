# frozen_string_literal: true

require 'spec_helper'

describe 'Pricing Get a quote notification email' do
  test_manager = TestingSiteOnlyoffice::TestManager.new(suite_name: File.basename(__FILE__))

  before do
    @site_home_page, @test = TestingSiteOnlyoffice::SiteHelper.new.open_page_teamlab_office(config)
    @username = TestingSiteOnlyoffice::SiteData::PARTNERS_EMAIL
    @mail = OnlyofficeIredmailHelper::IredMailHelper.new(username: @username)
  end

  after do |example|
    test_manager.add_result(example, @test)
    @test.webdriver.quit
  end

  describe 'Check email notification for DocSpace' do
    TestingSiteOnlyoffice::SiteDownloadData.pricing_page_data[:support_level].each do |level|
      it "Send notification email for #{level} support, More connections, Support multi-server and Training courses" do
        skip 'Cannot test email notifications in production' if config.server.include?('.com')
        pricing_page = @site_home_page.click_link_on_toolbar(:pricing_docspace)
        pricing_page.click_enterprise_on_premises
        pricing_page.fill_data_pricing_page(level, number_connection: 'More', support_multi: true, training_course: true)
        phone_number = Faker::PhoneNumber.cell_phone_in_e164
        company_name = Faker::Company.name
        mail_subject = "#{company_name} - DocSpace Enterprise Request [from: docspace-prices]"
        pricing_page.complete_pricing_page_form(phone_number:, company_name:)
        expect(@mail.check_pricing_docspace_mail_body(username: @username,
                                                      subject: mail_subject,
                                                      phone_number:,
                                                      company_name:,
                                                      level:,
                                                      users_number: 'More',
                                                      support_multi: true,
                                                      training_course: true,
                                                      move_out: true)).to be_truthy
      end

      it "Send notification email for #{level} support, More connections" do
        skip 'Cannot test email notifications in production' if config.server.include?('.com')
        pricing_page = @site_home_page.click_link_on_toolbar(:pricing_docspace)
        pricing_page.click_enterprise_on_premises
        pricing_page.fill_data_pricing_page(level, number_connection: 'More')
        phone_number = Faker::PhoneNumber.cell_phone_in_e164
        company_name = Faker::Company.name
        mail_subject = "#{company_name} - DocSpace Enterprise Request [from: docspace-prices]"
        pricing_page.complete_pricing_page_form(phone_number:, company_name:)
        expect(@mail.check_pricing_docspace_mail_body(username: @username,
                                                      subject: mail_subject,
                                                      phone_number:,
                                                      company_name:,
                                                      level:,
                                                      users_number: 'More',
                                                      move_out: true)).to be_truthy
      end
    end
  end

  describe 'Check email notification for Docs Enterprise' do
    TestingSiteOnlyoffice::SiteDownloadData.pricing_page_data[:docs_enterprise_license_duration].each do |duration|
      TestingSiteOnlyoffice::SiteDownloadData.pricing_page_data[:support_level].each do |level|
        it "Send notification email for #{duration} #{level} support, More connections, Support disaster recovery, Support multi-server and Training courses" do
          skip 'Cannot test email notifications in production' if config.server.include?('.com')
          pricing_page = @site_home_page.click_link_on_toolbar(:pricing_enterprise)
          pricing_page.fill_data_pricing_page(level, number_connection: 'More', support_recovery: true, support_multi: true, training_course: true)
          pricing_page.activate_license(duration)
          phone_number = Faker::PhoneNumber.cell_phone_in_e164
          company_name = Faker::Company.name
          mail_subject = "#{company_name} - Docs Enterprise Request (On-premises) [from: docs-enterprise-prices]"
          pricing_page.complete_pricing_page_form(phone_number:, company_name:)
          expect(@mail.check_pricing_enterprise_mail_body(username: @username,
                                                          subject: mail_subject,
                                                          phone_number:,
                                                          company_name:,
                                                          level:,
                                                          duration:,
                                                          users_number: 'More',
                                                          support_recovery: true,
                                                          support_multi: true,
                                                          training_course: true,
                                                          move_out: true)).to be_truthy
        end

        it "Send notification email for #{duration} #{level} support, More connections" do
          skip 'Cannot test email notifications in production' if config.server.include?('.com')
          pricing_page = @site_home_page.click_link_on_toolbar(:pricing_enterprise)
          pricing_page.fill_data_pricing_page(level, number_connection: 'More')
          pricing_page.activate_license(duration)
          phone_number = Faker::PhoneNumber.cell_phone_in_e164
          company_name = Faker::Company.name
          mail_subject = "#{company_name} - Docs Enterprise Request (On-premises) [from: docs-enterprise-prices]"
          pricing_page.complete_pricing_page_form(phone_number:, company_name:)
          expect(@mail.check_pricing_enterprise_mail_body(username: @username,
                                                          subject: mail_subject,
                                                          phone_number:,
                                                          company_name:,
                                                          level:,
                                                          duration:,
                                                          users_number: 'More',
                                                          move_out: true)).to be_truthy
        end
      end
    end
    describe 'Check Docs Enterprise cloud notification' do
      TestingSiteOnlyoffice::SiteDownloadData.pricing_page_data[:docs_enterprise_cloud_type].each do |type|
        TestingSiteOnlyoffice::SiteDownloadData.pricing_page_data[:support_level].each do |level|
          it "Send notification email for #{type} #{level} support, Training courses" do
            skip 'Cannot test email notifications in production' if config.server.include?('.com')
            pricing_page = @site_home_page.click_link_on_toolbar(:pricing_enterprise)
            pricing_page.click_cloud
            pricing_page.fill_data_pricing_page(level, training_course: true)
            pricing_page.choose_cloud_type(type)
            phone_number = Faker::PhoneNumber.cell_phone_in_e164
            company_name = Faker::Company.name
            mail_subject = "#{company_name} - Docs Enterprise Request (Cloud) [from: docs-enterprise-prices]"
            pricing_page.complete_pricing_page_form(phone_number:, company_name:)
            expect(@mail.check_pricing_enterprise_cloud_mail_body(username: @username,
                                                                  subject: mail_subject,
                                                                  phone_number:,
                                                                  company_name:,
                                                                  level:,
                                                                  type:,
                                                                  training_course: true,
                                                                  move_out: true)).to be_truthy
          end
        end
      end
    end
  end

  describe 'Check email notification for Docs Developer Cloud' do
    TestingSiteOnlyoffice::SiteDownloadData.pricing_page_data[:support_level].each do |level|
      it "Send notification email for #{level} support and all additional tools selected" do
        skip 'Cannot test email notifications in production' if config.server.include?('.com')
        pricing_page = @site_home_page.click_link_on_toolbar(:pricing_developer)
        pricing_page.choose_hosting_on_cloud
        pricing_page.fill_data_pricing_developer_cloud(level, { training_course: true, access_to_api: true, live_viewer: true, mobile_apps: true, desktop_apps: true })
        phone_number = Faker::PhoneNumber.cell_phone_in_e164
        company_name = Faker::Company.name
        mail_subject = "#{company_name} - Docs Developer Request (Cloud) [from: developer-edition-prices]"
        pricing_page.complete_pricing_page_form(phone_number:, company_name:)
        expect(@mail.check_pricing_docs_developers_cloud_mail_body(username: @username,
                                                                   subject: mail_subject,
                                                                   phone_number:,
                                                                   company_name:,
                                                                   level:,
                                                                   training_course: true,
                                                                   access_to_api: true,
                                                                   live_viewer: true,
                                                                   mobile_apps: true,
                                                                   desktop_apps: true,
                                                                   move_out: true)).to be_truthy
      end
    end

    it 'Send a notification email for default support level with no additional tools are selected' do
      skip 'Cannot test email notifications in production' if config.server.include?('.com')
      pricing_page = @site_home_page.click_link_on_toolbar(:pricing_developer)
      pricing_page.choose_hosting_on_cloud
      level = 'Plus'
      phone_number = Faker::PhoneNumber.cell_phone_in_e164
      company_name = Faker::Company.name
      mail_subject = "#{company_name} - Docs Developer Request (Cloud) [from: developer-edition-prices]"
      pricing_page.complete_pricing_page_form(phone_number:, company_name:)
      expect(@mail.check_pricing_docs_developers_cloud_mail_body(username: @username,
                                                                 subject: mail_subject,
                                                                 phone_number:,
                                                                 company_name:,
                                                                 level:,
                                                                 move_out: true)).to be_truthy
    end
  end

  describe 'Check email notification for Docs Developer On-premises' do
    TestingSiteOnlyoffice::SiteDownloadData.pricing_page_data[:support_level].each do |level|
      TestingSiteOnlyoffice::SiteDownloadData.pricing_page_data[:docs_developers_branding_type].each do |type|
        it "Send notification email for #{type} branding, #{level} support, all licensing purposes and all additional tools selected" do
          skip 'Cannot test email notifications in production' if config.server.include?('.com')
          pricing_page = @site_home_page.click_link_on_toolbar(:pricing_developer)
          all_options = TestingSiteOnlyoffice::SiteData.pricing_dev_all_available_options_selected
          pricing_page.choose_hosting_on_premises
          pricing_page.fill_data_pricing_developer_premises(level, type, all_options)
          phone_number = Faker::PhoneNumber.cell_phone_in_e164
          company_name = Faker::Company.name
          mail_subject = "#{company_name} - Docs Developer Request (On-premises) [from: developer-edition-prices]"
          pricing_page.complete_pricing_page_form(phone_number:, company_name:)
          expect(@mail.check_pricing_docs_developers_premises_mail_body(
                   username: @username,
                   subject: mail_subject,
                   phone_number:,
                   company_name:,
                   level:,
                   branding_type: type,
                   **all_options,
                   move_out: true
                 )).to be_truthy
        end
      end
    end
  end
end
