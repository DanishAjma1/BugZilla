class BugsUsers < ActiveRecord::Migration[7.2]
  def change
     create_table :bugs_users do |t|
      t.references :bug, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.string :email # To save the email when assigning the bug
      t.timestamps
    end
  end
end
