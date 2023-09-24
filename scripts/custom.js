/******************
    User custom JS
    ---------------

   Put JS-functions for your template here.
   If possible use a closure, or add them to the general Template Object "Template"
*/
let questionCode;
let response_id;
let navigation_config;
let navigation_style;
let navigations_left = [];
let time_start;
let time_end;
let moves = 0;
let errors = 0;


$(document).on('ready pjax:scriptcomplete',function(){
    /**
     * Code included inside this will only run once the page Document Object Model (DOM) is ready for JavaScript code to execute
     * @see https://learn.jquery.com/using-jquery-core/document-ready/
     */
    // document.ontouchmove = function(event){
    //     event.preventDefault();
    // }
    // alert(window.navigator.appVersion);
    // alert("width=" + screen.width + " | " + "height=" + screen.height);
    $.when( setupMobileBody() ).done(function() {
       $("#white-space-safer").css("display", "none");
    });

    $(window).on('resize', function(event) {
        if(window.innerHeight < window.innerWidth) {
            $("#rotation-alert").css("display", "flex");
        }else {
            $("#rotation-alert").css("display", "none");
        }
    });

    $(".ueq-radio").on("click", function() {
        let axis = $(this).attr("name");
        let value = $(this).val();
        $('input[id*="' + axis + '"]').val(value);
    });

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
        if($(this).find("span").text() == "Objective") {
            showObjective();
        }
        //openBottomNav("#bottom-bar-drawer-" + bottom_drawer);
    });

    $(".hamburger-objective").on("click", function() {
        showObjective();
        $(".hamburger-title span").text("Objective");
    });

    $("#bottom-bar .bottom-bar-item").on("click", function() {
        $(".bottom-bar-item").each(function() {
            $(this).css("background-color", "#fff");
        });
        $(this).css("background-color", "#ccc");
        if($(this).find("span").text() == "Objective") {
            showObjective();
        }
    });

    $(".bottom-bar-drawer-close").on("click", function() {
        closeBottomNav();
    });

    $("#hamburger-anchor-top").on("click", function() {
        openHamNav("#hamburger-drawer-top");
        $("#mobile-transparent-background").css("display", "block");
        //$("#hamburger-drawer-top").addClass("drawer-left-animation");
    });

    $("#hamburger-anchor-bottom").on("click", function() {
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

    $(".navigation-point").on("click", function() {
        moves++;
        let category = $(this).find("span").text();
        let hide_objective = true;
        $(".bottom-bar-drawer").each(function() {
            $(this).css("height","0vh");
        });
        $(".hamburger-drawer").each(function() {
            $(this).css("width","0%");
        });
        hideContent($(this));
        if(category == "Alkali Metals") {
            $("#alkali-metals").css("display", "flex");
        }else if(category == "Alkaline-Earth Metals") {
            $("#alkaline-earth-metals").css("display", "flex");
        }else if(category == "Transition Metals") {
            $("#transition-metals").css("display", "flex");
        }else if(category == "Post-Transition Metals") {
            $("#post-transition-metals").css("display", "flex");
        }else if(category == "Metalloids") {
            $("#metalloids").css("display", "flex");
        }else if(category == "Nonmetals") {
            $("#nonmetals").css("display", "flex");
        }else if(category == "Halogens") {
            $("#halogens").css("display", "flex");
        }else if(category == "Noble Gases") {
            $("#noble-gases").css("display", "flex");
        }else if(category == "Lanthanoids") {
            $("#lanthanoids").css("display", "flex");
        }else if(category == "Actinoids") {
            $("#actinoids").css("display", "flex");
        }else if(category == "Fictional Metals") {
            $("#fictional-metals").css("display", "flex");
        }else if(category == "Fictional Nonmetals") {
            $("#fictional-nonmetals").css("display", "flex");
        }else {
            hide_objective = false;
        }
        if(hide_objective) {
            $("#objective").css("display", "none");
        }
        $(".hamburger-title span").text(category);
    });

    $(".buy-button").on("click", function() {
        if($(this).parent().parent().find(".element-name").text().trim() == $("#correct-element").text().trim()) {
            time_end = performance.now();
            let task_time = time_end - time_start;
            $('input[id*="taskTime"]').val(task_time);
            $('input[id*="moves"]').val(moves);
            $('input[id*="completed"]').val(1);
            $('input[id*="errors"]').val(errors);
            $("#ls-button-submit").click();
        }else {
            alert("wrong element, check your objective if you don't remember.");
            errors++;
        }
    });

    $(".custom-next-button").on("click", function() {
        let all_fields_filled = true;
        $('input[id*="answer"]').each(function() {
            if($(this).val() == "") {
                all_fields_filled = false;
            }
        });
        if(all_fields_filled) {
            $("#ls-button-submit").click();
        }else {
            alert("You seem to have missed some terms. Please fill in your answer in the missing row(s).");
        }
    });
});

function setupMobileBody() {
    
    if(window.innerHeight < window.innerWidth) {
        $("#rotation-alert").css("display", "flex");
    }else {
        $("#rotation-alert").css("display", "none");
    }

    response_id = parseInt($("#response-id").text());
    questionCode = $(".question-code").text().trim();
    navigation_config = $("#current-navigation-config").text().trim();
    navigation_style = $("#current-navigation-style").text().trim();

    if(questionCode.indexOf("Start") != -1) {
        localStorage.clear();
        $(".answer-container").css("display","none");
        $("#mobile-body").css("display","none");
        navigationConfig();
    }else if(questionCode.indexOf("X") != -1) {
        time_start = performance.now();
        $("#mobile-body").css("display","flex");
        $("#main-row").css("display", "none");
    }

    if(questionCode.indexOf("UEQSusability") != -1) {
        $("#ueq-s-use").css("display","flex");
    }else if(questionCode.indexOf("UEQShedonism") != -1) {
        $("#ueq-s-hedon").css("display","flex");
    }
    
    checkForNavigationStyle();
    navigationEnabler();
    objectiveDetector();
}

function navigationConfig() {
    if(response_id % 2 == 0) {
        $('input[id*="naviConfig"]').val("big");
    }else {
        $('input[id*="naviConfig"]').val("small");
    }
}

function checkForNavigationStyle() {
    if(questionCode.indexOf("Intro") != -1) {
        $(".answer-container").css("display", "none");
        $("#mobile-body").css("display","none");
        navigations_left = localStorage.getItem("charizard_navigations");

        if(navigations_left == null) {
            navigations_left = ["bottomBar", "hamTop", "hamBot"];
            localStorage.setItem("charizard_navigations", JSON.stringify(navigations_left));

        }else {
            navigations_left = JSON.parse(localStorage.getItem("charizard_navigations"));
        }
        let random_index = Math.floor(Math.random() * navigations_left.length);
        let current_navigation = navigations_left[random_index];
        $('input[id*="navigation"]').val(current_navigation);
        navigations_left.splice(random_index, 1);
        localStorage.setItem("charizard_navigations", JSON.stringify(navigations_left));
    }
}

function showObjective() {
    $("#objective").css("display", "flex");
    $(".bottom-bar-drawer").each(function() {
        $(this).animate({height:"0vh"}, 200);
    });
    $(".content-list").each(function() {
        $(this).css("display", "none");
    });
    $("#mobile-transparent-background").css("display", "none");
}

function hideContent(e) {
    if(e.parent().attr("id") != "bottom-bar-large") {
        $("#mobile-transparent-background").css("display", "none");
        $(".bottom-bar-item").each(function() {
            $(this).css("background-color", "#fff");
        });
        $(".content-list").each(function() {
            $(this).css("display", "none");
        });
    }
    if(e.parent().attr("id") == "bottom-bar") {
        e.css("background-color", "#ccc");
    }
}

function closeHamburger() {
    closeHamNav("#hamburger-drawer-top");
    closeHamNav("#hamburger-drawer-bottom");
    $("#mobile-transparent-background").css("display", "none");
}

function openHamNav(e) {
  $(e).animate({width:"60%"}, 200);
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
    $(".bottom-bar-item").each(function() {
        $(this).css("background-color", "#fff");
    });
}

function navigationEnabler() {
    let bar = false;
    if(navigation_style == "hamTop") {
        $("#mobile-header").css("display", "block");
        $("#hamburger-top").css("display", "flex");
    }else if(navigation_style == "hamBot") {
        $("#mobile-footer").css("display", "block");
        $("#hamburger-bottom").css("display", "flex");
    }else if(navigation_style == "bottomBar") {
        $("#mobile-footer").css("display", "block");
        $("#mobile-footer").css("z-index", "1000");
        bar = true;
    }
    //define the content of the menu
    // if(questionCode.indexOf("Big") != -1) {
    //     if(bar_or_ham == 0) {
    //         $(".hamburger-list-large").css("display", "flex");
    //     }else {
    //         $("#bottom-bar-large").css("display", "flex");
    //     }
    // }else if(questionCode.indexOf("Small") != -1) {
    //     if(bar_or_ham == 0) {
    //         $(".hamburger-list-small").css("display", "flex");
    //     }else {
    //         $("#bottom-bar").css("display", "flex");
    //     }
    // }
    if(navigation_config == "big") {
        if(!bar) {
            $(".hamburger-list-large").css("display", "flex");
        }else {
            $("#bottom-bar-large").css("display", "flex");
        }
    }else if(navigation_config == "small") {
        if(!bar) {
            $(".hamburger-list-small").css("display", "flex");
        }else {
            $("#bottom-bar").css("display", "flex");
        }
    }
}

function objectiveDetector() {
    let text = $("#objective-text-original").text();
    $("#objective").find("span").text(text);
    $("#objective").prepend("<span class='granny'>👵</span>");
}