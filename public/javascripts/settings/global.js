// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
$(document).ready(function(e) {
    $('a.change').bind('click', function(e) {
        $(this).hide('blind',function(){
            if($(this).closest('div').siblings('div.setting-container-sub-title').length > 0){
                $(this).siblings('a.close').show().closest('div').siblings('div.setting-container-sub-title').hide('blind',function(){
                    $(this).siblings('div.setting-container-form').show('blind');
                });
            }else{
                $(this).siblings('a.close').show().closest('div').next('div').show('blind');
            }
            
            
        });
        e.preventDefault();
    });
    $('.submit-btn').live(
        'click',
        function(e){

            if($('#pass_change_new_password').val() == $('#pass_change_confirm_password').val()){
                $('.pass_change').submit();
            }else{
                set_error_message('#pass_change_new_password',
                    'Both Password do not match');
            }
        });
    $('a.close').bind('click', function(e) {
        $(this).hide().siblings('a.change').show().parents('div').first().siblings('div.setting-container-form').hide().siblings('div.setting-container-sub-title').show();
        e.preventDefault();
    });
    $('.btn-cancel').click(function(){
        $(this).parents('div.setting-container-form').siblings('div.setting-container-top').children('span.rt').children('a.close').trigger('click');
    });
    $('a#unblock').bind('click', function(e){
        $(this).parents('div.detail-content').parents('div.details').remove();
    });
    
});
function set_error_message( container, message ){
    position = $(container).position()
    $('.error-message').html( message )
    .css({
        'top':position.top+"px",
        'left':position.left+$(container).width()+10+"px"
    })
    .fadeIn()
    .delay(1500)
    .fadeOut();
}