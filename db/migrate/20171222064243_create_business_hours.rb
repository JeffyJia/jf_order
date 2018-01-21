class CreateBusinessHours < ActiveRecord::Migration[5.1]
  def change
    create_table :business_hours do |t|
      t.references :store, foreign_key: true
      t.time :open_at
      t.time :close_at

      t.timestamps
    end
  end
end
