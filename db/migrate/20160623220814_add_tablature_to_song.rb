class AddTablatureToSong < ActiveRecord::Migration[5.0]
  def change
    add_column :songs, :tablature, :text
  end
end
