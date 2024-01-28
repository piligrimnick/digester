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
class Report < ApplicationRecord
  belongs_to :chat
  has_many :message_counters


  def render
    total = message_counters.sum(:value)
    top_3 = message_counters.where(date: Time.now.to_date).order(value: :desc).first(3)

    rendered_top = top_3.map.with_index do |c, i|
      "#{i+1}\\. [#{c.user.first_name} #{c.user.last_name}](tg://user?id=#{c.user.telegam_user_id}) \\- *#{c.value}*"
    end.join("\n")

    <<~HEREDOC
      *Сегодня наспамили: #{total}*

      Больше всех старались:
      #{rendered_top}

      Увидимся завтра ;\\)
    HEREDOC
  end
end
