class CreateAtividades < ActiveRecord::Migration[5.2]
  def change
    create_table :atividades do |t|
      t.string :nome
      t.datetime :horario_inicio
      t.datetime :horario_fim
      t.string :sala
      t.string :professor

      t.timestamps
    end
  end
end
