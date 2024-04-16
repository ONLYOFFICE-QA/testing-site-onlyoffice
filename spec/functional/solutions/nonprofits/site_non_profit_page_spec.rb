# frozen_string_literal: true

require 'spec_helper'

test_manager = TestingSiteOnlyoffice::TestManager.new(suite_name: File.basename(__FILE__))

describe 'Site Nonprofit page links' do
  before do
    site_home_page, @test = TestingSiteOnlyoffice::SiteHelper.new.open_page_teamlab_office(config)
    @nonprofits_page = site_home_page.click_nonprofits
  end

  after do |example|
    test_manager.add_result(example, @test)
    @test.webdriver.quit
  end

  it '[Site][NonProfits] Check link `Learn more about docspace' do
    @products_docs = @nonprofits_page.click_learn_about_docspace
    expect(@products_docs).to be_a TestingSiteOnlyoffice::SiteDocSpaceMainPage
  end

  it '[Site][NonProfits] Check link `Try now / docspace' do
    @products_docs = @nonprofits_page.click_docspace_registration
    expect(@products_docs).to be_a TestingSiteOnlyoffice::SiteDocSpaceSignUp
  end

  it '[Site][NonProfits] Check link `Get it now / workspace' do
    @products_docs = @nonprofits_page.click_download_workspace
    expect(@products_docs).to be_a TestingSiteOnlyoffice::SiteGetOnlyofficeWorkspaceEnterprise
  end

  it '[Site][NonProfits] Check link `Get it now / docs' do
    @products_docs = @nonprofits_page.click_download_docs
    expect(@products_docs).to be_a TestingSiteOnlyoffice::SiteGetOnlyofficeDocsEnterprise
  end

  it '[Site][NonProfits] Check link `Learn more about collaboration platform`' do
    @products_groups = @nonprofits_page.click_learn_more_about_collaboration_platforms
    expect(@products_groups).to be_a TestingSiteOnlyoffice::SiteFeaturesWorkspace
  end

  it '[Site][NonProfits] Check link `Learn about security`' do
    @products_security = @nonprofits_page.click_learn_more_about_security
    expect(@products_security).to be_a TestingSiteOnlyoffice::SiteFeaturesSecurity
  end

  it '[Site][NonProfits] Check link `Download for Android`' do
    @nonprofits_page.nonprofit_android
    expect(@nonprofits_page.check_opened_page_title(switch_tab: false)).to eq(TestingSiteOnlyoffice::SiteDownloadData::MOBILE_DOCUMENTS_GOOGLE)
  end

  it '[Site][NonProfits] Check link `Download for IOS`' do
    @nonprofits_page.nonprofit_ios
    expect(@nonprofits_page.check_opened_page_title(switch_tab: false)).to eq(TestingSiteOnlyoffice::SiteDownloadData::MOBILE_DOCUMENTS_APP_STORE)
  end

  describe 'Download desktop' do
    %w[windows linux macos].each do |platform|
      it "Check #{platform}" do
        @downloads_page = @nonprofits_page.click_download_desktop(platform)
        expect(@downloads_page).to be_a TestingSiteOnlyoffice::SiteGetOnlyofficeDesktopApps
      end
    end
  end
end
