require "telegram/bot"

module Messages
  class TaxReply
    attr_reader :bot, :message

    def initialize(message)
      token = ENV.fetch("TELEGRAM_BOT_TOKEN") { Rails.application.credentials.telegram[:token] }
      @bot = Telegram::Bot::Client.new(token, logger: Logger.new($stdout))
      @message = message
    end

    def send
      bot.api.send_message(chat_id: message.chat.id, reply_to_message_id: message.message_id, text: replies.sample, parse_mode: "MarkdownV2")
    end

    private

    def replies
      [
        "Налоги такие высокие, что я скоро начну подавать декларацию на каждый смешок и улыбку, чтобы сэкономить на хорошее настроение\\!",
        "С такими налогами я скоро буду просить скидку на воздух\\. А ведь говорили, что смех – лучшее лекарство, надеюсь, его еще не обложили\\!",
        "Если налоги еще немного поднимут, я начну платить их улыбками и добрыми словами\\. Вдруг у них тоже хорошее настроение поднимется\\?",
        "Налоги такие высокие, что я уже подумываю о налоговом вычете на каждый вдох и выдох\\. Может, это хоть немного сэкономит мою жизненную энергию\\!",
        "Говорят, что налоги – это цена цивилизации\\. С такими ставками я, видимо, уже оплатил свой абонемент в клуб 'Плати и плачь' на ближайшие десять лет\\!",
      ]
    end
  end
end
