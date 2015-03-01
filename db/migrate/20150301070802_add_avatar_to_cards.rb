class AddAvatarToCards < ActiveRecord::Migration
  def change

    def self.up
      add_attachment :cards, :avatar
    end

    def self.down
      remove_attachment :cards, :avatar
    end

  end
end
