class CreateChats < ActiveRecord::Migration[5.1]
  def change
    create_table :chats do |t|
      t.belongs_to    :user, null: false
      t.text          :content

      t.timestamps
    end
  end
end
