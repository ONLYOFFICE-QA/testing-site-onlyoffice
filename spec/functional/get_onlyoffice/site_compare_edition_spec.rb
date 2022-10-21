# frozen_string_literal: true

require 'spec_helper'

test_manager = TestingSiteOnlyoffice::TestManager.new(suite_name: File.basename(__FILE__))

describe 'Compare edition' do
  before do
    site_home_page, @test = TestingSiteOnlyoffice::SiteHelper.new.open_page_teamlab_office(config)
    @compare_edition = site_home_page.click_link_on_toolbar(:compare_editions)
  end

  after do |example|
    test_manager.add_result(example, @test)
    @test.webdriver.quit
  end

  it '[Compare edition] Go to compare edition' do
    expect(@compare_edition).to be_a TestingSiteOnlyoffice::SiteCompareEdition
  end

  describe 'Community Edition' do
    it '[Community Edition] Go to get onlyoffice' do
      expect(@compare_edition.check_button_get_it_now?).to be_a TestingSiteOnlyoffice::SiteDocsCommunity
    end

    it '[Community Edition] Go to help center community' do
      expect(@compare_edition.check_link?(:help_center_community_edition)).to be true
    end

    it '[Community Edition] Go to git hub' do
      expect(@compare_edition.check_link?(:git_hub)).to be true
    end
  end

  describe 'Enterprise Edition' do
    it '[Enterprise Edition] Go to Enterprise Free Trial' do
      expect(@compare_edition.check_button_enterprise_free_trial?).to be_a TestingSiteOnlyoffice::SiteGetOnlyofficeDocsEnterprise
    end

    it '[Enterprise Edition] Go to Enterprise Edition' do
      expect(@compare_edition.check_button_enterprise_prices?).to be_a TestingSiteOnlyoffice::SitePriceDocsEnterprise
    end

    it '[Enterprise Edition] Opened enterprise license agreement' do
      expect(@compare_edition.check_opened_enterprise_license_agreement).to be true
    end

    it '[Enterprise Edition] Go to help center enterprise' do
      expect(@compare_edition.check_link?(:help_center_enterprise_edition)).to be true
    end
  end

  describe 'Developer Edition' do
    it '[Developer Edition] Go to Developer Free Trial' do
      expect(@compare_edition.check_button_developer_free_trial?).to be_a TestingSiteOnlyoffice::SiteGetOnlyofficeDocsDeveloper
    end

    it '[Developer Edition] Go to Developer Edition' do
      expect(@compare_edition.check_button_developer_prices?).to be_a TestingSiteOnlyoffice::SitePriceDocsDeveloper
    end

    it '[Developer Edition] Opened developer license agreement' do
      expect(@compare_edition.check_opened_developer_license_agreement).to be true
    end

    it '[Developer Edition] Go to help center developer' do
      expect(@compare_edition.check_link?(:help_center_developer_edition)).to be true
    end
  end
end
