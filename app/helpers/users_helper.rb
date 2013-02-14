module UsersHelper
  def check_user_id( value )
    if value.has_key?( :user_id )
      id = value[:user_id].to_i
    else
      id = value[:id].to_i
    end
    id
  end

end
