class CreateJoinTable < ActiveRecord::Migration[7.2]
  def change
    create_join_table :projects, :users do |t|
      t.index :project_id
      t.index :user_id
    end
  end
end
