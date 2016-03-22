var app = function() {

    var init = function() {

        tooltips();
        toggleMenuLeft();
        toggleMenuRight();
        switcheryToggle();
        menu();
    };

    var tooltips = function() {
        $('#toggle-left').tooltip();
    };


    var toggleMenuLeft = function() {
        $('#toggle-left').bind('click', function(e) {
           $('body').removeClass('off-canvas-open')    
            var bodyEl = $('#container');
            ($(window).width() > 768) ? $(bodyEl).toggleClass('sidebar-mini'): $(bodyEl).toggleClass('sidebar-opened');
        });
    };

    var toggleMenuRight = function() {
         $('#toggle-right').click(function(){
             $('.off-canvas').toggleClass('off-canvas-open');
         });
    };

    var switcheryToggle = function() {
        var elems = Array.prototype.slice.call(document.querySelectorAll('.js-switch'));
        elems.forEach(function(html) {
            var switchery = new Switchery(html, { size: 'small' });
        });
    };

    var menu = function() {
        var subMenu = $('.sidebar .nav');
        $(subMenu).navgoco({
            caretHtml: false,
            accordion: true,
            slide: {
                  duration: 400,
                  easing: 'swing'
              }
          });

    };
    //End functions

    //Dashboard functions
    var timer = function() {
        $('.timer').countTo();
    };


    //Vector Maps 
    var map = function() {
        $('#map').vectorMap({
            map: 'world_mill_en',
            backgroundColor: 'transparent',
            regionStyle: {
                initial: {
                    fill: '#1ABC9C',
                },
                hover: {
                    "fill-opacity": 0.8
                }
            },
            markerStyle: {
                initial: {
                    r: 10
                },
                hover: {
                    r: 12,
                    stroke: 'rgba(255,255,255,0.8)',
                    "stroke-width": 3
                }
            },
            markers: [{
                latLng: [27.9881, 86.9253],
                name: '36 Employees',
                style: {
                    fill: '#E84C3D',
                    stroke: 'rgba(255,255,255,0.7)',
                    "stroke-width": 3
                }
            }, {
                latLng: [48.8582, 2.2945],
                name: '58 Employees',
                style: {
                    fill: '#E84C3D',
                    stroke: 'rgba(255,255,255,0.7)',
                    "stroke-width": 3
                }
            }, {
                latLng: [-40.6892, -74.0444],
                name: '109 Employees',
                style: {
                    fill: '#E84C3D',
                    stroke: 'rgba(255,255,255,0.7)',
                    "stroke-width": 3
                }
            }, {
                latLng: [34.05, -118.25],
                name: '85 Employees ',
                style: {
                    fill: '#E84C3D',
                    stroke: 'rgba(255,255,255,0.7)',
                    "stroke-width": 3
                }
            }]
        });

    };

    //Sliders
    var sliders = function() {
        $('.slider-span').slider()
    };


    //return functions
    return {
        init: init,
        timer: timer,
        map: map,
        sliders: sliders

    };
}();

//Load global functions
$(document).ready(function() {
    app.init();
});