class CreateAttendings < ActiveRecord::Migration
  def change
    create_table :attendings do |t|
      t.references :event, index: true
      t.references :user, index: true

      t.timestamps
    end
  end
end
