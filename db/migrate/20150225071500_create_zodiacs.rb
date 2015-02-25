class CreateZodiacs < ActiveRecord::Migration
  def change
    create_table :zodiacs do |t|

      t.string :sign
      t.text :description

      t.timestamps
    end
    add_index :zodiacs, :sign
  end
end
