/*
Template Name: Greeva - Responsive Bootstrap 4 Admin Dashboard
Author: CoderThemes
File: Main App js
*/


!function($) {
    'use strict';

    var App = function() {
        this.$body = $('body'),
        this.$window = $(window)
    };


    /**
     * Initlizes the menu - top and sidebar
    */
    App.prototype.initMenu = function() {
        var $this = this;

        // Sidebar toggle for mobile
        $('#sidebar-toggle').on('click', function (event) {
            event.preventDefault();
            $('#left-sidebar').toggleClass('show');
            $('#sidebar-overlay').toggleClass('show');
        });

        // Close sidebar when clicking overlay
        $('#sidebar-overlay').on('click', function (event) {
            $('#left-sidebar').removeClass('show');
            $('#sidebar-overlay').removeClass('show');
        });

        // Close sidebar on window resize if mobile
        $(window).on('resize', function() {
            if ($(window).width() > 991) {
                $('#left-sidebar').removeClass('show');
                $('#sidebar-overlay').removeClass('show');
            }
        });

        $('.navigation-menu>li').slice(-2).addClass('last-elements');

        $('.navigation-menu li.has-submenu a[href="#"]').on('click', function (e) {
            if ($(window).width() < 992) {
                e.preventDefault();
                $(this).parent('li').toggleClass('open').find('.submenu:first').toggleClass('open');
            }
        });

        // sidebar - scroll container
        $('.slimscroll-menu').slimscroll({
            height: 'auto',
            position: 'right',
            size: "8px",
            color: '#9ea5ab',
            wheelStep: 5
        });

        // right side-bar toggle
        $('.right-bar-toggle').on('click', function(e){
            $('body').toggleClass('right-bar-enabled');
        });

        $(document).on('click', 'body', function (e) {
            if($(e.target).closest('.right-bar-toggle, .right-bar').length > 0) {
                return;
            }
            $('body').removeClass('right-bar-enabled');
            return;
        });

        // activate the menu in left side bar based on url
        $(".navigation-menu a").each(function () {
            var pageUrl = window.location.href.split(/[?#]/)[0];
            if (this.href == pageUrl) {  
                $(this).addClass("active");
                $(this).parent().addClass("active"); // add active to li of the current link
                $(this).parent().parent().addClass("in");
                $(this).parent().parent().prev().addClass("active"); // add active class to an anchor
                $(this).parent().parent().parent().addClass("active");
                $(this).parent().parent().parent().parent().addClass("in"); // add active to li of the current link
                $(this).parent().parent().parent().parent().parent().addClass("active");
            }
        });
    },

    /** 
     * Init the layout - with broad sidebar or compact side bar
    */
    App.prototype.initLayout = function() {
        // in case of small size, add class enlarge to have minimal menu
        if (this.$window.width() < 1025) {
            this.$body.addClass('enlarged');
        } else {
            if (this.$body.data('keep-enlarged') != true)
                this.$body.removeClass('enlarged');
        }
    },

    //initilizing
    App.prototype.init = function() {
        var $this = this;
        this.initLayout();
        this.initMenu();
    },

    $.App = new App, $.App.Constructor = App


}(window.jQuery),
    //initializing main application module
function($) {
    "use strict";
    $.App.init();
}(window.jQuery);
