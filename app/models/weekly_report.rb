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
      "#{i+1}\\. [#{c.user.first_name} #{c.user.last_name}](tg://user?id=#{c.user.telegam_user_id}) \\- *#{c.value}*"
    end.join("\n")

    hello_frase = "На этой неделе чего только не обсуждали\\!" # sample

    counter = "Вот столько всего сообщений было написано: #{total}"

    <<~HEREDOC
      #{hello_frase}

      *#{counter}*

      Топ\\-10:
      #{rendered_top}
    HEREDOC
  end

  def timeshift
    - 5.hours + 1.day
  end
end
