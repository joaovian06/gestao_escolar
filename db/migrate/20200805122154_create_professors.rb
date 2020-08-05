class CreateProfessors < ActiveRecord::Migration[5.2]
  def change
    create_table :professors do |t|
      t.string :ad
      t.string :name
      t.string :cellphone

      t.timestamps
    end
  end
end
