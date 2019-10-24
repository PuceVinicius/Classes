class AtividadesController < ApplicationController
    def create
        @atividade = Atividade.new(
             params.require(:atividade).permit(:nome, :horario_inicio, :horario_fim, :sala, :professor))
        # salva
        @atividade.save
        #testamos o salva
        if @atividade.save
            # mostra
            redirect_to @atividade
        else
            render 'new'
        end
    end

    def new
        @atividade = Atividade.new
    end

    def show
        @atividade = Atividade.find(params[:id])
    end

    def index
        @atividades = Atividade.all
    end

    def destroy
        @atividade = Atividade.find(params[:id])
        if @atividade.destroy
            flash[:notice] = "bye bye atividade!"
        end

        redirect_to atividades_path
    end

    def edit
        @atividade = Atividade.find(params[:id])
    end

    def update
        @atividade = Atividade.find(params[:id])
        if @atividade.update(atividades_params)
            redirect_to @atividade
        else
            render 'edit'
        end
    end

    private
    def atividades_params
       params.require(:atividade).permit(:nome, :horario_inicio, :horario_fim, :sala, :professor)
    end
end
