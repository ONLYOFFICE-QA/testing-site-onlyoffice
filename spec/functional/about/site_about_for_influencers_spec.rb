# frozen_string_literal: true

require 'spec_helper'

test_manager = TestingSiteOnlyoffice::TestManager.new(suite_name: File.basename(__FILE__))
partner_email = OnlyofficeIredmailHelper::IredMailHelper.new(username: TestingSiteOnlyoffice::SiteData::PARTNERS_EMAIL)
client_email = TestingSiteOnlyoffice::SiteData::CLIENT_EMAIL

describe '[Resources] [For influencers]' do
  before do
    site_home_page, @test = TestingSiteOnlyoffice::SiteHelper.new.open_page_teamlab_office(config)
    @about_for_influencers = site_home_page.click_link_on_toolbar(:about_influencers)
  end

  after do |example|
    test_manager.add_result(example, @test)
    @test.webdriver.quit
  end

  it '[Resources] [For influencers] "Get started" button works' do
    @about_for_influencers.get_started_button
    expect(@about_for_influencers).to be_influencer_form_visible
  end

  it '[Resources] [For influencers] "Application form" link works' do
    @about_for_influencers.application_form_link
    expect(@about_for_influencers).to be_influencer_form_visible
  end

  it '[Resources] [For influencers] "Apply now" button works' do
    @about_for_influencers.apply_now_button
    expect(@about_for_influencers).to be_influencer_form_visible
  end

  it '[Resources] [For influencers] Brand ambassador "Join now" button works' do
    result_page = @about_for_influencers.click_join_now_ambassador
    expect(result_page).to be_a TestingSiteOnlyoffice::SiteAboutBlog
  end

  it '[Resources] [For influencers] Affiliate Program "Start now" button works' do
    result_page = @about_for_influencers.click_join_now_affiliates
    expect(result_page).to be_a TestingSiteOnlyoffice::SitePartnersAffiliates
  end

  it '[Resources] [For influencers] Check email is sent after form submission' do
    skip 'Cannot test email notifications in production' if config.server.include?('.com')
    @about_for_influencers.fill_influencer_form_and_submit(client_email)
    mail_subject = 'Influencer Program Request [from: influencer-program]'
    expect(partner_email.check_email_by_subject({ subject: mail_subject }, 300, true)).to be true
  end
end
