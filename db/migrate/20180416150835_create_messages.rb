class CreateMessages < ActiveRecord::Migration[5.1]
  def change
    create_table :messages do |t|
      t.integer :sender_id, foreign_key: true
      t.integer :recipient_id, foreign_key: true
      t.belongs_to :conversation, foreign_key: true
      t.string :content

      t.timestamps
    end
  end
end
