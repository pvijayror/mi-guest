class CreateAccommodations < ActiveRecord::Migration
  def change
    create_table :accommodations do |t|
      t.references :guest
      t.references :document_type
      t.references :residence
      t.date :entry_date
      t.date :checkout_date

      t.timestamps
    end
    add_index :accommodations, :guest_id
    add_index :accommodations, :document_type_id
    add_index :accommodations, :residence_id
  end
end
