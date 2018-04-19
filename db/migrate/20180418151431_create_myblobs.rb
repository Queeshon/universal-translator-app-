class CreateMyblobs < ActiveRecord::Migration[5.1]


  def change
    create_table :myblobs do |t|
      t.binary :blob, :limit => 10.megabyte
  end
end
end
