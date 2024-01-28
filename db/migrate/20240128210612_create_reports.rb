class CreateReports < ActiveRecord::Migration[7.1]
  def change
    create_table :reports do |t|
      t.belongs_to :chat
      t.string :period, null: false, default: :daily
      t.datetime :message_time

      t.timestamps
    end
  end
end
