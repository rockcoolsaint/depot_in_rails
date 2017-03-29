class User < ActiveRecord::Base
	require 'digest/sha2'

	attr_accessor :password
	#attr_reader :password

	validates :name, presence: true, uniqueness: true

	validates :password, presence: true, confirmation: true

	#validate :password_must_be_present

	before_save :encrypt_password
	after_destroy :ensure_an_admin_remains

	def self.authenticate(name, password)
		user = find_by_name(name)
		return user if user && user.authenticated?(password)
	end

	def authenticated?(password)
		self.hashed_password == encrypt(password)
	end

	def ensure_an_admin_remains
		if User.count.zero?
			raise "Can't delete last user"
		end
	end

	private

		def password_must_be_present
			errors.add(:password, "Missing password") unless hashed_password.present?
		end

		def encrypt_password
			self.salt = generate_salt if new_record?
			self.hashed_password = encrypt(password)
		end

		def encrypt(string)
			secure_hash("#{string}")
		end

		def generate_salt
			self.salt = self.object_id.to_s + rand.to_s
		end

		def secure_hash(string)
			Digest::SHA2.hexdigest(string)
		end
end
