require 'spec_helper'

test_manager = TestManager.new(suite_name: File.basename(__FILE__))

site_helper = SiteHelper.new

mail_site = IredMailHelper.new(username: TestingSiteOnlyffice::SiteData::EMAIL_FOR_SITE)
partner_email = IredMailHelper.new(username: SettingsData::PARTNERS_EMAIL)
client_email = IredMailHelper.new(username: SettingsData::CLIENT_EMAIL)

describe 'Registration new portal' do
  before do
    @site_home_page, @test = TestingSiteOnlyffice::PortalHelper.new.open_page_teamlab_office
    @site_home_page.set_page_language(StaticDataTeamLab.current_language)
  end

  it 'Check button `Recover` work on `wrong portal name` page for correct email' do
    wrong_page = site_helper.wrong_portal_name
    wrong_page.recover_address_portal(TestingSiteOnlyffice::SiteData::EMAIL_FOR_SITE)
    expect(SiteNotificationHelper.check_site_notification(language: StaticDataTeamLab.current_language,
                                                          module: 'WebStudio',
                                                          mail: mail_site,
                                                          pattern: 'portal_name_reminder',
                                                          search: TestingSiteOnlyffice::SiteData::PORTAL_ADDRESS)).to be_truthy
  end

  # CAUTION: do not test on .com frequently
  # for debug: nonprofit.manager.t@gmail.com Teamlab123
  describe 'Partnership' do
    it '[Site][Partnership] Send request for partnership' do
      pending('https://bugzilla.onlyoffice.com/show_bug.cgi?id=43150') if StaticDataTeamLab.portal_type == '.com'
      partnership_request_page = @site_home_page.click_link_on_toolbar(:submit_request)
      company_name = "nctautotest #{Time.now} For Developers /partnership-request.aspx?requestType=1"
      partnership_request_page.send_partners_form_random_data(company_name: company_name)
      subject_message = "#{company_name} - Partner Request"
      expect(partnership_request_page.partner_request_successful_element).to be_present
      expect(partner_email.check_email_by_subject({ subject: subject_message }, 300, true)).to be true
    end
  end

  describe 'Order Demo' do
    it '[Site][OrderDemo] Send demo-order request /demo-order.aspx' do
      pending('https://bugzilla.onlyoffice.com/show_bug.cgi?id=43150') if StaticDataTeamLab.portal_type == '.com'
      demo_order_page = @site_home_page.click_order_demo
      company_name = "nctautotest #{Time.now} /demo-order.aspx"
      @home_page = demo_order_page.send_demonstration_request(company_name: company_name)
      expect(@home_page).to be_a TestingSiteOnlyffice::SiteHomePage
      expect(partner_email.check_email_by_subject(
               { subject: TestingSiteOnlyffice::SiteNotificationData::ORDER_DEMO_REQUEST, search: company_name }, 300, true
             )).to be true
    end
  end

  describe 'Call back' do
    it '[Site][CallBack] Check request a call /call-back-form.aspx' do
      pending('https://bugzilla.onlyoffice.com/show_bug.cgi?id=43150') if StaticDataTeamLab.portal_type == '.com'
      site_callback_page = @site_home_page.click_request_a_call
      last_name = "nctautotest #{Time.now} /call-back-form.aspx"
      site_callback_page.send_callback_request(last_name: last_name)
      expect(site_callback_page).to be_congratulation_visible
      expect(partner_email.check_email_by_subject(
               { subject: TestingSiteOnlyffice::SiteNotificationData::CALL_BACK_REQUEST, search: last_name }, 300, true
             )).to be true
    end
  end

  describe 'Subscribe' do
    it 'Subscribe to news' do
      subscribe_popup = @site_home_page.click_subscribe_to_newsletter
      subscribe_popup.fill_subscribe_form
      mail_html = client_email.get_html_body_email_by_subject(
        { subject: TestingSiteOnlyffice::SiteNotificationData::SUBSCRIBE_TO_NEWSLETTER }, 300
      )
      subscribe_link = SiteSubscribe.parse_subscribe_link(mail_html)
      subscribe_confirm = subscribe_popup.subscribe_from_link(subscribe_link)
      expect(subscribe_confirm).to be_wait_success_text_visible
    end
  end

  after do |example|
    test_manager.add_result(example)
    @test&.webdriver&.quit
    site_helper.test&.webdriver&.quit
  end
end
