class CreateSongs < ActiveRecord::Migration[5.0]
  def change
    create_table :songs do |t|
      t.string :title
      t.text :lyrics
      t.text :notes

      t.timestamps
    end
  end
end
