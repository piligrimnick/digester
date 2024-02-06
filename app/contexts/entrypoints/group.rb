module Entrypoints
  class Group
    attr_reader :bot, :chat, :user

    def initialize(bot, chat, user)
      @bot = bot
      @chat = chat
      @user = user
    end

    def handle(message)
      return if user.blocked

      Statistic::Entry.new(chat, user, message).count

      # return unless message.respond_to?(:text)

      # case message.text
      # in /налог/
      #   # bot.send_message
      # else
      #   # do nothing
      # end
    end
  end
end
