require "telegram/bot"

module Messages
  class Daily
    attr_reader :bot

    def initialize
      token = ENV.fetch("TELEGRAM_BOT_TOKEN") { Rails.application.credentials.telegram[:token] }
      @bot = Telegram::Bot::Client.new(token, logger: Logger.new($stdout))
    end

    def send
      DailyReport.find_each do |report|
        bot.api.send_message(chat_id: report.chat.chat_id, text: report.render, parse_mode: "MarkdownV2")
      end
    end
  end
end
