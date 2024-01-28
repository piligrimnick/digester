# == Schema Information
#
# Table name: chats
#
#  id         :bigint           not null, primary key
#  title      :string
#  type       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  chat_id    :string           not null
#
# Indexes
#
#  index_chats_on_chat_id  (chat_id) UNIQUE
#
class Chat < ApplicationRecord
  self.inheritance_column = :_type_disabled # https://apidock.com/rails/ActiveRecord/Base/inheritance_column/class

  has_many :reports
end
