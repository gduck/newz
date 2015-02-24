class CreateMovies < ActiveRecord::Migration
  def change
    create_table :movies do |t|

      t.string :year
      t.string :bestMovie
      t.text :producers
      t.text :nominees

      t.timestamps
    end
  add_index :movies, :year
  end
end
