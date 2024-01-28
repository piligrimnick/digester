# == Schema Information
#
# Table name: message_counters
#
#  id         :bigint           not null, primary key
#  date       :date
#  value      :integer          default(0)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  report_id  :bigint
#  user_id    :bigint
#
# Indexes
#
#  index_message_counters_on_user_id_and_report_id_and_date  (user_id,report_id,date) UNIQUE
#
class MessageCounter < ApplicationRecord
  belongs_to :report
  belongs_to :user
end
