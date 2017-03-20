class Comment < ActiveRecord::Base
  belongs_to :ppost
  belongs_to :user
end
