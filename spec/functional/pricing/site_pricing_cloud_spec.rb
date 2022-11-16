# frozen_string_literal: true

require 'spec_helper'

partner_email = OnlyofficeIredmailHelper::IredMailHelper.new(username: TestingSiteOnlyoffice::SiteData::PARTNERS_EMAIL)

describe 'Pricing Cloud Service' do
  test_manager = TestingSiteOnlyoffice::TestManager.new(suite_name: File.basename(__FILE__))

  before do
    site_home_page, @test = TestingSiteOnlyoffice::SiteHelper.new.open_page_teamlab_office(config)
    @pricing_cloud_page = site_home_page.click_link_on_toolbar(:pricing_workspace).click_cloud
  end

  TestingSiteOnlyoffice::SitePricesData.cloud_services_price_periods.each do |period|
    describe 'check all main links' do
      before { @pricing_cloud_page.change_period(period) }

      it "[Site][Pricing][Cloud] Startup check `Start now` button for #{period}" do
        sign_up_page = @pricing_cloud_page.startup_start_now
        expect(sign_up_page).to be_a TestingSiteOnlyoffice::SiteGetOnlyofficeSignUp
      end

      it "[Site][Pricing][Cloud] Business check `Calculate your price` button for #{period}" do
        @pricing_cloud_page.business_calculate_your_price
        expect(@pricing_cloud_page.buy_now_calculator_element).to be_present
      end

      it "[Site][Pricing][Cloud] Business check `TRY IT FOR FREE` link for #{period}" do
        sign_up_page = @pricing_cloud_page.business_try_it_for_free
        expect(sign_up_page).to be_a TestingSiteOnlyoffice::SiteGetOnlyofficeSignUp
      end
    end
  end

  after do |example|
    test_manager.add_result(example, @test)
    @test.webdriver.quit
  end

  describe 'business calculator check' do
    before { @pricing_cloud_page.calculate_your_price }

    it '[Site][Pricing][Cloud] Calculator selector for users number works' do
      price_before_user_change = @pricing_cloud_page.current_tariff_price
      expect(@pricing_cloud_page.chooser_users_number_from_dropdown('5')).to be_truthy
      expect(price_before_user_change).not_to eq(@pricing_cloud_page.current_tariff_price)
    end

    it '[Site][Pricing][Cloud] `Contact us` is visible where there is more then 1001+ user' do
      @pricing_cloud_page.input_user_number('2000')
      expect(@pricing_cloud_page.contact_us_calculator_element).to be_present
    end
  end

  it '[Site][Pricing][Cloud] Click Buy now and check plane on Avangate page' do
    cost = @pricing_cloud_page.cost_tariff_business_3_year
    avangate_page = @pricing_cloud_page.buy_now
    expect(avangate_page.current_price).to eq(cost.to_i)
  end

  it '[Site][Pricing][Cloud] Check FAQ link' do
    faq_page = @pricing_cloud_page.click_on_faq_center
    expect(faq_page).to be_a TestingSiteOnlyoffice::SiteFaq
  end

  it '[Site][Pricing][Cloud] Fill `Contact us` form for VIP plan and check notify' do
    pending('https://bugzilla.onlyoffice.com/show_bug.cgi?id=43150') if config.server.include?('.com')
    company_name = "NCT Test #{Faker::Company.name}"
    vip_request_page = @pricing_cloud_page.vip_submit_request
    vip_request_page.send_vip_cloud_request(company_name:)
    subject_message = "#{company_name}#{TestingSiteOnlyoffice::SiteNotificationHelper.site_translate_from_resource(config.language, 'contact_vip', 'WebStudio')}"
    expect(partner_email.check_email_by_subject({ subject: subject_message }, 300, true)).to be_truthy
  end
end
