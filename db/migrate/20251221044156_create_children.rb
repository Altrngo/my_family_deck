class CreateChildren < ActiveRecord::Migration[8.1]
  def change
    create_table :children do |t|
      t.string :name
      t.date :birth_date
      t.string :gender
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
