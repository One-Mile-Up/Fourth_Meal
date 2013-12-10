class Restaurant < ActiveRecord::Base
  has_many :items
  has_many :categories
  validates_uniqueness_of :name
  validates :status, inclusion: { in: %w(Pending Declined Approved Deactivated) }
  has_many :roles
  has_many :users, through: :roles

  def declined?
    status ==  "Declined"
  end

end
