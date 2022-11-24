# frozen_string_literal: true

require 'spec_helper'

test_manager = TestingSiteOnlyoffice::TestManager.new(suite_name: File.basename(__FILE__))

describe 'Site For business integrations' do
  TestingSiteOnlyoffice::ForBusinessIntegrationsHelper.integrations_list.each_key do |integration|
    describe integration.to_s do
      before do
        site_home_page, @test = TestingSiteOnlyoffice::SiteHelper.new.open_page_teamlab_office(config)
        @integration = site_home_page.click_link_on_toolbar(integration)
      end

      after do |example|
        test_manager.add_result(example, @test)
        @test.webdriver.quit
      end

      it "[#{integration}] Go to #{integration}" do
        expect(@integration).to be_a TestingSiteOnlyoffice::ForBusinessIntegrationsHelper.integrations_list[integration][:class]
      end

      describe 'Pick price' do
        it_behaves_like 'integration_pick_price' do
          let(:integration_pick_price) { @integration }
        end
      end
    end
  end
end