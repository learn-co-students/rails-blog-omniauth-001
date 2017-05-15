class User < ActiveRecord::Base
  has_many :posts
  has_many :comments

  def self.create_with_omniauth(auth)
    User.create(name: auth[:info][:name], uid: auth[:uid], provider: auth[:provider])
  end

end
