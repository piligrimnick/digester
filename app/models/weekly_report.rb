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
class WeeklyReport < Report
  def render
    scope = message_counters.where(date: Time.zone.now.beginning_of_week.to_date)
    total = scope.sum(:value)
    top_10 = scope.order(value: :desc).first(10)

    rendered_top = top_10.map.with_index do |c, i|
      "#{i + 1}\\. [#{c.user.first_name} #{c.user.last_name}](tg://user?id=#{c.user.telegam_user_id}) \\- *#{c.value}*"
    end.join("\n")

    counter = "Вот столько всего сообщений было написано: #{total}"

    <<~HEREDOC
      #{hello_frases.sample}

      *#{counter}*

      Топ\\-10:
      #{rendered_top}
    HEREDOC
  end

  def timeshift
    - 5.hours + 1.day
  end

  private

  def hello_frases
    [
      "С воскресным утром, дорогие чатлане\\! Подводя итоги нашей недели, хочу сказать, что каждый из вас внес нечто особенное в наше общение\\. Давайте вместе радоваться достигнутым вершинам и заряжаться энергией на новые свершения\\!",
      "Привет в это воскресное утро, уважаемые обитатели нашего уютного уголка\\! Очередная неделя прошла, оставив за собой множество ярких моментов и впечатлений\\. Пусть впереди нас ждут новые достижения и еще больше причин для гордости\\!",
      "Доброе воскресное утро, чудесные участники\\! Наша неделя была полна событий, обсуждений и новых идей\\. Спасибо каждому за активность и желание делиться\\! Давайте вспомним самое важное и настроимся на новые победы в предстоящей неделе\\.",
      "Воскресное утро наступило, и это время подвести итоги нашей недели в чате\\. Было много интересного: шутки, дружеские поддержки, полезные советы\\. Спасибо вам за это\\! Давайте взглянем назад с улыбкой и начнем новую неделю с чистого листа и новыми надеждами\\!",
      "Приветствую вас в это прекрасное воскресное утро, наши дорогие чатовые путешественники\\! Заканчивая неделю, мы не только набрались опыта, но и обменялись массой эмоций\\. Пусть этот итог будет для нас ступенькой к новым вершинам общения и вдохновения на следующую неделю\\!",
      "Воскрис\\-утро приносит мураш\\-вибры в день\\! Мой криклопусяк заспандюрился в эхе невидимек\\. Поделитесь гензглюками недели, дабы мы гиперплюмбию новую разжигали\\. Свои телепат\\-лампики зажигайте, амики\\!"
    ]
  end
end
