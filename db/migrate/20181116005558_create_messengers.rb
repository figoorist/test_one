class CreateMessengers < ActiveRecord::Migration[5.1]
  def change
    create_table :messengers do |t|
      t.string :name

      t.timestamps
    end
  end
end
