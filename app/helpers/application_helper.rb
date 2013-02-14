module ApplicationHelper
  def count_requests
    Request.count(:all, :conditions=>["request_id =  ? and (confirm = ? and block = ?)", current_user.id, false, false])
    
  end
  def count_outgoing_requests
    Request.count(:all, :conditions=>["user_id =  ?  and (confirm = ? and block = ?)", current_user.id, false, false])
  end


  def filter_user(list,type)
    user_id_list = []
    list.each do |l|
      i = 0
      tag_id_list = ActsAsTaggableOn::Tag.search({:name_eq=>l}).all.map{
        |m| m.id
      }
      #    education_id_list = ActsAsTaggableOn::Tagging.search({:tag_id_in=>tag_id_list,:taggable_type_eq =>'EducationHistory',:context_eq=>type}).all.map{ |m| m.taggable_id}
      #    user_id_list1 = EmploymentHistory.search({:id_in=>education_id_list}).all.map{ |m| m.user_id}
      employment_id_list = ActsAsTaggableOn::Tagging.search({:tag_id_in=>tag_id_list,:taggable_type_eq =>'EmploymentHistory',:context_eq=>type}).all.map{ |m| m.taggable_id}
      user_id_list2 = EmploymentHistory.search({:id_in=>employment_id_list}).all.map{ |m| m.user_id}
      #  user_id_list = Employer.search({:id_in=>employer_id_list}).all.map{ |m| m.user_id }

      user_id_list[i+1] = user_id_list2.uniq
    end
    #  user_id_list &=user_id_list
    user_id_list = user_id_list - [nil]
    return user_id_list
  end

  def get_user_pic( id )
    User.find_by_id( id )
  end
  def count_unread_messages
    if current_user.has_new_messages?
      "(#{ current_user.new_messages.count }) "
    end
  end
  def messages_partial
    current_user.inbox( :order=> 'messages.read ASC', :limit=>3 )
  end
  def requests_partial
    Request.find_all_by_request_id_and_block_and_confirm( current_user.id, false,
      false, :limit=>3, :order=>'created_at DESC' )
  end
  def count_requests
  cnt =  Request.count( :all,
      :conditions=>["request_id = ? and block = ? and confirm = ?",
        current_user.id, false, false] )
    cnt==0? '': "(#{ cnt })"
  end
  
end