class VisitsController < ApplicationController

  before_action :authorize # Para fazer qualquer ação em visits é necessário estar autorizado (logado) com token
  before_action :set_visit, only: %i[ show update destroy ] # Define a visita em questão com base no URL e a define antes de qualquer ação nos métodos citados

  # GET /visits (Listar todas as visitas exibindo apenas id, data e status)
  def index
    visits = Visit.select(:id, :date, :status)

    render json: visits
  end

  # GET /visits/1 (Mostrar visita específica com mais detalhes)
  def show

    render json: @visit
  end

  # POST /visits (Criar nova visita)
  def create
    @visit = Visit.new(visit_params.merge(user: @user))

    if @visit.save
      render json: @visit, 
      status: :created, 
      location: @visit
    else
      render json: @visit.errors, 
      status: :unprocessable_entity
    end

  end

  # PATCH/PUT /visits/1 (Alterar algum registro de uma visita especificada pelo id)
  def update

    if @visit.update(visit_params)
      render json: @visit
    else
      render json: @visit.errors, 
      status: :unprocessable_entity
    end

  end

  # DELETE /visits/1 (Deletar visita)
  def destroy
    @visit.destroy!

    render json: { message: 'Visit deleted successfully' }, 
    status: :ok
  end

  private

  # Define a visita a partir do ID fornecido nos parâmetros e renderiza um erro se não for encontrado
  def set_visit
    @visit = Visit.find(params[:id])
  end

  # Permite apenas os parâmetros permitidos para criar ou atualizar uma visita
  def visit_params
    params.require(:visit).permit(:status, :date, :checkin_at, :checkout_at, :user_id)
  end

end
