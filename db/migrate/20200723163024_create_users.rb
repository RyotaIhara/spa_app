class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :name, null: false
      t.integer :age, null: false
      t.boolean :gender, null: false, default: false
      t.text :note

      t.timestamps
    end
  end
end
