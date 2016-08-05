# == Schema Information
#
# Table name: subs
#
#  id          :integer          not null, primary key
#  title       :string           not null
#  user_id     :integer          not null
#  description :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Sub < ActiveRecord::Base
  validates :title, :user_id, presence: true

  belongs_to :author,
    primary_key: :id,
    foreign_key: :user_id,
    class_name: :User

  has_many :post_subs, dependent: :destroy, inverse_of: :sub
  has_many :posts,
    through: :post_subs,
    source: :post
end
