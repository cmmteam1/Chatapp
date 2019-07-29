class CreateChannels < ActiveRecord::Migration[5.2]
  def change
    create_table :channels do |t|
      t.string :ch_name
      t.boolean :status_id
      t.string :purpose
      t.belongs_to :workspace, foreign_key: true

      t.timestamps
    end
  end
end
