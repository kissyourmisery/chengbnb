class User < ActiveRecord::Base
  include Clearance::User
  has_many :listings
  has_many :reservations

  has_many :authentications, :dependent => :destroy

  attr_accessor :profile_photo
  mount_uploader :profile_photo, AvatarUploader

  def self.create_with_auth_and_hash(authentication,auth_hash)
    create! do |u|
      u.email = auth_hash["extra"]["raw_info"]["email"]
      u.password = "PLACEHOLDER"
      u.authentications<<(authentication)
    end
  end

  def fb_token
    x = self.authentications.where(:provider => :facebook).first
    return x.token unless x.nil?
  end

  def password_optional?
    true
  end

end
