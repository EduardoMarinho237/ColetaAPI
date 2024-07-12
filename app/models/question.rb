class Question < ApplicationRecord
  belongs_to :formulary

  enum question_type: { texto: "texto", imagem: "imagem"  }
end
