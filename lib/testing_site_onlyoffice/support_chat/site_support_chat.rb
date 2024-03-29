# frozen_string_literal: true

module TestingSiteOnlyoffice
  # Popup for chatting with support
  # https://user-images.githubusercontent.com/40513035/99503591-72527200-298f-11eb-8227-b3d5632a1099.png
  module SiteSupportChatPopup
    CHAT_OPENED_FRAME_XPATH = '//iframe[@data-test-id="ChatWidgetWindow-iframe"]'
    CHAT_CLOSED_FRAME_XPATH = '//iframe[@data-test-id="ChatWidgetButton-iframe"]'

    HIDE_CHAT_BUTTON_XPATH = '//div[contains(@class, "chatWindow")]//div[contains(@class, "close")]'

    def chat_window_shown?
      @instance.webdriver.element_visible?(CHAT_OPENED_FRAME_XPATH) || @instance.webdriver.element_visible?(CHAT_CLOSED_FRAME_XPATH)
    end

    def hide_support_chat
      return if @instance.webdriver.element_visible?(CHAT_CLOSED_FRAME_XPATH)

      @instance.webdriver.select_frame(CHAT_OPENED_FRAME_XPATH)
      @instance.webdriver.click_on_locator(HIDE_CHAT_BUTTON_XPATH)
      @instance.webdriver.wait_until { !@instance.webdriver.element_visible?(HIDE_CHAT_BUTTON_XPATH) }
      @instance.webdriver.select_top_frame
    end

    def hide_support_chat_if_shown
      OnlyofficeLoggerHelper.sleep_and_log('Waiting for support chat appears with delay', 2)
      hide_support_chat if chat_window_shown?
    end
  end
end
