class Question < ApplicationRecord

  acts_as_paranoid

  belongs_to :formulary

  # Enum para question_type
  enum question_type: { 
      texto: "texto", 
      imagem: "imagem" 
  }

  # Validações de name e seus retornos
  validates :name, 
            presence: { message: "Name cannot be blank." },
            uniqueness: { scope: :formulary_id, 
            message: "Name must be unique within the same formulary." }

  # Validações de question_type e seus retornos
  validates :question_type, 
            presence: { message: "Question type cannot be blank." },
            inclusion: { in: %w[texto imagem], 
            message: "Question type is not valid. Valid types are: #{question_types.keys.join(', ')}." }

  # Validações do formulary_id e seus retornos
  validates :formulary, 
            presence: { message: "Formulary cannot be blank." }

end
