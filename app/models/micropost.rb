class Micropost < ActiveRecord::Base
    belongs_to :user
    default_scope -> { order('create_at DESD') }
    validates :user_idm, presence: true, length: { maximum: 140}
    validates :user_id, presence: true
end
