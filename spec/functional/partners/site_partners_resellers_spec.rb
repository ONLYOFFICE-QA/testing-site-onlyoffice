# frozen_string_literal: true

require 'spec_helper'

test_manager = TestingSiteOnlyoffice::TestManager.new(suite_name: File.basename(__FILE__))

partner_email = OnlyofficeIredmailHelper::IredMailHelper.new(username: TestingSiteOnlyoffice::SiteData::PARTNERS_EMAIL)

describe 'Partners resellers' do
  before do
    site_home_page, @test = TestingSiteOnlyoffice::SiteHelper.new.open_page_teamlab_office(config)
    @resellers = site_home_page.click_link_on_toolbar(:partners_resellers)
  end

  after do |example|
    test_manager.add_result(example, @test)
    @test.webdriver.quit
  end

  it '[Partners resellers] Go to partners resellers' do
    expect(@resellers).to be_a TestingSiteOnlyoffice::SitePartnersResellers
  end

  it '[Partners resellers] Go to about_docs' do
    expect(@resellers.check_about_docs?).to be_a TestingSiteOnlyoffice::SiteProductsDocs
  end

  it '[Partners resellers] Go to about_workspace' do
    expect(@resellers.check_about_workspace?).to be_a TestingSiteOnlyoffice::SiteFeaturesWorkspace
  end

  it '[Partners resellers] Go to translations' do
    expect(@resellers.check_translations?).to be(true)
  end

  it '[Partners resellers] Go to submit request' do
    expect(@resellers.check_button_submit_request?).to be_a TestingSiteOnlyoffice::SitePartnersRequest
  end

  it '[Partners resellers] Check request a partners resellers' do
    pending('https://bugzilla.onlyoffice.com/show_bug.cgi?id=43150') if config.server.include?('.com')
    partnership_request = @resellers.send_become_partner_request
    company_name = "nctautotest #{Time.now} For Developers /partnership-request.aspx?requestType=1"
    partnership_request.send_partners_form_random_data(company_name:)
    subject_message = "#{company_name} - Partner Request"
    expect(partnership_request.partner_request_successful_element).to be_present
    expect(partner_email.check_email_by_subject({ subject: subject_message }, 300, true)).to be true
  end
end
