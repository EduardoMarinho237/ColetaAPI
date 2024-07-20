class Answer < ApplicationRecord  

  acts_as_paranoid 

  belongs_to :formulary
  belongs_to :question
  belongs_to :visit

  # Validações de formulary e seus retornos
  validates :formulary_id, 
  presence: { message: "Formulary_id cannot be blank." }
  
  # Validações de question e seus retornos
  validates :question_id, 
  presence: { message: "Question_id cannot be blank." }

end
