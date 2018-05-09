class CreateSessions < ActiveRecord::Migration[5.1]
  def change
    create_table :sessions do |t|
      t.integer :user_id, null: false
      t.string :session_token, null: false
      t.string :ip_address, null: false
    end

    add_index :sessions, :user_id
    add_index :sessions, :ip_address
    add_index :sessions, :session_token
  end
end
