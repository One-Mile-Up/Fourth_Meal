class Restaurant < ActiveRecord::Base
  has_many :items
  has_many :categories
  validates_uniqueness_of :name
  validates :status, inclusion: { in: %w(Pending Declined Approved Deactivated) }
  has_attached_file :image, styles: { small: "200x200" }, bucket: 'platable'
  has_many :roles
  has_many :users, through: :roles

  def self.active
    self.where(status: "Approved")
  end

  def declined?
    status ==  "Declined"
  end

  def approved?
    status == "Approved"
  end

  def not_approved?
    status != "Approved"
  end

end
