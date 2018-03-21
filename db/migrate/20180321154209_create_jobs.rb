class CreateJobs < ActiveRecord::Migration[5.1]
  def change
    create_table :jobs do |t|
      t.string :title
      t.string :location
      t.text :body

      t.timestamps
    end
  end
end
