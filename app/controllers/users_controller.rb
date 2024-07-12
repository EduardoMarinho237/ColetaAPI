class UsersController < ApplicationController
  before_action :set_user, only: [:update, :index, :destroy]
  before_action :authorize_request, except: [:create, :login]

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
      render json: { user: @user, token: token }, status: :ok
    else
      render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # POST /login (Fazer login com usuário)
  def login
    Rails.logger.info "Login Params: #{params.inspect}"

    @user = User.find_by(username: user_params[:username])

    if @user && @user.authenticate(user_params[:password])
      token = encode_token({ user_id: @user.id })
      render json: { user: @user, token: token }, status: :ok
    else
      render json: { error: 'Invalid username or password.' }, status: :unprocessable_entity
    end
  end

  # GET /users/:id (Mostrar usuário por id)
  def show
    render json: @user
  end

  # PUT /users/:id (Atualizar usuário)
  def update
    if @user.update(user_params)
      render json: @user, status: :ok
    else
      render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
    end
  rescue StandardError => e
    render json: { error: e.message }, status: :internal_server_error
  end

  # DELETE /users/:id (Deletar usuário)
  def destroy
    @user.destroy
    render json: { message: 'User deleted successfully' }, status: :ok
  end

  private

  def set_user
    @user = User.find_by(id: params[:id])
    render json: { error: 'User not found' }, status: :not_found if @user.nil?
  end

  def user_params
    params.require(:user).permit(:username, :password, :email, :cpf)
  end

  def authorize_request
    header = request.headers['Authorization']
    header = header.split(' ').last if header
    begin
      decoded = decode_token(header)
      @current_user = User.find(decoded[:user_id])
    rescue ActiveRecord::RecordNotFound => e
      render json: { error: e.message }, status: :unauthorized
    rescue JWT::DecodeError => e
      render json: { error: e.message }, status: :unauthorized
    end
  end

  def encode_token(payload)
    JWT.encode(payload, Rails.application.secrets.secret_key_base, 'HS256')
  end

  def decode_token(token)
    JWT.decode(token, Rails.application.secrets.secret_key_base, true, algorithm: 'HS256').first
  end
end
