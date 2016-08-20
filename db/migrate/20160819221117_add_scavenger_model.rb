class AddScavengerModel < ActiveRecord::Migration
  def change
    create_table :scavengers do |t|
      t.string :clue
      t.string :guesses
      t.boolean :correct, default: false
    end
  end
end
