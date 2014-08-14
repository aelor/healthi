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
//= require jquery_ujs
//= require twitter/bootstrap
//= require turbolinks
//= require_tree .
//= require websocket_rails/main

$(document).on('ready', function() {
    var dispatcher = new WebSocketRails('192.168.36.135:3000/websocket');
    channel = dispatcher.subscribe('posts');
    channel.bind('new', function(post) {
        alert('a new post about '+post.content+' arrived!');
    });
    channel.bind('new_login', function(user){
       alert(user.email+' has logged in !');
    });
});