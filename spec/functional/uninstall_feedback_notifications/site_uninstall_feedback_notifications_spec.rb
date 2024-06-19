# frozen_string_literal: true

require 'spec_helper'
test_manager = TestingSiteOnlyoffice::TestManager.new(suite_name: File.basename(__FILE__))

describe 'Uninstall feedback pages' do
  before do
    @site_home_page, @test = TestingSiteOnlyoffice::SiteHelper.new.open_page_teamlab_office(config)
    @username = TestingSiteOnlyoffice::SiteData::PARTNERS_EMAIL
    @mail = OnlyofficeIredmailHelper::IredMailHelper.new(username: @username)
  end

  after do |example|
    test_manager.add_result(example, @test)
    @test.webdriver.quit
  end

  it 'Check e-mail from Install canceled feedback page /install-canceled.aspx' do
    skip 'Cannot test email notifications in production' if config.server.include?('.com')
    @install_canceled_page = @site_home_page.open_install_canceled
    @install_canceled_page.select_options_install_canceled(cloud_version: true, technical_problems: true, necessary_features: true, legal_violation: true, rarely_use: true)
    @install_canceled_page.send_feedback_email_install_canceled
    mail_subject = 'Request from: install-canceled'
    expect(@mail.check_install_canceled_mail_body(username: @username,
                                                  subject: mail_subject,
                                                  cloud_version: true,
                                                  technical_problems: true,
                                                  necessary_features: true,
                                                  legal_violation: true,
                                                  rarely_use: true,
                                                  move_out: true)).to be_truthy
  end

  it 'Check e-mail from Account canceled feedback page /account-canceled.aspx' do
    skip 'Cannot test email notifications in production' if config.server.include?('.com')
    @install_canceled_page = @site_home_page.open_account_canceled
    @install_canceled_page.select_options_account_canceled(technical_problems: true, storage_space: true, necessary_features: true, legal_violation: true, rarely_work: true)
    @install_canceled_page.send_feedback_email_account_canceled
    mail_subject = 'Request from: account-canceled'
    expect(@mail.check_account_canceled_mail_body(username: @username,
                                                  subject: mail_subject,
                                                  technical_problems: true,
                                                  storage_space: true,
                                                  necessary_features: true,
                                                  legal_violation: true,
                                                  rarely_work: true,
                                                  move_out: true)).to be_truthy
  end

  it 'Check e-mail from Desktop uninstalled feedback page /desktop-uninstalled.aspx' do
    skip 'Cannot test email notifications in production' if config.server.include?('.com')
    @install_canceled_page = @site_home_page.open_desktop_uninstalled
    @install_canceled_page.select_options_desktop_uninstalled(technical_problems: true, another_desktop_software: true, necessary_features: true, legal_violation: true, rarely_use: true)
    @install_canceled_page.send_feedback_email_desktop_uninstalled
    mail_subject = 'Request from: desktop-uninstalled'
    expect(@mail.check_desktop_uninstalled_mail_body(username: @username,
                                                     subject: mail_subject,
                                                     technical_problems: true,
                                                     another_desktop_software: true,
                                                     necessary_features: true,
                                                     legal_violation: true,
                                                     rarely_use: true,
                                                     move_out: true)).to be_truthy
  end

  it 'Check e-mail from Registration canceled feedback page /registration-canceled.aspx' do
    skip 'Cannot test email notifications in production' if config.server.include?('.com')
    @install_canceled_page = @site_home_page.open_registration_canceled
    @install_canceled_page.select_options_registration_canceled(switched_on_premises: true, switched_to_personal: true, technical_problems: true, necessary_features: true, legal_violation: true, rarely_use: true)
    @install_canceled_page.send_feedback_email_registration_canceled
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
end
