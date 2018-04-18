class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :name
      t.string :username
      t.string :password_digest
      t.belongs_to :language, foreign_key: true

      t.timestamps
    end
  end
end
