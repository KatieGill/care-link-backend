class Like < ApplicationRecord
    validates_uniqueness_of :liked_user_id, scope: :user_id
end
