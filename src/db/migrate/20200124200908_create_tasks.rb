class CreateTasks < ActiveRecord::Migration[6.0]
  def change
    create_table :tasks do |t|
      t.string :title
      t.references :project, null: false, foreign_key: true
      t.string :author
      t.datetime :to_be_completed
      t.datetime :completed

      t.timestamps
    end
  end
end
