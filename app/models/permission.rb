class Permission
  include Mongoid::Document
  belongs_to :role
  field :name, :type => String
  field :description, :type => String
  field :action, :type => String
  field :subject_class, :type => String
  field :block, :type => String

  validates :name, presence: true
  validates :description, presence: true
  validates :action, presence: true
  validates :subject_class, presence: true
  validates :block, presence: false

  scope :order_by_asc, -> { ascending(:name) }
  scope :order_by_desc, -> { descending(:name) }
end
