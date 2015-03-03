class CreateCards < ActiveRecord::Migration
  def change
    create_table :cards do |t|

      t.date :date
      t.string :name
      t.string :feature_heading
      t.string :feature_article
      t.string :author

      t.timestamps
    end
  end
end
