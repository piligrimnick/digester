class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.string :telegam_user_id, index: {unique: true}
      t.string :username
      t.string :first_name
      t.string :last_name
      t.boolean :is_bot

      t.boolean :blocked, index: true

      t.timestamps
    end
  end
end
