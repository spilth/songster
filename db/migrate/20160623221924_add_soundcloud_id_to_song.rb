class AddSoundcloudIdToSong < ActiveRecord::Migration[5.0]
  def change
    add_column :songs, :soundcloud_id, :string
  end
end
