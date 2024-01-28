class CreateMessageCounters < ActiveRecord::Migration[7.1]
  def change
    create_table :message_counters do |t|
      t.belongs_to :user, index: false
      t.belongs_to :report, index: false
      t.integer :value, default: 0
      t.date :date

      t.timestamps
    end

    add_index :message_counters, [:user_id, :report_id, :date], unique: true
  end
end
