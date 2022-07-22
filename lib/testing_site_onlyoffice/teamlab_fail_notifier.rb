# frozen_string_literal: true

require_relative 'telegram_perks'

module TestingSiteOnlyoffice
  # represents communication layer between telegram and something
  class TeamlabFailNotifier
    def self.send(message, chat = :community_error_chat)
      uri = URI.parse('http://qa-services.teamlab.info:8008/')
      request = Net::HTTP::Post.new(uri)
      request.set_form_data(
        notification: TelegramPerks.pimp_my_message(message),
        chat:
      )

      Net::HTTP.start(uri.hostname, uri.port) do |http|
        http.request(request)
      end
      OnlyofficeLoggerHelper.log('Test failure notification sent to telegram')
    end

    # Should current example run be notified of failure
    # @param [RSpec::Core::Example] example to check
    # @return [Boolean]
    def self.should_be_notified?(example)
      return false if OnlyofficeFileHelper::RubyHelper.debug?
      return false if example.attempts.zero?

      true
    end
  end
end
