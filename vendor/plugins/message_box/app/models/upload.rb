class Upload < ActiveRecord::Base
  belongs_to :message
  has_attached_file :attachment, :style=>{ :small=>"75x75>", :medium=>"110x110>" }, :url => "/system/message_box/:attachment/:id/:basename.:extension",
    :path => ":rails_root/public/system/message_box/:attachment/:id/:basename.:extension", :default_style => :pagesize
end