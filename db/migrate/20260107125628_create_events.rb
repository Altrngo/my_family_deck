class CreateEvents < ActiveRecord::Migration[8.1]
  def change
    create_table :events do |t|
      t.references :child, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.string :type
      t.datetime :start_time
      t.datetime :end_time
      t.float :value_float
      t.string :value_string
      t.text :comment
      t.boolean :parent_validation
      t.datetime :created_at
      t.datetime :updated_at

      # t.timestamps supprimé car fait doublon avec created_at
    end
  end
end
