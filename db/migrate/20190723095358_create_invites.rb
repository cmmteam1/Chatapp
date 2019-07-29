class CreateInvites < ActiveRecord::Migration[5.2]
  def change
    create_table :invites do |t|
      t.string :role
      t.belongs_to :user, foreign_key: true
      t.belongs_to :channel, foreign_key: true

      t.timestamps
    end
  end
end
