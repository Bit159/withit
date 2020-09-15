var header = $('#header_wrapper').offset().top;
var sidebar = $('.sidebar').offset().top;
$(window).scroll(function(){
    var window = $(this).scrollTop();
    if(header <= window) {
        $('#header_wrapper').addClass("fixed");
        $('.sidebar').addClass("fixed");
        
    } else {
        $('#header_wrapper').removeClass("fixed");
        $('.sidebar').removeClass("fixed");
    }
});