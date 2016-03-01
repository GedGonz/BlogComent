class CreateUsuarios < ActiveRecord::Migration
  def change
    create_table :usuarios do |t|
      t.string :username
      t.string :password
      t.string :nombre
      t.string :apellido
    end
  end
end
