class CreateRecords < ActiveRecord::Migration[5.0]
  def change
    create_table :records do |t|
      t.string :title
      t.string :artist
      t.integer :year
      t.string :cover_art
      t.integer :song_count

      t.timestamps
    end
  end
end
