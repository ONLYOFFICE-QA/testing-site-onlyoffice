# frozen_string_literal: true

require 'spec_helper'
require 'timeout'

test_manager = TestingSiteOnlyoffice::TestManager.new(suite_name: File.basename(__FILE__))

describe 'Site Smoke open registration page' do
  after do |example|
    test_manager.add_result(example, @test)
    @test&.webdriver&.quit
  end

  TestingSiteOnlyoffice::SiteData.site_languages.each do |current_language|
    describe "Open registration page #{current_language}" do
      before do
        @site_home_page, @test = TestingSiteOnlyoffice::SiteHelper.new.open_page_teamlab_office(config)
        @site_home_page.set_page_language(current_language)
      end

      it "Open trial form Pricing->Cloud Service page in #{current_language} language" do
        pricing_cloud_page = @site_home_page.click_link_on_toolbar(:pricing_docspace).click_cloud
        sign_up_page = pricing_cloud_page.startup_start_now
        expect(sign_up_page).to be_a TestingSiteOnlyoffice::SiteDocSpaceSignUp
      end

      it "Open Sing Up page from Sign In page in #{current_language} language" do
        sign_in_page = @site_home_page.click_link_on_toolbar(:get_onlyoffice_docspace_sign_in)
        sign_up_page = sign_in_page.register_from_sign_in
        expect(sign_up_page).to be_a TestingSiteOnlyoffice::SiteDocSpaceSignUp
      end
    end
  end
end
