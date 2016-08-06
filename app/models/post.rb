# == Schema Information
#
# Table name: posts
#
#  id         :integer          not null, primary key
#  title      :string           not null
#  url        :string
#  content    :string
#  user_id    :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Post < ActiveRecord::Base
  validates :user_id, :subs, :title, presence: true
  after_initialize :linkify
  belongs_to :author,
    primary_key: :id,
    foreign_key: :user_id,
    class_name: :User

  has_many :post_subs, dependent: :destroy, inverse_of: :post
  has_many :subs,
    through: :post_subs,
    source: :sub
  has_many :comments

  def linkify
    unless self.url.include?("http://")
      self.url = "http://" + self.url
    end
  end


  def comments_by_parent_id
    final_hash = Hash.new {|k,v| k[v] = [] }
    self.comments.each do |comment|
      final_hash[comment.comment_id] << comment
    end
    final_hash
  end

end
