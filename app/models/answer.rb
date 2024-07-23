require 'open-uri'
require 'net/http'

class Answer < ApplicationRecord

  # Configuração do Paperclip para o campo content_image
  has_attached_file :content_image
  validates_attachment_content_type :content_image, content_type: /\Aimage\/.*\z/

  acts_as_paranoid

  belongs_to :formulary
  belongs_to :question
  belongs_to :visit

  # Validações de content e seus retornos
  validates :content, presence: { message: "Content cannot be blank." }
  validate :validate_content

  # Validações de formulary e seus retornos
  validates :formulary_id, presence: { message: "Formulary_id cannot be blank." }

  # Validações de question e seus retornos
  validates :question_id, presence: { message: "Question_id cannot be blank." }

  before_save :process_content

  private

  def validate_content
    return if content.blank?
  
    if content =~ URI::DEFAULT_PARSER.make_regexp(%w[http https])
      uri = URI.parse(content)
      begin
        response = Net::HTTP.get_response(uri)
        if response.is_a?(Net::HTTPSuccess) && response.content_type =~ /image/
          # URL é válida e o conteúdo é uma imagem
        else
          errors.add(:content, 'must be a URL of an image')
        end
      rescue SocketError, Errno::ECONNREFUSED
        errors.add(:content, 'must be a valid URL')
      end
    else
      errors.add(:content, 'must be a valid URL')
    end
  rescue URI::InvalidURIError
    errors.add(:content, 'must be a valid URL')
  end  

  def process_content
    return if content.blank? || !(content =~ URI::DEFAULT_PARSER.make_regexp(%w[http https]))

    uri = URI.parse(content)
    temp_image = download_image(uri)
    self.content_image = temp_image
    self.content = nil  # Remove o conteúdo original, pois agora temos a imagem
  rescue OpenURI::HTTPError => e
    errors.add(:content, "failed to process image from URL: #{e.message}")
  end

  def download_image(uri)
    file = Tempfile.new(['image', '.jpg'], binmode: true)
    file.write(URI.open(uri).read)
    file.rewind
    file
  rescue OpenURI::HTTPError => e
    errors.add(:content, "failed to download image from URL: #{e.message}")
    nil
  end
  
end
