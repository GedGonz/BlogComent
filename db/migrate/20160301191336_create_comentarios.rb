class CreateComentarios < ActiveRecord::Migration
  def change
    create_table :comentarios do |t|
      t.string :nombre
      t.string :comentario
      t.date :fecha
      t.integer :padre
      t.integer :tipo
      t.references :articulo, index: true
    end
  end
end
