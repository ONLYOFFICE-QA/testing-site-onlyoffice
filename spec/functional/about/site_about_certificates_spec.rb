# frozen_string_literal: true

require 'spec_helper'

test_manager = TestingSiteOnlyoffice::TestManager.new(suite_name: File.basename(__FILE__))

describe 'Certificates' do
  before do
    site_home_page, @test = TestingSiteOnlyoffice::SiteHelper.new.open_page_teamlab_office(config)
    @about_certificates = site_home_page.click_link_on_toolbar(:about_certificates)
  end

  after do |example|
    test_manager.add_result(example, @test)
    @test.webdriver.quit
  end

  describe 'for Kylin OS' do
    it '[Resources] [Certificates] Learn details for Kylin OS works' do
      result_page = @about_certificates.click_learn_details_kylin_os
      expect(result_page).to be_a TestingSiteOnlyoffice::SiteAboutBlog
    end

    it '[Resources] [Certificates] Products link for Kylin OS works' do
      result_page = @about_certificates.click_product_kylin_os
      expect(result_page).to be_a TestingSiteOnlyoffice::SiteForBusinessDocsEnterpriseEdition
    end

    it '[Resources] [Certificates] Downloads Kylin OS certificate' do
      @about_certificates.download_kylin_os_button
      expect(@about_certificates).to be_file_downloaded('compatibility_certificate_with_kylin_os.png')
    end
  end

  describe 'for OpenKylin OS' do
    it '[Resources] [Certificates] Learn details for OpenKylin works' do
      result_page = @about_certificates.click_learn_details_openkylin
      expect(result_page).to be_a TestingSiteOnlyoffice::SiteAboutBlog
    end

    it '[Resources] [Certificates] Products link for OpenKylin works' do
      result_page = @about_certificates.click_product_openkylin
      expect(result_page).to be_a TestingSiteOnlyoffice::SiteFeaturesDesktop
    end

    it '[Resources] [Certificates] Downloads OpenKylin OS certificate' do
      @about_certificates.download_openkylin_button
      expect(@about_certificates).to be_file_downloaded('compatibility_certificate_with_openkylin.png')
    end
  end

  it '[Resources] [Certificates] Start in the cloud button works' do
    result_page = @about_certificates.click_start_in_the_cloud
    expect(result_page).to be_a TestingSiteOnlyoffice::SiteDocSpaceSignUp
  end
end
