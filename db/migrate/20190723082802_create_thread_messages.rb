class CreateThreadMessages < ActiveRecord::Migration[5.2]
  def change
    create_table :thread_messages do |t|
      t.string :replied_msg
      t.belongs_to :message, foreign_key: true

      t.timestamps
    end
  end
end
