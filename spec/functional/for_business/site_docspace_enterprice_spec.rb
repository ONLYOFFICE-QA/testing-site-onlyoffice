# frozen_string_literal: true

require 'spec_helper'

test_manager = TestingSiteOnlyoffice::TestManager.new(suite_name: File.basename(__FILE__))

describe 'DocSpace enterprise' do
  before do
    @site_home_page, @test = TestingSiteOnlyoffice::SiteHelper.new.open_page_teamlab_office(config)
  end

  after do |example|
    test_manager.add_result(example, @test)
    @test.webdriver.quit
  end

  describe 'DocSpace Enterprise links' do
    it 'Try free in the cloud' do
      docspace_enterprise = @site_home_page.click_link_on_toolbar(:docspace_enterprise)
      docspace_sign_up_page = docspace_enterprise.click_try_in_cloud
      expect(docspace_sign_up_page).to be_a TestingSiteOnlyoffice::SiteDocSpaceSignUp
    end

    it 'Get it now' do
      docspace_enterprise = @site_home_page.click_link_on_toolbar(:docspace_enterprise)
      docspace_download_page = docspace_enterprise.click_get_it_now
      expect(docspace_download_page).to be_a TestingSiteOnlyoffice::SiteDocSpaceDownloadEnterprise
    end

    it 'Desktop apps link' do
      docspace_enterprise = @site_home_page.click_link_on_toolbar(:docspace_enterprise)
      desktop_apps_page = docspace_enterprise.click_desktop_apps
      expect(desktop_apps_page).to be_a TestingSiteOnlyoffice::SiteGetOnlyofficeDesktopApps
    end

    it 'Mobile apps link' do
      docspace_enterprise = @site_home_page.click_link_on_toolbar(:docspace_enterprise)
      mobile_apps_page = docspace_enterprise.click_mobile_apps
      expect(mobile_apps_page).to be_a TestingSiteOnlyoffice::SiteMobileApps
    end

    it 'Security link' do
      docspace_enterprise = @site_home_page.click_link_on_toolbar(:docspace_enterprise)
      security_page = docspace_enterprise.click_security
      expect(security_page).to be_a TestingSiteOnlyoffice::SiteFeaturesSecurity
    end

    it 'Download link Cloud "Getting Started is easy"' do
      docspace_enterprise = @site_home_page.click_link_on_toolbar(:docspace_enterprise)
      download_links_page = docspace_enterprise.click_download_link_cloud
      expect(download_links_page).to be_a TestingSiteOnlyoffice::SiteDocSpaceSignUp
    end

    it 'Download link Linux "Getting Started is easy"' do
      docspace_enterprise = @site_home_page.click_link_on_toolbar(:docspace_enterprise)
      download_links_page = docspace_enterprise.click_download_link_linux
      expect(download_links_page).to be_a TestingSiteOnlyoffice::SiteDocSpaceDownloadEnterprise
    end

    it 'Download link Windows "Getting Started is easy"' do
      docspace_enterprise = @site_home_page.click_link_on_toolbar(:docspace_enterprise)
      download_links_page = docspace_enterprise.click_download_link_windows
      expect(download_links_page).to be_a TestingSiteOnlyoffice::SiteDocSpaceDownloadEnterprise
    end
  end

  describe 'DocSpace Enterprise pricing block' do
    it 'Enterprise plan link' do
      docspace_enterprise = @site_home_page.click_link_on_toolbar(:docspace_enterprise)
      pricing_docspace = docspace_enterprise.click_enterprise_plan
      expect(pricing_docspace).to be_a TestingSiteOnlyoffice::SitePricingDocSpacePrices
    end

    it 'Pick price link' do
      docspace_enterprise = @site_home_page.click_link_on_toolbar(:docspace_enterprise)
      pricing_docspace = docspace_enterprise.click_pick_price_link
      expect(pricing_docspace).to be_a TestingSiteOnlyoffice::SitePricingDocSpacePrices
    end

    it_behaves_like 'pricing_buy_page', 'PricingDocSpace',
                    TestingSiteOnlyoffice::SiteDownloadData.pricing_page_data[:support_level],
                    TestingSiteOnlyoffice::SiteDownloadData.pricing_page_data[:number_connection_docspace] do
      let(:pricing_page) { @site_home_page.click_link_on_toolbar(:docspace_enterprise) }
    end
  end
end
