# frozen_string_literal: true

require 'spec_helper'

test_manager = TestingSiteOnlyoffice::TestManager.new(suite_name: File.basename(__FILE__))
registration_data = TestingSiteOnlyoffice::DocsRegistrationData.new

describe 'Doc registration page' do
  before do
    @site_home_page, @test = TestingSiteOnlyoffice::SiteHelper.new.open_page_teamlab_office(config)
  end

  after do |example|
    test_manager.add_result(example, @test)
    @test.webdriver.quit
  end

  TestingSiteOnlyoffice::SiteData.site_languages.each do |current_language|
    describe "Open registration page #{current_language}" do
      before do
        @site_home_page.set_page_language(current_language)
        @doc_sign_up_page = @site_home_page.click_link_on_toolbar(:get_onlyoffice_docs_registration)
      end

      it "Open Stripe page in #{current_language} language from /docs-registration.aspx" do
        pending('https://bugzilla.onlyoffice.com/show_bug.cgi?id=43150') if config.server.include?('.com')
        payment_page = @doc_sign_up_page.submit_correct_data(registration_data)
        expect(payment_page).to be_a TestingSiteOnlyoffice::StripePaymentPage
      end
    end
  end
end
