/******************
    User custom JS
    ---------------

   Put JS-functions for your template here.
   If possible use a closure, or add them to the general Template Object "Template"
*/


$(document).on('ready pjax:scriptcomplete',function(){
    /**
     * Code included inside this will only run once the page Document Object Model (DOM) is ready for JavaScript code to execute
     * @see https://learn.jquery.com/using-jquery-core/document-ready/
     */

    $(".bottom-bar-item").on("click", function() {
        $(".bottom-bar-item").each(function() {
            $(this).css("background-color", "#fff");
        });
        $(this).css("background-color", "#ccc");
    });

    $("#hamburger-anchor-top").on("click", function() {
        $(this).css("background-color", "#ccc");
        openNav("#hamburger-drawer-top");
        $("#mobile-transparent-background").css("display", "block");
        //$("#hamburger-drawer-top").addClass("drawer-left-animation");
    });

    $("#hamburger-anchor-bottom").on("click", function() {
        $(this).css("background-color", "#ccc");
        openNav("#hamburger-drawer-bottom");
        $("#mobile-transparent-background").css("display", "block");
        //$("#hamburger-drawer-top").addClass("drawer-left-animation");
    });

    $(".hamburger-close-button").on("click", function(){
        closeHamburger();
    });

    $("#mobile-transparent-background").on("click", function() {
        closeHamburger();
    });
});

function closeHamburger() {
    closeNav("#hamburger-drawer-top");
    closeNav("#hamburger-drawer-bottom");
    $("#mobile-transparent-background").css("display", "none");
}

function openNav(e) {
  $(e).animate({width:"45%"}, 200);
}

function closeNav(e) {
  $(e).animate({width:"0%"}, 200);
}
