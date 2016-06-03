class Role
  include Mongoid::Document
  has_many :users
  has_many :permissions
  field :name, :type => String
  field :description, :type => String


  scope :order_by_asc, -> { ascending(:name) }
  scope :order_by_desc, -> { descending(:name) }
end
