class CreateMessages < ActiveRecord::Migration[5.2]
  def change
    create_table :messages do |t|
      t.string :content
      t.boolean :star_msg
      t.string :attached_file
      t.boolean :unread_msg
      t.belongs_to :channel, foreign_key: true
      t.belongs_to :user, foreign_key: true

      t.timestamps
    end
  end
end
