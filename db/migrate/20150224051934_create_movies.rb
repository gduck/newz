class CreateMovies < ActiveRecord::Migration
  def change
    create_table :movies do |t|

      t.string :year
      t.string :bestMovie
      t.text :producers
      t.text :nominees

      t.string :bestActor
      t.string :bestActorMovie
      t.string :bestActress
      t.string :bestActressMovie

      t.timestamps
    end
  add_index :movies, :year
  end
end
