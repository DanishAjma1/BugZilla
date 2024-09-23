class CreateBugs < ActiveRecord::Migration[7.2]
  def change
    create_table :bugs do |t|
      t.string :title
      t.string :type
      t.string :status

      t.timestamps
    end
  end
end
