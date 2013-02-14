/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

$(document).ready(function(){
    $('input:checkbox').change(function(){    
        $(this).parents('form').first().find('input:submit').trigger('click')
    });
});