class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable

  devise :database_authenticatable, :registerable,
           :recoverable, :rememberable, :trackable, :validatable, :confirmable
  enum role: [:standard, :premium, :admin]

  # after_initialize do
  #   self.role ||= "standard"
  # end
  # #

  has_many :wikis
  has_many :collaborators



  def self.not_already_collaborators(wiki)
    User.all - wiki.collaborating_users
  end
end
