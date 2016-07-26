class CreateRecords < ActiveRecord::Migration[5.0]
  def change
    create_table :records do |t|
      t.string :title
      t.string :artist
      t.string :string
      t.string :year
      t.string :integer
      t.string :conver_art
      t.string :string
      t.string :song_count
      t.string :integer

      t.timestamps
    end
  end
end
