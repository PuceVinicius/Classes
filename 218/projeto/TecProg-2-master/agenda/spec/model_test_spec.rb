require 'rails_helper'

RSpec.describe Atividade, type: :model do
############################## Testes de atributos #############################
    it "is valid with valid attributes" do
        expect(Atividade.new(nome: "Tecprog", horario_inicio: "12:30",
               horario_fim: "13:30", sala: "b10", professor: "Jonas Brothers")).to be_valid
    end

    it "is not valid without a teacher" do
        expect(Atividade.new(nome: "Tecprog", horario_inicio: "12:30",
               horario_fim: "13:30", sala: "b10", professor: nil)).to_not be_valid
    end

    it "is not valid without a classroom" do
        expect(Atividade.new(nome: "Tecprog", horario_inicio: "12:30",
               horario_fim: "13:30", sala: nil, professor: "Eminem")).to_not be_valid
    end

    it "is not valid without a starting time" do
        expect(Atividade.new(nome: "Tecprog", horario_inicio: nil,
               horario_fim: "13:30", sala: "b10", professor: "Eminem")).to_not be_valid
    end

    it "is not valid without a ending time" do
        expect(Atividade.new(nome: "Tecprog", horario_inicio: "12:30",
               horario_fim: nil, sala: "b10", professor: "Eminem")).to_not be_valid
    end

    it "is not valid without a name" do
        expect(Atividade.new(nome: nil, horario_inicio: "12:30",
               horario_fim: "13:30", sala: "b10", professor: "Eminem")).to_not be_valid
    end

############################## Testes de conflitos #############################
        # let!(:atividade1) { Atividade.new(nome: "Tecprog", horario_inicio: "10:00",
                            # horario_fim: "11:00", sala: "b10", professor: "Jonas Brothers") }
        # let!(:atividade2) { Atividade.new(nome: "Analise", horario_inicio: "10:30",
                            # horario_fim: "11:30", sala: "b10", professor: "Coelho") }
#         it "| two activities cant happen in the same class at the same time" do
#             expect { delete :new, params: { nome: "Tecprog", horario_inicio: "10:00",
#                                             horario_fim: "11:00", sala: "b10", professor: "Jonas Brothers" }
#                      delete :new, params: { nome: "Analise", horario_inicio: "10:30",
#                                             horario_fim: "11:30", sala: "b10", professor: "Coelho"}
#             }.to change { Atividade.all.count }.by(2)
#             # .to raise_error
#         end
end