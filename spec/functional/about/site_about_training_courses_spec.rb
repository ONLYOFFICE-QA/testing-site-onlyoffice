# frozen_string_literal: true

require 'spec_helper'

test_manager = TestingSiteOnlyoffice::TestManager.new(suite_name: File.basename(__FILE__))

partner_email = IredMailHelper.new(username: TestingSiteOnlyoffice::SiteData::PARTNERS_EMAIL)

describe 'Training courses' do
  before do
    site_home_page, @test = TestingSiteOnlyoffice::SiteHelper.new.open_page_teamlab_office(config)
    @training_courses_page = site_home_page.click_link_on_toolbar(:training_courses)
  end

  after do |example|
    test_manager.add_result(example, @test)
    @test.webdriver.quit
  end

  it "[Training courses] Number of modules didn't change" do
    expect(@training_courses_page.courses_modules_names).to eq(TestingSiteOnlyoffice::SiteData.courses_modules.values)
  end

  it "[Training courses] Number of purpose didn't change" do
    expect(@training_courses_page.courses_purpose_names).to eq(TestingSiteOnlyoffice::SiteData.courses_purposes.values)
  end

  it '[Training courses] Search field works' do
    @training_courses_page.courses_search('chat')
    expect(@training_courses_page).to be_courses_block_present('people_chat_community')
    expect(@training_courses_page).not_to be_courses_block_present('projects')
    expect(@training_courses_page).not_to be_courses_block_present('working_in_a_team')
  end

  it '[Training courses] Filter `all` works' do
    @training_courses_page.change_left_filter(:Modules)
    expect(@training_courses_page).to be_courses_block_present('people_chat_community')
    expect(@training_courses_page).not_to be_courses_block_present('working_in_a_team')
    @training_courses_page.change_left_filter(:Purpose)
    expect(@training_courses_page).not_to be_courses_block_present('people_chat_community')
    expect(@training_courses_page).to be_courses_block_present('working_in_a_team')
    @training_courses_page.change_left_filter(:All)
    expect(@training_courses_page).to be_courses_block_present('people_chat_community')
    expect(@training_courses_page).to be_courses_block_present('working_in_a_team')
  end

  TestingSiteOnlyoffice::SiteData.all_training_courses.each_key do |course|
    it "[Training courses] Check #{course} course mail request confirmation" do
      pending('https://bugzilla.onlyoffice.com/show_bug.cgi?id=43150') if config.server.include?('.com')
      @training_courses_page.open_and_send_request_courses_form(course.to_s)
      expect(TestingSiteOnlyoffice::SiteNotificationHelper.check_site_notification(language: config.language,
                                                                                   pattern: 'training_courses',
                                                                                   module: 'WebStudio',
                                                                                   search: course.to_s,
                                                                                   mail: partner_email,
                                                                                   move_out: true)).to be_truthy
    end
  end
end
