class Department
  include Mongoid::Document
  field :name, :type => String
  field :description, :type => String

  validates :name, presence: true
  validates :description, presence: true


  scope :order_by_asc, -> { ascending(:name) }
  scope :order_by_desc, -> { descending(:name) }
end
