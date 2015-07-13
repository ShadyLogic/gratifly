class CreateTreats < ActiveRecord::Migration
  def change
    create_table :treats do |t|
      t.string   :title
      t.boolean  :ready
      t.datetime :time_start
      t.integer	 :interval_in_seconds
      t.integer  :user_id
      t.timestamps
    end
  end
end
