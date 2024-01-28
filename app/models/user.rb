# == Schema Information
#
# Table name: users
#
#  id              :bigint           not null, primary key
#  blocked         :boolean
#  first_name      :string
#  is_bot          :boolean
#  last_name       :string
#  username        :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  telegam_user_id :string
#
# Indexes
#
#  index_users_on_blocked          (blocked)
#  index_users_on_telegam_user_id  (telegam_user_id) UNIQUE
#
class User < ApplicationRecord
  has_many :message_counters, dependent: :destroy
end
