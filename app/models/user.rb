class User < ActiveRecord::Base
    has_secure_password
    has_many :events
    has_many :attending
    has_many :events_attending, through: :attending, source: :event
    has_many :comments
    has_many :events_commented_on, through: :comments, source: :event
    EMAIL_REGEX = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]+)\z/i
    validates :first_name, :last_name, :email, :location, :state, presence: true
    validates :password, on:create, presence: true
    validates :password, on:create, length: { minimum: 8 }
    validates :email, uniqueness: { case_sensitive: false }, format: { with: EMAIL_REGEX }
end
