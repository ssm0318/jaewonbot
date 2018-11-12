class CreateLogs < ActiveRecord::Migration[5.1]
  def change
    create_table :logs do |t|
      t.string      :user_key
      t.string      :message

      t.timestamps
    end
  end
end
