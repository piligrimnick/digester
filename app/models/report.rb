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
  self.inheritance_column = :period

  belongs_to :chat
  has_many :message_counters

  def render
    raise NotImplementedError
  end

  def self.sti_class_for(period_name)
    case period_name
    when "daily" then DailyReport
    when "weekly" then WeeklyReport
    end
  end

  def self.sti_name
    case name
    when "DailyReport" then "daily"
    when "WeeklyReport" then "weekly"
    end
  end
end
