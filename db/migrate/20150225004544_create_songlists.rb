class CreateSonglists < ActiveRecord::Migration
  def change
    create_table :songlists do |t|

      t.string :year
      t.text :songs

      t.timestamps
    end
    add_index :songlists, :year
  end
end
