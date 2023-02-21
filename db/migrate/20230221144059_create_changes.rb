class CreateChanges < ActiveRecord::Migration[7.0]
  def change
    create_table :changes do |t|
      t.belongs_to :project, null: false, foreign_key: true
      t.belongs_to :user, null: false, foreign_key: true
      t.belongs_to :comment, null: true, foreign_key: true

      t.string :from
      t.string :to

      t.timestamps
    end
  end
end
