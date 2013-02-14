/*
 * File Created BY Syed Raza Khalid
 * Created Date:
 * Modified By: Tariq Afridi
 * Modified Date: 3 May, 2011
 */
// // Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

$(document).ready(function() {

    jQuery.ajaxSetup({
        complete: function(){
            update_live_events();
        }
    });

    $('body').ajaxStart(function() {
        $('#loader').show();
    });
    $('body').ajaxStop(function() {
        $('#loader').hide();
    });

    $('a.pop-up').live('click',function(e){
        var tmp=$(this).attr('href');
        window.open(tmp,"_blank",'width=600,height=500,menubar=no,toolbar=no,scrollbars=yes');

        e.preventDefault();
    });

    $('a.action.single-field-cancel').live('click', function(){
        $(this).parents('form:first').siblings('.div-action,.single-field').show().end().remove()
    });
    function set_options_css(){
        $('.action-options').css( 'right','370px');

    }
    set_options_css();
    $('a.cancel').bind('click', function(e) {
        
        if ($(this).siblings('.edit').length > 0 )
            $(this).hide().siblings('.edit').show()
        if ($(this).siblings('.new').length > 0)
            $(this).hide().siblings('.new').show()
        if ($(this).siblings('.delete').length > 0 )
            $(this).hide().siblings('.delete').show()
        
        $(this)
        .parents('div.profile-heading')
        .siblings('div.info-details')
        .find('form')
        .siblings('div.show_for').show('blind')
        .end().remove();


        $(this)
        .parents('div.accordion')
        .first()
        .find('.form-container')
        .hide('blind').end().find('div.tabs a').removeClass('active')
        e.preventDefault();
    });

  
    $('.options>dt>a').live('click', function(e){
        $(this).parents('dt').siblings('dd').show();
        e.preventDefault();
    })
    $('.action-options').mouseleave(function(){
        $(this).find('li ul').hide();
    });
  

    $('a[href="#"]').live('click',function(e){
        e.preventDefault();
    });
    $('#new-message').bind('click', function(e){

        $.getScript( $(this).attr('href'),function(e){});
        e.preventDefault();
    });

    $('#add-archive').bind('click', function(e){
        $.getScript('/users/1/archives/new',function(e){
            });
    });

    $('#add-contact').bind('click', function(e){

        $.getScript($(this).attr('href'));
        e.preventDefault();
    });

    $('a.menu').click(function(){      
        $('dl.options>dd').show();
    });
    $('dl.options').mouseleave(function(){
        $('dl.options>dd').hide();
    });
    
    $('input[type="button"].action.cancel').live('click',function(e){
        $(this).parents('div.info-details:first').siblings('div.profile-heading')
        .find('a.action.cancel').trigger('click')
    });

    $('#submit-message-button,#cancel-button').live('click', function(e){
        $('div#new-pop-container').hide();
    });

    //$('.tabs a:first').trigger('click').addClass('active');
    
    $('.add-option').live('click', function(e){
        data = $('.options-field:last').parent().html();
        $(this).parent().after("<div class='field-box space-bottom-10'>"+data+"</div>");
        $(this).remove();
        count = $('.options-field').length;
        $('.options-field:last').prev().html('Option # '+count);
    });

    $('a.action').live('click', function(e){
        $('a.action').removeClass('active');
        $(this).addClass('active');
    });
    

    $('a.hide-comments.action').map(function(){
        $.getScript($(this).attr('href'),function(e){
            });
    });
    $('a.add-attachment').live('click',function(e){
        $('.attachment:hidden:first').removeClass('display-none')
        .hide().show('blind', function(){
            $(this).next('a').removeClass('display-none').hide().show();
        })
        check_hidden_fields();
        e.preventDefault();
    });
    $('.clear-field').live('click', function(e){
        $(this).prev('div').find('input[type="file"]').val('');
        $(this).hide();
        $(this).prev('div').hide();
        check_hidden_fields();
    });
    $('div.accordion > div.tabs').live('click',function(e){
        $(this).parents('div.accordion').first().siblings('div.accordion')
        .find('.form-container:visible')
        .hide('blind',function(){
            $(this).siblings('div')
            .find('a.active')
            .removeClass('active')
        })
        .end()
        .end()
        .find('.form-container')
        .show('blind',function(){
            $.getScript($(this).siblings('div')
                .find('a')
                .addClass('active')
                .attr('href'))

        })

    });
    $('div#new-pop-container').draggable();
    $('div.friends-profile-details').draggable();
    $('.main-nav').hover(function(e){
        position = $(this).position();
        $(this).children('ul').css('left',position.left).removeClass('display-none').show();
    }, function(e){
        $(this).children('ul').addClass('display-none').show();
    });
});
function check_hidden_fields(){
    if($('.attachment:hidden').length==0){
        $('a.add-attachment').parent('div').hide();
    }else{
        $('a.add-attachment').parent('div').show();
    }
}
function start_expander(){
    $('.more').expander({
        slicePoint: 80,
        widow: 4,
        expandEffect: 'show',
        userCollapseText: '[less]'
    });
}
start_expander();
function update_live_events(){
    start_expander();
    $('input.date-options').datepicker({
        changeMonth: true,
        changeYear: true,
        showButtonPanel: true,
        dateFormat: 'MM yy',

        onClose: function(dateText, inst) {
            var month = $("#ui-datepicker-div .ui-datepicker-month :selected").val();
            var year = $("#ui-datepicker-div .ui-datepicker-year :selected").val();
            $(this).datepicker('setDate', new Date(year, month, 1));
        },
        onSelect: function(dateText, inst) {
            alert('test')
        }
        
    });

    $('input.date-picker').datepicker({
        changeMonth: true,
        changeYear: true,
        yearRange: '1900:1999'
    });
    $('a.action.single-field-cancel').live('click', function(){
        $(this)
        .parents('form:first')
        .siblings('.div-action,.single-field').show()
        .end().remove()
    }); 
}