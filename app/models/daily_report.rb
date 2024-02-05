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
    top_5 = scope.order(value: :desc).first(5)

    rendered_top = top_5.map.with_index do |c, i|
      "#{i+1}\\. [#{c.user.first_name} #{c.user.last_name}](tg://user?id=#{c.user.telegam_user_id}) \\- *#{c.value}*"
    end.join("\n")

    hello_frase = "Доброго времени суток, коллеги\\!" # sample

    counter = "Написанные и прочитанные сообщения за вчера: #{total}"

    <<~HEREDOC
      #{hello_frase}

      *#{counter}*

      Это вот 5 самых активных :\\)
      #{rendered_top}

      Увидимся завтра ;\\)
    HEREDOC
  end

  def timeshift
    - 5.hours
  end
end
