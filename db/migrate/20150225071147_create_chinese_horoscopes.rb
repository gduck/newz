class CreateChineseHoroscopes < ActiveRecord::Migration
  def change
    create_table :chinese_horoscopes do |t|

      t.string :animal
      t.text :description

      t.timestamps
    end
    add_index :chinese_horoscopes, :animal
  end
end
