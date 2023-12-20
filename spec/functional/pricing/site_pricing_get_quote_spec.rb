# frozen_string_literal: true

require 'spec_helper'

describe 'Pricing Get a quote notification email' do
  test_manager = TestingSiteOnlyoffice::TestManager.new(suite_name: File.basename(__FILE__))

  before do
    @site_home_page, @test = TestingSiteOnlyoffice::SiteHelper.new.open_page_teamlab_office(config)
    @mail = OnlyofficeIredmailHelper::IredMailHelper.new(username: 'partners@qamail.teamlab.info',
                                                         password: TestingSiteOnlyoffice::SitePrivateData::PARTNERS_PASSWORD)
  end

  after do |example|
    test_manager.add_result(example, @test)
    @test.webdriver.quit
  end

  describe 'Check email notification for DocSpace' do
    TestingSiteOnlyoffice::SiteDownloadData.pricing_page_data[:support_level].each do |level|
      it "Send notification email for #{level} support, More connections, Support multi-server and Training courses" do
        pricing_page = @site_home_page.click_link_on_toolbar(:pricing_docspace)
        pricing_page.click_enterprise_on_premises
        pricing_page.fill_data_pricing_page('More', level, support_multi: true, training_course: true)
        phone_number = Faker::PhoneNumber.cell_phone_in_e164
        company_name = Faker::Company.name
        mail_subject = "#{company_name} - DocSpace Enterprise Request [from: docspace-prices]"
        pricing_page.complete_pricing_page_form(phone_number:, company_name:)
        expect(@mail.check_partners_mail_by_body(subject: mail_subject, phone_number:, company_name:, level:, support_multi: true, training_course: true, move_out: true)).to be_truthy
      end

      it "Send notification email for #{level} support, More connections" do
        pricing_page = @site_home_page.click_link_on_toolbar(:pricing_docspace)
        pricing_page.click_enterprise_on_premises
        pricing_page.fill_data_pricing_page('More', level)
        phone_number = Faker::PhoneNumber.cell_phone_in_e164
        company_name = Faker::Company.name
        mail_subject = "#{company_name} - DocSpace Enterprise Request [from: docspace-prices]"
        pricing_page.complete_pricing_page_form(phone_number:, company_name:)
        expect(@mail.check_partners_mail_by_body(subject: mail_subject, phone_number:, company_name:, level:, move_out: true)).to be_truthy
      end
    end
  end
end
