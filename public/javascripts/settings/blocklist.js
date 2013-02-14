// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
$(document).ready(function(e) {
    $('a#unblock').bind('click', function(e){
       $(this).parents('div.detail-content').parents('div.details').remove();
    });
});