class CreateResponses < ActiveRecord::Migration[5.1]
  def change
    create_table :responses do |t|
      t.string      :content
      t.string      :content_type

      t.timestamps
    end
  end
end
