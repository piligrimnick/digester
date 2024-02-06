module Entrypoints
  class Private
    attr_reader :bot, :chat, :user

    def initialize(bot, chat, user)
      @bot = bot
      @chat = chat
      @user = user
    end

    def handle(message)
      case message
      in Telegram::Bot::Types::ChatMemberUpdated
        # blocking and unblocking here
        if message.new_chat_member&.is_a?(Telegram::Bot::Types::ChatMemberBanned)
          user.update(blocked: true)
        elsif message.new_chat_member&.is_a?(Telegram::Bot::Types::ChatMemberMember)
          user.update(blocked: false)
        end
      else
        return unless message.respond_to?(:text)
        case message.text
        when "ping" then bot.api.send_message(chat_id: chat.chat_id, text: "pong")
        else
          # do nothing
        end
      end
    end
  end
end
