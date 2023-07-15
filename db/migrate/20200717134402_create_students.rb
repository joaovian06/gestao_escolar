class CreateStudents < ActiveRecord::Migration[5.2]
  def change
    create_table :students do |t|
      t.string :name
      t.string :address
      t.string :email
      t.date :birthday
      t.integer :gender
      t.boolean :disability

      t.timestamps
    end
  end
end
