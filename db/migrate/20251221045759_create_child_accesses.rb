class CreateChildAccesses < ActiveRecord::Migration[8.1]
  def change
    create_table :child_accesses do |t|
      t.references :child, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.string :role

      t.timestamps
    end

    add_index :child_accesses, [:child_id, :user_id], unique: true
  end
end
