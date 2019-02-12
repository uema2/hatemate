class CreateAnimes < ActiveRecord::Migration[5.0]
  def change
    create_table :animes do |t|
      t.string :code
      t.string :title
      t.string :media
      t.string :season
      t.string :url
      t.string :image_url

      t.timestamps
    end
  end
end
