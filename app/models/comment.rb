class Comment < ActiveRecord::Base
  validates :user_id, :post_id, :content, null: false
  belongs_to :post
  belongs_to :user
  has_many :child_comments,
    primary_key: :id,
    foreign_key: :comment_id,
    class_name: :Comment

  belongs_to :parent_comment,
    primary_key: :id,
    foreign_key: :comment_id,
    class_name: :Comment
end
