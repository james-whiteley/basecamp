class CreateProjects < ActiveRecord::Migration[6.0]
  def change
    create_table :projects do |t|
      t.string :title
      t.string :author
      t.datetime :to_be_completed
      t.datetime :completed

      t.timestamps
    end
  end
end
