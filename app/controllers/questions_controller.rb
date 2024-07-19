class QuestionsController < ApplicationController

  before_action :authorize # Para fazer qualquer ação em questions é necessário estar autorizado (logado) com token
  before_action :set_question, only: %i[ show update destroy ]

  # GET /questions
  def index
    questions = Question.select(:id, :name, :formulary_id, :question_type)
    
    render json: questions
  end

  # GET /questions/1
  def show
    render json: @question
  end

  # POST /questions
  def create
    @question = Question.new(question_params)

    if @question.save
      render json: @question, status: :created, location: @question
    else
      render json: @question.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /questions/1
  def update
    if @question.update(question_params)
      render json: @question
    else
      render json: @question.errors, status: :unprocessable_entity
    end
  end

  # DELETE /questions/1
  def destroy
    @question.destroy!

    render json: { message: 'Question deleted successfully' }, 
    status: :ok
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_question
      @question = Question.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def question_params
      params.require(:question).permit(:name, :formulary_id, :question_type)
    end
end
