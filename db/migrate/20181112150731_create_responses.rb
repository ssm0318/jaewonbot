class CreateResponses < ActiveRecord::Migration[5.1]
  def change
    create_table :responses do |t|
      t.string      :content
      t.string      :content_type
      t.belongs_to  :user, null: false

      t.timestamps
    end
    add_index :responses, :content_type
    add_index :responses, :user
  end
end
