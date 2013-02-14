$(document).ready(function(){

    $('input#checked_all_member').live('click',function(event) {
        if(this.checked) {
            // Iterate each checkbox
            $('input.checked_id').each(function() {
                this.checked = true;
            });
        }
        else {
            $('input.checked_id').each(function() {
                this.checked = false;
            });
        }
    });

    $('input#checked_all').live('click',function(event) {
        if(this.checked) {
            // Iterate each checkbox
            $('input.checked_email').each(function() {
                this.checked = true;
            });
        }
        else {
            $('input.checked_email').each(function() {
                this.checked = false;
            });
        }
    });

  
});