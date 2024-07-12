class Visit < ApplicationRecord
  belongs_to :user

  enum status: { 
    pendente: "pendente", 
    realizando: "realizando", 
    realizada: "realizada"  
  }
end
