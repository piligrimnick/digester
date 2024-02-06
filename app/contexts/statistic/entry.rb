module Statistic
  class Entry
    attr_reader :chat, :user, :message

    def initialize(chat, user, message)
      @chat, @user, @message = chat, user, message
    end

    def count
      chat.daily_reports.each do |report|
        time = Time.zone.at(message.date) + report.timeshift

        message_counter = report.message_counters.find_or_create_by(user_id: user.id, date: time.beginning_of_day.to_date)
        message_counter.value += 1
        message_counter.save
      end

      chat.weekly_reports.each do |report|
        time = Time.zone.at(message.date) + report.timeshift

        message_counter = report.message_counters.find_or_create_by(user_id: user.id, date: time.beginning_of_week.to_date)
        message_counter.value += 1
        message_counter.save
      end
    end
  end
end
