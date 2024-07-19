class Visit < ApplicationRecord
  belongs_to :user

  # Enum para status disponíveis da visita
  enum status: { 
      pendente: "pendente", 
      realizando: "realizando", 
      realizada: "realizada"  
  }

  # Validações de data e seus retornos
  validates :date, 
            presence: { message: "Date cannot be blank." },
            comparison: { greater_than_or_equal_to: -> { Date.current }, 
            message: "Date must be today or in the future." }

  # Validações de status e seus retornos
  validates :status, 
            presence: { message: "Status cannot be blank." },
            inclusion: { in: %w[pendente realizando realizada], 
            message: "Status is not valid. Valid statuses are: #{statuses.keys.join(', ')}." } # Testar**

  # Validações de checkin_at e seus retornos
  validates :checkin_at, 
            presence: { message: "Check-in time cannot be blank." },
            comparison: { less_than: -> { DateTime.current }, 
            message: "Check-in time must be in the past." },
            if: :checkout_at

  # Validações de checkout_at e seus retornos
  validates :checkout_at, 
            presence: { message: "Check-out time cannot be blank." },
            comparison: { greater_than: :checkin_at, 
            message: "Check-out time must be after check-in time." }

  # Validações de user_id e seus retornos
  validates :user, 
            presence: { message: "User cannot be blank." }

  private

  # Método para verificar se o user_id é válido
  def user_id_exists
    errors.add(:user_id, 'User must be valid.') unless User.exists?(self.user_id)
  end
end
