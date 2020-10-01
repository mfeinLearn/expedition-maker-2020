class CreateExpeditionEquipments < ActiveRecord::Migration[6.0]
  def change
    create_table :expedition_equipments do |t|
      t.references :expedition, null: false, foreign_key: true
      t.references :equipment, null: false, foreign_key: true

      t.timestamps
    end
  end
end
