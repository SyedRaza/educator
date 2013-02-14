require 'message_box/instance_methods'

module Nazar
  module MessageBox
    # Class methods for the active record
    module ClassMethods
      def message_box
        include Nazar::MessageBox::InstanceMethods
      end
    end
  end
end