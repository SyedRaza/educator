$(document).ready(function(){
    $('.drop-down').change(function(){
        value = $(this).val();
        checkbox_list = $('.check-box');
        show_for = $('.show_for')
        if( value =='All'){
            clear_checkbox();
            checkbox_list.attr('checked','checked');
        }else if( value == 'Unread'){
            clear_checkbox();
            show_for.each(function(){
                if($(this).hasClass('unread')){
                    $(this).find('.check-box').attr("checked","checked");
                }
            });
        }else if( value == 'Read'){
            clear_checkbox();
            show_for.each(function(){
                if(!$(this).hasClass('unread')){
                    $(this).find('.check-box').attr("checked","checked");
                }
            });
        }
      
    });
    $('.check-box').live('click', function(e){
        //  e.preventDefault();
        //  $(this).attr("checked", "checked");

    });
    $(".message-link").each(function(){
        $(this).html($(this).next('.message-wrapper'));

    });
    function clear_checkbox(){
        $('.check-box').removeAttr('checked');
    }
    $('.delete').live('click', function(){
        $('.message_delete').submit();
    });
    $('#new-message-button').live('click',function(e){
        $.getScript('messages/new');
    });
});