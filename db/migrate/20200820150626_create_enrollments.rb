class CreateEnrollments < ActiveRecord::Migration[5.2]
  def change
    create_table :enrollments do |t|
      t.string :registration_num
      t.references :student, foreign_key: true
      t.references :classroom, foreign_key: true

      t.timestamps
    end
  end
end
