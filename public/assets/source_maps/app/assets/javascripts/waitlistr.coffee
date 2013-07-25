window.app =
  pusher: null
  channel: null
  added: []
  user: null
  ready: ->
    app.pusher = new Pusher("4792ff5d7ea3bfd86bc4")
    app.pusher.subscribe("jane_channel")
    app.bind_events()
    $("#add_myself").on("click", "#add-btn", app.add_to_list)
    $("#list").on("click", ".removable", app.remove_check)
    app.get_user()

  bind_events: ->
    #bind my events (to be triggered)
    app.channel = app.pusher.channels.channels["jane_channel"]
    #pass it the method that you want to accomplish when it is triggered
    app.channel.bind("add_to", app.add_to)
    app.channel.bind("remove_from", app.remove_from)
  add_to: (data) ->
    #append the user to the list
    li = $("<li>").text(data).addClass("removable").attr("data-username", data)
    console.log 'appending the thing...'
    $("#list").append(li)
    app.added.push(data)
    if li.data("username") == app.user
      app.add_hover({username:app.user})
  remove_from: (data) ->
    $("li[data-username=#{data}]").addClass("remove").fadeOut(500)
  add_to_list: (e) ->
    e.preventDefault()
    $("#add_myself").empty()
    settings =
      datatype: "json"
      type: "get"
      url: "/home/add"
    $.ajax(settings).done(console.log("user gotten"))
    app.get_user()
  remove_check: ->
    txt = $(this).text()
    settings =
      datatype: "json"
      type: "get"
      url: "/home/remove_check?username=#{txt}"
    $.ajax(settings).done(app.remove_from_list)
  remove_from_list: (data) ->
    if data.response == true
      settings =
        datatype: "json"
        type: "get"
        url: "/home/remove"
      $.ajax(settings)
      div = $("<div>")
      div.text("You Have Successfully Removed Yourself from the Waitlist").addClass("alert-box radius success")
      $("#alerts").prepend(div)
      # =link_to("Add Myself", "#", :class => "button radius success large", :id => "add-btn")
      div.fadeOut(4000)
      if $("#add-btn").length == 0
        a = $("<a>").attr("href", "#").text("Add Myself").addClass("button radius large").attr("id", "add-btn")
        $("#add_myself").append(a)
    else
      app.cannot_remove()
  cannot_remove: ->
    div = $("<div>")
    div.text("Sorry, you can't remove someone else from the list. Nice try though!").addClass("alert-box radius alert")
    $("#alerts").prepend(div)
    div.fadeOut(4000)
  get_user: ->
    console.log('getting the user');
    settings =
      datatype: "json"
      type: "get"
      url: "/home/get_user"
    $.ajax(settings).done(app.add_hover)
  add_hover: (data) ->
    console.log('about to add the hover');
    $("li[data-username=#{data.username}]").hover(-> $(this).toggleClass("hover"))
    user = data

$(document).ready(app.ready)

