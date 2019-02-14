class CreateRatings < ActiveRecord::Migration[5.0]
  def change
    create_table :ratings do |t|
      t.string :type
      t.string :comment
      t.references :user, foreign_key: true
      t.references :anime, foreign_key: true

      t.timestamps
      
      t.index [:user_id, :anime_id, :type], unique: true
    end
  end
end
