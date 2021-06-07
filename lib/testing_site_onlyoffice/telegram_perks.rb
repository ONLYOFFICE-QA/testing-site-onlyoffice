# frozen_string_literal: true

module TestingSiteOnlyoffice
  # Telegram error message redactor
  module TelegramPerks
    def self.pimp_my_message(msg)
      hashtags = tags(msg).map { |tag| "##{tag}" }.join(' ')
      msg += "\n#{hashtags}"
      msg
    end

    def self.tags(msg)
      hashtags = {
        socketio: ['[Mail]', '[Feed]', '[Talk and MicroTalk]', '[Fulltext Search]'],
        jabber: ['[Talk and MicroTalk]'],
        diskspace: ['[Documents]', '[Fulltext Search]'],
        sphinx: ['[Fulltext Search]'],
        domain: ['domain onlyomail'],
        mailaggregator: ['mail server', '[Mail]'],
        registration: ['Create portal'],
        documents: ['[Documents]'],
        mailreply: ['[Mail Reply]'],
        feed: ['[Feed]'],
        helpcenter: ['[HelpCenter]']
      }

      tags = []
      hashtags.each do |key, values|
        values.each do |value|
          if msg.include? value
            tags << key
            break
          end
        end
      end
      tags
    end
  end
end
