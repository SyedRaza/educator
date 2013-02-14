$(document).ready( function(){
    function check_box_selected(object, flag){
        if(flag)
        {
            $(object).removeClass('selected')
            $("input[type='checkbox']")
            $(object).find("input[type='checkbox']").removeAttr('checked')
        }
        else
        {
            $(object).addClass('selected')
            $(object).find("input[type='checkbox']").attr('checked','checked')
        }
    }
    $('.cell,.check-box-cell').live("click",function(e){
        ($(this).hasClass('selected'))? check_box_selected(this,true): check_box_selected(this,false)        
    })
    
    $('div.cancel-friend-details').live('click',function(e){
        $('ul.ui-corner-all').hide();
        $(this).parents('div.friends-profile-details').hide();
    });
    $('#select_group_type_id').bind('change',function(){
       $('input#grouptype_group_type_id').val($(this).val())
       $('form.grouptype').first().find('input[type="submit"]').trigger('click');
    });
    $('.group-edit-form-cancel').live('click',function(){
       $(this).parents('div#new-pop-container').hide()
    });
    
});