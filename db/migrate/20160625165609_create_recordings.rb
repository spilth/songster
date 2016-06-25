class CreateRecordings < ActiveRecord::Migration[5.0]
  def change
    create_table :recordings do |t|
      t.string :name
      t.string :url
      t.text :description
      t.references :song, foreign_key: true

      t.timestamps
    end
  end
end
