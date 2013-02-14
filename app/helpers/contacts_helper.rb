module ContactsHelper

  def contact_groups(comp_id)
    groups = current_user.contacts.find_by_companion_id_and_user_id(comp_id,current_user.id).contact_types.map{ |f| f.title}
    return groups
  end
  def user_groups
    @groups = []
    ContactType.default_groups.each {|e| @groups << e}
    current_user.contact_types.each {|e| @groups << e}
    @groups = @groups - [nil]
    return @groups
  end

end