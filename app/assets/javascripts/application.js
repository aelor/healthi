// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery.turbolinks
//= require jquery_ujs
//= require twitter/bootstrap
//= require turbolinks
//= require_tree .
//= require websocket_rails/main

$(document).on('ready', function() {
    var dispatcher = new WebSocketRails('192.168.36.135:3000/websocket');
    channel = dispatcher.subscribe('posts');
    channel.bind('new', function(post) {
        showflash('a new post about '+post.content+' arrived!');
        increasecounter(post.content, post.id);
    });
    channel.bind('new_login', function(user){
        showflash(user.email+' has logged in !');
    });
});

function showflash(str){
    $(".flasher").text(str);
    $(".flasher").fadeIn(function(){
        setTimeout(function() {
            $(".flasher").fadeOut();
        }, 3000);
    });
}

function increasecounter(str, id){
    $("#notif_background").css("background-color","#00aa00");
    var x = parseInt($("#num_notif").text());
    $("#num_notif").text(x+1);
    $.ajax({
        url: "/posts/update_not_seen",
        data: {"id": id},
        type: "POST",
        success: function(){
            console.log("updated");
        }
    })
}

//$(function(){
//   $(".notification-dd").click(function(){
//       var latest_num = parseInt($(".notification-dd #num_notif").text());
//       if (latest_num > 0){
//           $.ajax({
//               url: "/posts/get_recent_posts",
//               dataType: "html",
//               data: {"latest_num":latest_num},
//               type: "GET",
//               success: function(data){
//                   $("#notif_list_node").html(data);
//               }
//           })
//       }
//   });
//});

$(function(){
    $(".notification-dd").click(function(){
        var latest_num = parseInt($(".notification-dd #num_notif").text());
        if (latest_num > 0){
            $.ajax({
                url: "/posts/get_recent_posts",
                dataType: "html",
                data: {"latest_num":latest_num},
                type: "GET",
                success: function(data){
                    $("#notif_list_node").html(data);
                }
            })
        }
    });
});