class CreateArticulos < ActiveRecord::Migration
  def change
    create_table :articulos do |t|
      t.string :titulo
      t.string :descripcion
      t.string :autor
      t.date :fecha
      t.string :image
      t.references :usuario, index: true
    end
  end
end
