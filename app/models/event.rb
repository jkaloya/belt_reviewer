class Event < ActiveRecord::Base
    belongs_to :user
    has_many :attending
    has_many :users_attending, through: :attending, source: :user
    has_many :comments
    has_many :comments_by_user, through: :comments, source: :user
    validates :name, :date, :location, :state, presence: true
end
