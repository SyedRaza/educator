// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
//Created by: Tariq Habib Afridi
//Created Date: 04 May, 2011
//Purpose: add request confirm and block button functionality

$(document).ready(function() {
    $('.filter').change(function(){
        $.getScript('requests/?type='+$(this).val());
    });
});