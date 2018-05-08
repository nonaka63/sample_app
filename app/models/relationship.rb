class Relationship < ActiveRecord::Base
    belongs_to :follower_id , class_name: "user"
    belongs_to :followed_id , class_name: "user"
    validates :follower_id, presence: true
    validates :followed_id, presence: true
end
