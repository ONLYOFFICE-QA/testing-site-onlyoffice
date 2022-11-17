# frozen_string_literal: true

require 'spec_helper'

test_manager = TestingSiteOnlyoffice::TestManager.new(suite_name: File.basename(__FILE__))
partner_email = OnlyofficeIredmailHelper::IredMailHelper.new(username: TestingSiteOnlyoffice::SiteData::PARTNERS_EMAIL)
registration_data = TestingSiteOnlyoffice::DocsRegistrationData.new

describe 'Doc registration page' do
  before do
    site_home_page, @test = TestingSiteOnlyoffice::SiteHelper.new.open_page_teamlab_office(config)
    @doc_sign_up_page = site_home_page.click_link_on_toolbar(:onlyoffice_docs_registration)
  end

  after do |example|
    test_manager.add_result(example, @test)
    @test.webdriver.quit
  end

  describe 'Sign Up for cloud' do
    it 'Sign Up online document editors' do
      pending('https://bugzilla.onlyoffice.com/show_bug.cgi?id=43150') if config.server.include?('.com')
      @doc_sign_up_page.submit_correct_data(registration_data)
      expect(partner_email.check_email_by_subject({ subject: "#{registration_data.full_name} - Docs Registration Request [from: docs-registration]" }, 300, true)).to be true
    end

    it 'Sign Up errors' do
      @doc_sign_up_page.submit_data(TestingSiteOnlyoffice::DocsRegistrationData.new.generate_incorrect_data)
      expect(@doc_sign_up_page).to be_all_errors_visible
    end
  end
end
