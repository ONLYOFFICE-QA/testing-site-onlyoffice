# frozen_string_literal: true

require 'spec_helper'

test_manager = TestingSiteOnlyoffice::TestManager.new(suite_name: File.basename(__FILE__))

describe 'Site Smoke Changing Languages on main page' do
  after do |example|
    test_manager.add_result(example, @test)
    @test&.webdriver&.quit
  end

  it '[Site] Check exists languages' do
    site_home_page, @test = TestingSiteOnlyoffice::SiteHelper.new.open_page_teamlab_office(config)
    expect(site_home_page.get_all_language_from_site.sort).to eq(TestingSiteOnlyoffice::SiteData.site_languages.sort)
  end

  TestingSiteOnlyoffice::SiteData.site_languages.each do |current_language|
    describe "Main page language: #{current_language}" do
      after do
        @test.webdriver.quit
      end

      it "Check changing to #{current_language} language" do
        main_page, @test = TestingSiteOnlyoffice::SiteHelper.new.open_page_teamlab_office(config)
        main_page.set_page_language(current_language)
        expect(main_page.get_page_language).to eq(current_language)
      end
    end
  end
end
