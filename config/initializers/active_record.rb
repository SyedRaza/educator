module ActiveRecordExtention
  def self.included(base)
    base.extend(ClassMethods) 
  end

  def age
    if self.respond_to? :created_at
      d = (Date.today - self.created_at.time.to_date).to_i
      if d == 0
        'today'
      elsif d < 7
        "#{d}d"
      else
        "#{(d/7).round}w"
      end
    end
  end

  module ClassMethods
  end
end

ActiveRecord::Base.send(:include, ActiveRecordExtention)