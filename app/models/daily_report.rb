# == Schema Information
#
# Table name: reports
#
#  id           :bigint           not null, primary key
#  message_time :datetime
#  period       :string           default("daily"), not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  chat_id      :bigint
#
# Indexes
#
#  index_reports_on_chat_id  (chat_id)
#
class DailyReport < Report
  def render
    scope = message_counters.where(date: (Time.zone.now - 1.day).to_date)
    total = scope.sum(:value)
    top_10 = scope.order(value: :desc).first(10)

    rendered_top = top_10.map.with_index do |c, i|
      "#{i + 1}\\. [#{[c.user.first_name, c.user.last_name].compact.join(" ")}](tg://user?id=#{c.user.telegam_user_id}) \\- *#{c.value}*"
    end.join("\n")

    counter = "Написанные и прочитанные сообщения за вчера: #{total}"

    <<~HEREDOC
      #{hello_frase(total)}

      *#{counter}*

      Это вот 10 самых активных :\\)
      #{rendered_top}

      Увидимся завтра ;\\)
    HEREDOC
  end

  def timeshift
    - 5.hours
  end

  private

  def hello_frase(total)
    return special_hello if total < rand(200..800)

    hello_frases.sample
  end

  def hello_frases
    [
      "Доброе утро, дорогие чатланы\\! Сегодняшний день обещает быть таким же веселым, как ваше первое сообщение\\!",
      "Привет, интернет\\-герои\\! Готовы ли вы к новому дню, полному смайликов и неожиданных мемов\\?",
      "Добрейшего дня, друзья\\! Пусть ваше настроение будет таким же ярким, как этот виртуальный мир\\!",
      "Здравствуйте, уважаемые мастера клавиатуры\\! Пусть сегодня каждый из вас найдет повод для улыбки\\!",
      "Привет\\-привет, замечательные люди\\! Пусть ваш день будет полон сюрпризов и интересных разговоров\\!",
      "Доброе утро, чатовые энтузиасты\\! Пусть сегодня ваши пальцы будут так же быстры, как ваши мысли\\!",
      "Всем привет\\! Надеюсь, ваше утро началось с хороших новостей и вкусного кофе\\!",
      "Доброе утро, чудесные собеседники\\! Пусть сегодня каждый найдет в чате что\\-то новое и удивительное\\!",
      "Приветствую, друзья\\! Пусть сегодняшний день принесет вам массу позитивных эмоций и интересных открытий\\!",
      "Здравствуй, чат\\! Готовы ли вы к новому дню, полному общения, смеха и неожиданных тем\\?",
      "Доброго времени суток, коллеги\\!",
      "Доброе утро, дорогие чатлане\\! Готовы ли вы начать новый день с улыбкой и весельем\\?",
      "Привет\\-привет, интернет\\-супергерои\\! Давайте сегодня создадим еще больше ярких моментов\\!",
      "Добрейшего дня всем\\! Пусть ваш день будет полон радости и неожиданных сюрпризов\\!",
      "Привет, веселые собеседники\\! Сегодня у нас день отличного настроения и позитивных эмоций\\!",
      "Доброе утро, виртуальные исследователи\\! Пусть ваш день будет полон удивительных открытий и вдохновения\\!",
      "Всем привет\\! Начнем день с улыбки и хорошего настроения\\!",
      "Доброе утро, чудесные чатлане\\! Сегодня нас ждет много интересных бесед и позитивных эмоций\\!",
      "Приветствую всех\\! Пусть ваш день будет таким же ярким, как и ваши идеи\\!",
      "Здравствуй, чат\\! Готовы ли вы провести день с пользой и весельем\\?"
    ]
  end

  def special_hello
    <<~STRING
      Привет,  коллеги\\!

      Смотрю, сегодня мы были так заняты, что даже в чате тишина\\.\\.\\. Наверное, все взялись за работу так усердно, что даже времени на общение не нашлось\\! 🤔 Надеюсь, это потому, что мы все решили сконцентрироваться и вложить все силы в проекты, а не потому, что забыли пароли от чата\\. 😂 Давайте считать сегодняшний день \\"международным днем тишины в офисе\\" и пообещаем друг другу, что завтра будем не только эффективны в работе, но и чуть более активны в общении\\. В конце концов, вместе мы не только сила, но и отличная команда общителей\\!

      Поднимите руку, кто за то, чтобы завтра компенсировать сегодняшнюю тишину двойной порцией шуток и историй\\! 🙌😄
    STRING
  end
end
