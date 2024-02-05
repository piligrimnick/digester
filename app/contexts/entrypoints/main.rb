module Entrypoints
  class Main
    include Dry::Monads[:do, :result]

    ENTRYPOINTS = {
      private: Entrypoints::Private,
      group: Entrypoints::Group,
      supergroup: Entrypoints::Group,
    }.freeze

    attr_reader :bot

    def initialize(bot)
      @bot = bot
    end

    def handle(message)
      t_chat, t_user = message.chat, message.from

      chat = yield retrieve_chat(t_chat)
      user = yield retrieve_user(t_user)

      ENTRYPOINTS[chat.type.to_sym].new(bot, chat, user).handle(message)
    end

    private

    def retrieve_chat(t_chat)
      chat = Chat.create_with(title: t_chat.title)
        .find_or_create_by(chat_id: t_chat.id, type: t_chat.type)

      Success(chat)
    end

    def retrieve_user(t_user)
      user = User.create_with(t_user.to_h.slice(*%i[is_bot first_name last_name username]))
        .find_or_create_by(telegam_user_id: t_user.id)

      Success(user)
    end
  end
end
