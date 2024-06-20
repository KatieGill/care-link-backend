class Dislike < ApplicationRecord
    validates_uniqueness_of :disliked_user_id, scope: :user_id
end
