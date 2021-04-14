# represents communication layer between telegram and something
require_relative 'telegram_perks'

module TestingSiteOnlyoffice
  class TeamlabFailNotifier
    # @return [Array<String>] exception with words should be ignored
    IGNORED_EXCEPTIONS = ['reCAPTCHA'].freeze

    def self.send(message, chat = :community_error_chat)
      uri = URI.parse('http://qa-services.teamlab.info:8008/')
      request = Net::HTTP::Post.new(uri)
      request.set_form_data(
        notification: TelegramPerks.pimp_my_message(message),
        chat: chat
      )

      Net::HTTP.start(uri.hostname, uri.port) do |http|
        http.request(request)
      end
    end

    # @return [True, False] is fail should be ignored
    def self.should_be_ignored?(example)
      IGNORED_EXCEPTIONS.each do |current_exception|
        return true if example.exception.to_s.include?(current_exception)
      end
      false
    end
  end
end
