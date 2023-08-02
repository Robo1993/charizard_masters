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

    document.ontouchmove = function(event){
        event.preventDefault();
    }

    $("#bottom-bar-large .bottom-bar-item").on("click", function() {
        $(".bottom-bar-item").each(function() {
            $(this).css("background-color", "#fff");
        });
        $(this).css("background-color", "#ccc");
        $("#mobile-transparent-background").css("display", "block");
        let bottom_drawer = $(this).find("span").text();
        $(".bottom-bar-drawer").each(function() {
            $(this).animate({height:"0vh"}, 50);
        }).promise().done(function(){
            openBottomNav("#bottom-bar-drawer-" + bottom_drawer);
        });
        //openBottomNav("#bottom-bar-drawer-" + bottom_drawer);
    });

    $("#bottom-bar .bottom-bar-item").on("click", function() {
        $(".bottom-bar-item").each(function() {
            $(this).css("background-color", "#fff");
        });
        $(this).css("background-color", "#ccc");
    });

    $(".bottom-bar-drawer-close").on("click", function() {
        closeBottomNav();
    });

    $("#hamburger-anchor-top").on("click", function() {
        $(this).css("background-color", "#ccc");
        openHamNav("#hamburger-drawer-top");
        $("#mobile-transparent-background").css("display", "block");
        //$("#hamburger-drawer-top").addClass("drawer-left-animation");
    });

    $("#hamburger-anchor-bottom").on("click", function() {
        $(this).css("background-color", "#ccc");
        openHamNav("#hamburger-drawer-bottom");
        $("#mobile-transparent-background").css("display", "block");
        //$("#hamburger-drawer-top").addClass("drawer-left-animation");
    });

    $(".hamburger-close-button").on("click", function(){
        closeHamburger();
    });

    $("#mobile-transparent-background").on("click", function() {
        closeHamburger();
        closeBottomNav("");
    });
});

function closeHamburger() {
    closeHamNav("#hamburger-drawer-top");
    closeHamNav("#hamburger-drawer-bottom");
    $("#mobile-transparent-background").css("display", "none");
}

function openHamNav(e) {
  $(e).animate({width:"55%"}, 200);
}

function closeHamNav(e) {
  $(e).animate({width:"0%"}, 200);
}

function openBottomNav(e) {
  $(e).animate({height:(($(e).find(".bottom-bar-drawer-item").length + 1) * 4) + "rem"}, 200);
}

function closeBottomNav(e) {
  $(e).animate({height:"0vh"}, 200);
  $(".bottom-bar-drawer").each(function() {
    $(this).animate({height:"0vh"}, 200);
  })
}
