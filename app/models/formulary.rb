class Formulary < ApplicationRecord

  acts_as_paranoid

  # Define associações com perguntas e respostas; se o objeto principal for excluído, as referências nas tabelas associadas são definidas como NULL.
  has_many :questions, dependent: :nullify
  has_many :answers, dependent: :nullify
  
  # Validações de name e seus retornos
  validates :name,
  presence: { message: "Name cannot be blank." },
  uniqueness: { message: "Formulary name already exists." }

end
