class CreateTweets < ActiveRecord::Migration
  def change
    create_table :tweets do |t|
      t.text :tweet
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
