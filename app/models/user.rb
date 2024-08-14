class User < ApplicationRecord
  has_many :tasks, dependent: :destroy
  # Devise modules
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum role: { user: 'user', admin: 'admin' }
  after_initialize :set_default_role, if: :new_record?

   def set_default_role
     self.role ||= :user
   end
end