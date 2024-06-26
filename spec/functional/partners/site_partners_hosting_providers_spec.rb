# frozen_string_literal: true

require 'spec_helper'

test_manager = TestingSiteOnlyoffice::TestManager.new(suite_name: File.basename(__FILE__))

describe 'Partners Hosting Providers' do
  before do
    site_home_page, @test = TestingSiteOnlyoffice::SiteHelper.new.open_page_teamlab_office(config)
    @hosting_providers = site_home_page.click_link_on_toolbar(:partners_hosting_providers)
  end

  after do |example|
    test_manager.add_result(example, @test)
    @test.webdriver.quit
  end

  TestingSiteOnlyoffice::SiteDownloadData.partners_hosting_providers.each do |provider, ids|
    describe "#{provider} Links Test" do
      ids.each do |id|
        it "link with ID #{id} for provider #{provider} works" do
          link = @hosting_providers.get_hosting_product_link(provider, id)
          skip('due to API protections causing a 404 error') if provider.to_s == 'atera'
          expect(@hosting_providers).to be_link_success_response(link)
        end
      end
    end
  end
end
