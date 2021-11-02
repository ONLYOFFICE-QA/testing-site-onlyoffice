# frozen_string_literal: true

require 'spec_helper'

test_manager = TestingSiteOnlyoffice::TestManager.new(suite_name: File.basename(__FILE__))

partner_email = IredMailHelper.new(username: TestingSiteOnlyoffice::SiteData::PARTNERS_EMAIL)
client_email = IredMailHelper.new(username: TestingSiteOnlyoffice::SiteData::CLIENT_EMAIL)

describe 'Check trial request form' do
  before do
    @site_home_page, @test = TestingSiteOnlyoffice::SiteHelper.new.open_page_teamlab_office(config)
    pending('https://bugzilla.onlyoffice.com/show_bug.cgi?id=43150') if config.server.include?('.com')
  end

  after do |example|
    test_manager.add_result(example, @test)
    @test.webdriver.quit
  end

  it '[Download][DocsDeveloperEdition] docs developer edition request /download-commercial.aspx' do
    commercial_docs_page = @site_home_page.click_link_on_toolbar(:onlyoffice_docs_download).site_docs_developer_download
    company_name = "nctautotest/developer #{Time.now}"
    site_commercial_trial_form = commercial_docs_page.installer_docs_developer_type_block.click_install_button
    site_commercial_trial_form.send_trial_request(company_name: company_name)
    expect(partner_email.check_email_by_subject(
             { subject: "#{company_name} - #{TestingSiteOnlyoffice::SiteNotificationData::COMMERCIAL_DEVELOPER_DOCS}" }, 300, true
           )).to be true
    expect(client_email.check_email_by_subject({ subject: TestingSiteOnlyoffice::SiteNotificationData::DEVELOPER_TRIAL }, 300,
                                               true)).to be_truthy
  end

  it '[Download][DocsEnterpriseEdition] docs enterprise edition request /download-commercial.aspx' do
    commercial_docs_page = @site_home_page.click_link_on_toolbar(:onlyoffice_docs_download)
    company_name = "nctautotest/docs_enterprise #{Time.now}"
    site_commercial_trial_form = commercial_docs_page.installer_docs_enterprise_type_block.click_install_button
    site_commercial_trial_form.send_trial_request(company_name: company_name)
    expect(partner_email.check_email_by_subject(
             { subject: "#{company_name} - #{TestingSiteOnlyoffice::SiteNotificationData::COMMERCIAL_ENTERPRISE_DOCS}" }, 300, true
           )).to be_truthy
    expect(client_email.check_email_by_subject({ subject: TestingSiteOnlyoffice::SiteNotificationData::INTEGRATION_TRIAL }, 300,
                                               true)).to be_truthy
  end

  it '[Download][WorkspaceEnterpriseEdition] workspace enterprise edition request /download-commercial.aspx' do
    commercial_workspace_page = @site_home_page.click_link_on_toolbar(:onlyoffice_workspace)
    company_name = "nctautotest/enterprise #{Time.now}"
    site_commercial_trial_form = commercial_workspace_page.installer_type_block.click_install_button
    site_commercial_trial_form.send_trial_request(company_name: company_name)
    expect(partner_email.check_email_by_subject(
             { subject: "#{company_name} - #{TestingSiteOnlyoffice::SiteNotificationData::COMMERCIAL_ENTERPRISE_WORKSPACE}" }, 300, true
           )).to be_truthy
    expect(client_email.check_email_by_subject({ subject: TestingSiteOnlyoffice::SiteNotificationData::ENTERPRISE_TRIAL },
                                               300, true)).to be_truthy
  end
end
