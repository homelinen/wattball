class Carousel < ActiveRecord::Base
  attr_accessible :description, :title, :banner_image

  has_attached_file :banner_image, :styles => { :large => "1300x320", :medium => "300x300" }

  validates_presence_of :title

  validates_attachment_presence :banner_image
end
