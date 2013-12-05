class Restaurant < ActiveRecord::Base

  validates_uniqueness_of :name

  def name_to_slug(new_name)
    new_name.delete("'").gsub(" ", "-").downcase
  end

  def name=(new_name)
    super
    self.slug = name_to_slug(new_name)
  end

end
