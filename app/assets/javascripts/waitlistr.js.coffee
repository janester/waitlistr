window.app =
  pusher: null
  channel: null
  added: []
  ready: ->
    app.pusher = new Pusher("4792ff5d7ea3bfd86bc4")
    app.pusher.subscribe("jane_channel")
    app.bind_events()
    $("#add_myself").on("click", "#add-btn", app.add_to_list)
    $("#list").on("click", ".removable", app.remove_check)
  bind_events: ->
    app.channel = app.pusher.channels.channels["jane_channel"]
    app.channel.bind("add_to", app.add_to)
    app.channel.bind("remove_from", app.remove_from)
  add_to: (data) ->
    console.log(data)
    li = $("<li>").text(data).addClass("removable").attr("data-username", data)
    $("#list").append(li)
    app.added.push(data)
  remove_from: (data) ->
    console.log(data)
    $("li[data-username=#{data}]").remove()
    div = $("<div>")
    div.text("You Have Successfully Removed Yourself from the Waitlist").addClass("alert-box radius success")
    $(".the-list").prepend(div)
    # =link_to("Add Myself", "#", :class => "button radius success large", :id => "add-btn")
    a = $("<a>").attr("href", "#").text("Add Myself").addClass("button radius success large").attr("id", "add-btn")
    $("#add_myself").append(a)
    div.fadeOut(4000)
  add_to_list: (e) ->
    e.preventDefault()
    $("#add_myself").empty()
    settings =
      datatype: "json"
      type: "get"
      url: "/home/add"
    $.ajax(settings)
  remove_check: ->
    txt = $(this).text()
    settings =
      datatype: "json"
      type: "get"
      url: "/home/remove_check?username=#{txt}"
    $.ajax(settings).done(app.remove_from_list)
  remove_from_list: (data) ->
    console.log(data)
    if data.response == true
      settings =
        datatype: "json"
        type: "get"
        url: "/home/remove"
      $.ajax(settings)
    else
      app.cannot_remove()
  cannot_remove: ->
    div = $("<div>")
    div.text("Sorry, you can't remove someone else from the list. Nice try though!").addClass("alert-box radius alert")
    $(".the_list").prepend(div).fadeOut(4000)
    div.remove()


$(document).ready(app.ready)

