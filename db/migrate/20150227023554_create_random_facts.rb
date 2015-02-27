class CreateRandomFacts < ActiveRecord::Migration
  def change
    create_table :random_facts do |t|

      t.date :date
      t.string :gold
      t.string :dowjones
      t.string :homeprice
      t.string :newcar
      t.string :bread
      t.string :gas
      t.string :population

      t.timestamps
    end
    add_index :random_facts, :date
  end
end
