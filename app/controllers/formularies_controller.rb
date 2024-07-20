class FormulariesController < ApplicationController
  
  before_action :authorize # Para fazer qualquer ação em formularies é necessário estar autorizado (logado) com token
  before_action :set_formulary, only: %i[ show update destroy ] # Define o formulário em questão com base no URL e o define antes de qualquer ação nos métodos citados

  # GET /formularies
  def index
    formularies = Formulary.select(:id, :name)

    render json: formularies
  end

  # GET /formularies/1
  def show
    render json: @formulary
  end

  # POST /formularies
  def create
    @formulary = Formulary.new(formulary_params)

    if @formulary.save
      render json: @formulary, 
      status: :created, 
      location: @formulary
    else
      render json: @formulary.errors, 
      status: :unprocessable_entity
    end

  end

  # PATCH/PUT /formularies/1
  def update
    if @formulary.update(formulary_params)
      render json: @formulary
    else
      render json: @formulary.errors, status: :unprocessable_entity
    end
  end

  # DELETE /formularies/1 (Deletar formulário - soft delete)
  def destroy

    if @formulary.destroy
      render json: { message: 'Formulary deleted successfully' }, 
      status: :ok
    else
      render json: { errors: @formulary.errors.full_messages }, 
      status: :unprocessable_entity
    end

  end

  private

  # Encontra o Formulary pelo ID e o atribui à variável de instância @formulary.
  def set_formulary
    @formulary = Formulary.find(params[:id])
  end

  # Permite apenas o parâmetro name para o modelo Formulary.
  def formulary_params
    params.require(:formulary).permit(:name)
  end

end
