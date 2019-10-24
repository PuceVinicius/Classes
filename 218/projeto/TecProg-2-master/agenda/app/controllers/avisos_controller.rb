class AvisosController < ApplicationController
  def index
    @title = 'Mural de avisos';
    @avisos = Aviso.all
  end

  def new
    @aviso = Aviso.new
  end

  def show
    @aviso = Aviso.find(params[:id])
  end

  def update
    @aviso = Aviso.find(params[:id])
    if(@aviso.update(aviso_params))
      redirect_to @aviso
    else
      render 'edit'
    end
  end

  def destroy
    @aviso = Aviso.find(params[:id])
    @aviso.destroy

    redirect_to avisos_path
  end

  def edit
    @aviso = Aviso.find(params[:id])
  end

  def create
    # render plain: params[:aviso].inspect
    @aviso = Aviso.new(aviso_params)

    if(@aviso.save)
      redirect_to @aviso
    else
      render 'new'
    end
  end

  private def aviso_params
    params.require(:aviso).permit(:title, :body)
  end
end
