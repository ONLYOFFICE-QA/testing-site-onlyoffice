# frozen_string_literal: true

shared_examples_for 'checking_editors_links' do |feature_key, feature_info|
  it "#{feature_key.to_s.tr('_', ' ')} link works correctly" do
    result_page = page.click_link_by_feature(feature_key)
    expect(result_page).to be_a(feature_info[:class])
  end
end
