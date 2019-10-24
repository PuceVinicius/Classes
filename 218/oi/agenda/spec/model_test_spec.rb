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

    it "| two activities cant happen in the same class at the same time" do
        ativ1 = Atividade.new(nome: "Tecprog", horario_inicio: "10:00",
               horario_fim: "11:00", sala: "b10", professor: "Jonas Brothers")
        ativ1.save
        #conflito começando depois
        expect(Atividade.new(nome: "Analise", horario_inicio: "10:30",
                      horario_fim: "11:30", sala: "b10", professor: "Coelho")).to_not be_valid
        #conflito começando antes
        expect(Atividade.new(nome: "Analise", horario_inicio: "9:30",
                      horario_fim: "10:30", sala: "b10", professor: "Coelho")).to_not be_valid
        #conflito no mesmo horário
        expect(Atividade.new(nome: "Analise", horario_inicio: "10:00",
                      horario_fim: "11:00", sala: "b10", professor: "Coelho")).to_not be_valid
        #começando antes e acabando depois
        expect(Atividade.new(nome: "Analise", horario_inicio: "9:00",
            horario_fim: "13:00", sala: "b10", professor: "Coelho")).to_not be_valid
    end

    it "| same professor cant be in different classes at the same time" do
        ativ1 = Atividade.new(nome: "Tecprog", horario_inicio: "10:00",
               horario_fim: "11:00", sala: "b10", professor: "Gubi")
        ativ1.save

        expect(Atividade.new(nome: "Analise", horario_inicio: "10:00",
                      horario_fim: "11:00", sala: "b11", professor: "Gubi")).to_not be_valid
    end

    ############################## Teste de validade do horário #############################

        it "needs to have valid duration" do
            expect(Atividade.new(nome: "Tecprog2", horario_inicio: "11:00",
                          horario_fim: "10:00", sala: "b10", professor: "Gubi")).to_not be_valid
        end
end