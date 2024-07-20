class UsersController < ApplicationController
  
  before_action :authorize_request, except: [:create, :index, :login] # Para fazer qualquer ação em users é necessário estar autorizado (logado) com token, exceto nos metodos citados
  before_action :set_user, only: [:update, :show, :destroy] # Define o usuário em questão com base no URL e o define antes de qualquer ação nos métodos citados

  # GET /users (Listar todos os usuários por id e username)
  def index
    users = User.select(:id, :username)

    render json: users
  end

  # POST /users (Criar novo usuário)
  def create
    @user = User.new(user_params)

    if @user.save
      token = encode_token({ user_id: @user.id })
      render json: { user: @user, token: token }, 
      status: :ok
    else
      render json: { errors: @user.errors.full_messages }, 
      status: :unprocessable_entity
    end

  end

  # POST /login (Fazer login com usuário)
  def login
    Rails.logger.info "Login Params: #{params.inspect}"

    @user = User.find_by(username: user_params[:username])

    if @user && @user.authenticate(user_params[:password])
      token = encode_token({ user_id: @user.id })
      render json: { user: @user, token: token }, 
      status: :ok
    else
      render json: { error: 'Invalid username or password.' }, 
      status: :unprocessable_entity
    end

  end

  # GET /users/:id (Mostrar usuário por id)
  def show
    render json: @user
  end

  # PUT /users/:id (Atualizar usuário)
  def update

    if @user.update(user_params)
      render json: @user, 
      status: :ok
    else
      render json: { errors: @user.errors.full_messages }, 
      status: :unprocessable_entity
    end

  rescue StandardError => e

    render json: { error: e.message }, 
    status: :internal_server_error
  end

  # DELETE /users/:id (Deletar usuário - soft delete)
  def destroy

    if @user.destroy
      render json: { message: 'User deleted successfully' }, 
      status: :ok
    else
      render json: { errors: @user.errors.full_messages }, 
      status: :unprocessable_entity
    end
    
  end

  private

  # Define o usuário a partir do ID fornecido nos parâmetros e renderiza um erro se não for encontrado
  def set_user
    @user = User.find_by(id: params[:id])

    render json: { error: 'User not found' }, 
    status: :not_found if @user.nil?
  end

  # Permite apenas os parâmetros permitidos para criar ou atualizar um usuário
  def user_params
    params.require(:user).permit(:username, :password, :email, :cpf)
  end

  # Decodifica o token JWT e define o usuário atual com base no ID do token; retorna erro se o token for inválido ou o usuário não for encontrado
  def authorize_request
    decoded_token = decode_token

    if decoded_token
      @current_user = User.find_by(id: decoded_token[0]['user_id'])
      render json: { error: 'User not found' }, 
      status: :unauthorized if @current_user.nil?
    else
      render json: { error: 'Invalid token' }, 
      status: :unauthorized
    end

  end

end
