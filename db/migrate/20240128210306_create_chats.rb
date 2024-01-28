class CreateChats < ActiveRecord::Migration[7.1]
  def change
    create_table :chats do |t|
      t.string :chat_id, null: false, index: {unique: true}
      t.string :type, null: false
      t.string :title

      t.timestamps
    end
  end
end
