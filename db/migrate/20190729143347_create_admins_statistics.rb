class CreateAdminsStatistics < ActiveRecord::Migration[5.2]
  def change
    create_table :admins_statistics do |t|
      t.string :event
      t.string :string
      t.integer :value, default: 0

      t.timestamps
    end
  end
end
