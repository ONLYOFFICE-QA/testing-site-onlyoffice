# frozen_string_literal: true

shared_examples_for 'сhecking_logger_errors' do
  it 'Сhecking for a product version logging error' do
    expect(@download_commercial_page.empty_text_log?).to be true
  end
end
