# frozen_string_literal: true

require 'spec_helper'

test_manager = TestingSiteOnlyoffice::TestManager.new(suite_name: File.basename(__FILE__))

describe 'Site Products Accessibility' do
  before do
    site_home_page, @test = TestingSiteOnlyoffice::SiteHelper.new.open_page_teamlab_office(config)
    @accessibility_page = site_home_page.click_link_on_toolbar(:features_accessibility)
  end

  after do |example|
    test_manager.add_result(example, @test)
    @test&.webdriver&.quit
  end

  it '[Site Products] [Accessibility] "Try now" button works' do
    result_page = @accessibility_page.click_try_now
    expect(result_page).to be_a TestingSiteOnlyoffice::SiteGetOnlyofficeDocsEnterprise
  end

  describe 'Accessibility - vision features' do
    it '[Accessibility] [Vision] Screen readers - "learn more" link works' do
      result_page = @accessibility_page.click_screen_readers_learn_more
      expect(result_page).to be_a TestingSiteOnlyoffice::SiteAboutBlog
    end

    it '[Accessibility] [Vision] UI tweaks - "learn more" link works' do
      @accessibility_page.ui_tweaks_learn_more
      expect(@accessibility_page.check_opened_page_title).to eq(TestingSiteOnlyoffice::SiteDownloadData::HELPCENTER_ONLYOFFICE_ACCESSIBILITY)
    end

    it '[Accessibility] [Vision] Color modes - "learn more" link works' do
      @accessibility_page.color_modes_learn_more
      expect(@accessibility_page.check_opened_page_title).to eq(TestingSiteOnlyoffice::SiteDownloadData::HELPCENTER_ONLYOFFICE_ACCESSIBILITY)
    end
  end

  describe 'Accessibility - mobility features' do
    it '[Accessibility] [Vision] Hotkeys - "learn more" link works' do
      @accessibility_page.click_hotkeys_learn_more
      expect(@accessibility_page.check_opened_page_title).to eq(TestingSiteOnlyoffice::SiteDownloadData::HELPCENTER_ONLYOFFICE_ACCESSIBILITY)
    end

    it '[Accessibility] [Vision] Speech input - "learn more" link works' do
      @accessibility_page.click_speech_input_learn_more
      expect(@accessibility_page.check_opened_page_title).to eq(TestingSiteOnlyoffice::SiteDownloadData::HELPCENTER_ONLYOFFICE_ACCESSIBILITY)
    end
  end

  describe 'Accessibility - neurodiversity features' do
    it '[Accessibility] [Vision] Alternative text - "learn more" link works' do
      @accessibility_page.click_alternative_text_learn_more
      expect(@accessibility_page.check_opened_page_title).to eq(TestingSiteOnlyoffice::SiteDownloadData::HELPCENTER_ONLYOFFICE_ACCESSIBILITY)
    end

    it '[Accessibility] [Vision] AutoCorrect features - "learn more" link works' do
      @accessibility_page.click_autocorrect_features_learn_more
      expect(@accessibility_page.check_opened_page_title).to eq(TestingSiteOnlyoffice::SiteDownloadData::HELPCENTER_ONLYOFFICE_ACCESSIBILITY)
    end

    it '[Accessibility] [Vision] Speech - "learn more" link works' do
      result_page = @accessibility_page.click_speech_learn_more
      expect(result_page).to be_a TestingSiteOnlyoffice::SiteMarketplacePluginPage
    end

    it '[Accessibility] [Vision] Typograf - "learn more" link works' do
      result_page = @accessibility_page.click_typograf_learn_more
      expect(result_page).to be_a TestingSiteOnlyoffice::SiteMarketplacePluginPage
    end

    it '[Accessibility] [Vision] Translator - "learn more" link works' do
      result_page = @accessibility_page.click_translator_learn_more
      expect(result_page).to be_a TestingSiteOnlyoffice::SiteMarketplacePluginPage
    end
  end
end
