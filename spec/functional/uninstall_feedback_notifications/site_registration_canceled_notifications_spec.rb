# frozen_string_literal: true

require 'spec_helper'
test_manager = TestingSiteOnlyoffice::TestManager.new(suite_name: File.basename(__FILE__))

describe 'Registration canceled feedback page' do
  before do
    site_home_page, @test = TestingSiteOnlyoffice::SiteHelper.new.open_page_teamlab_office(config)
    @registration_canceled_page = site_home_page.open_registration_canceled
    @username = TestingSiteOnlyoffice::SiteData::PARTNERS_EMAIL
    @mail = OnlyofficeIredmailHelper::IredMailHelper.new(username: @username)
  end

  after do |example|
    test_manager.add_result(example, @test)
    @test.webdriver.quit
  end

  it 'Check e-mail from Registration canceled feedback page /registration-canceled.aspx' do
    skip 'Cannot test email notifications in production' if config.server.include?('.com')
    @registration_canceled_page.select_options_registration_canceled(switched_on_premises: true, switched_to_personal: true, technical_problems: true, necessary_features: true, legal_violation: true, rarely_use: true)
    @registration_canceled_page.send_feedback_email_registration_canceled
    mail_subject = 'Request from: registration-canceled'
    expect(@mail.check_registration_canceled_mail_body(username: @username,
                                                       subject: mail_subject,
                                                       switched_on_premises: true,
                                                       switched_to_personal: true,
                                                       technical_problems: true,
                                                       necessary_features: true,
                                                       legal_violation: true,
                                                       rarely_use: true,
                                                       move_out: true)).to be_truthy
  end

  describe 'Checks SLA and Privacy links' do
    let(:page) { @registration_canceled_page }

    it_behaves_like 'check_sla_and_privacy_links'
  end
end
