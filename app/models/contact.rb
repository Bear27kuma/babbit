class Contact < ApplicationRecord
  attr_accessor :name, :email, :content
  validates :name, presence: true, length: {maximum: 50}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, length: {maximum: 255}, format: {with: VALID_EMAIL_REGEX}
  validates :content, presence: true, length: {maximum: 1000}

  #お問い合わせ内容をメールで送信する
  def send_contact_email
    ContactMailer.contact_mail(self).deliver_now
  end
end
