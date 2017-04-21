class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  has_one :organization, :inverse_of => :user
  accepts_nested_attributes_for :organization

  def is_admin
    self.admin
  end
end
