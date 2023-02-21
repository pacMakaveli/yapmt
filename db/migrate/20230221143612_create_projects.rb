class CreateProjects < ActiveRecord::Migration[7.0]
  def change
    create_table :projects do |t|
      t.string :name, null: false, unique: true
      t.text :description

      t.integer :status, default: 0

      t.integer :comments_count, default: 0
      t.integer :changes_count, default: 0

      t.timestamps
    end
  end
end
