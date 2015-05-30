require 'bcrypt'
class Student < ActiveRecord::Base
	has_many :posts
	include BCrypt
  validates :email, presence: true, uniqueness: true
  validates :email, format: { with: /[a-zA-Z0-9]+@[a-zA-Z0-9]+\.[a-zA-Z0-9]+/, message: "valid email required" }
  validates :password, presence: true

  def password=(plaintext)
    if !plaintext.empty?
      self.password_hash = BCrypt::Password.create(plaintext)
    end
  end

  def password
    @password ||= BCrypt::Password.new(password_hash)
  end

  def self.authenticate(email, password)
    @student = self.find_by(email: email)
    return @student if @student and BCrypt::Password.new(@student.password_hash) == password
  end
end