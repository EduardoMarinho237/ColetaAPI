class AnswersController < ApplicationController

  before_action :authorize # Para fazer qualquer ação em answers é necessário estar autorizado (logado) com token
  before_action :set_answer, only: %i[ show update destroy ]

  # GET /answers
  def index
    @answers = Answer.all

    render json: @answers.map { |answer| format_answer(answer) }
  end

  # GET /answers/1
  def show
    render json: @answer
  end

  # POST /answers
  def create
    @answer = Answer.new(answer_params)

    if @answer.save
      render json: @answer, status: :created
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
      render json: { message: 'Answer deleted successfully' }, status: :ok
    else
      render json: { errors: @answer.errors.full_messages }, status: :unprocessable_entity
    end

  end

  private

  def set_answer
    @answer = Answer.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'Answer not found' }, status: :not_found
  end

  def format_answer(answer) # Se o campo content for null, o json vai retornar o campo content_image_file_name no lugar dele em index
    {
      id: answer.id,
      content: answer.content.present? ? answer.content : answer.content_image_file_name,
      question_id: answer.question_id
    }
  end

  def answer_params
    params.permit(:content, :formulary_id, :question_id, :visit_id, :answered_at)
  end  
end
