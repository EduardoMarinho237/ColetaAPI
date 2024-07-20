class AnswersController < ApplicationController

  before_action :authorize # Para fazer qualquer ação em answers é necessário estar autorizado (logado) com token
  before_action :set_answer, only: %i[ show update destroy ]

  # GET /answers
  def index
    answers = Answer.select(:id, :content, :question_id)

    render json: answers
  end

  # GET /answers/1
  def show
    render json: @answer
  end

  # POST /answers
  def create
    @answer = Answer.new(answer_params)

    if @answer.save
      render json: @answer, status: :created, location: @answer
    else
      render json: @answer.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /answers/1
  def update
    if @answer.update(answer_params)
      render json: @answer
    else
      render json: @answer.errors, status: :unprocessable_entity
    end
  end

  # DELETE /answers/1 (Deleta resposta - soft delete)
  def destroy

    if @answer.destroy
      render json: { message: 'Answer deleted successfully' }, 
      status: :ok
    else
      render json: { errors: @answer.errors.full_messages }, 
      status: :unprocessable_entity
    end

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_answer
      @answer = Answer.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def answer_params
      params.require(:answer).permit(:content, :formulary_id, :question_id, :visit_id, :answered_at)
    end
end
