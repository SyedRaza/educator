# Include hook code here
require 'message_box'
require 'generators/message_box/message_box_generator'

ActiveRecord::Base.send :include, Nazar::MessageBox
