module MessagesHelper 

  def print_reply(message)
    str = "<div id='message_#{message.id}' class='show_for inner-container message'>
        <a class='left' href='#{user_path(message.sender)}'>
        <img src='#{message.sender.display_picture.url(:thumb)}' alt='80_black_and_white_hd_wallpapers_1920_x_1200__-35' class='pic'>
        </a>
        <div class='wrapper message_body left '>
            <span class='content'>#{message.body}
            </span>
        </div>"
    unless message.uploads.first.nil?
      str << "<div class='display-clear space-top-10 space-bottom-10 '>
            <a href='#{message.uploads.first.attachment.url }' class='image-viewer'>
              <img class='space-left-10 image-preview ' src='#{message.uploads.first.attachment.url }'>
            </a>
        </div>"
    end
    str << "<span class='right font-10 '>
            #{get_current_user_time( message.created_at )}
          </span>
    </div>"
    str
  end

  def get_replies_for(message)
    replies = message.sender.get_replies(message.id)
    reply_str = ""
    
    if replies.count > 0
      replies.each do |reply|
        reply_str =  "#{reply_str} #{print_reply(reply)}"
        reply_str = "#{reply_str} #{get_replies_for(reply)}"
        unread_message(reply)
      end
    end
    reply_str.html_safe
  end
  
  def unread_message( message )
    unless current_user == message.sender
      message.update_attribute(:read, true)
    end
  end
  def get_last_message( message )
    reply = message.sender.get_replies( message.id )
    m = message.id
    reply.each do |r|
      m = r.id
      until Message.find(:first, :conditions=>[" reply_of = ? ", m ]).nil?
        m = Message.find(:first, :conditions=>[" reply_of = ? ", m ]).id
      end
    end
    m
  end
  def get_current_user_time( t )
    t.in_time_zone( Time.zone ).strftime( "%B %d ,%y %H:%M %p" )
  end
  
  def get_class_name( name )
    if name.attachment_content_type ==/[jpeg]|[png]/
      img= 'image-viewer'
    else
      img = ''
    end
    img
  end
end
