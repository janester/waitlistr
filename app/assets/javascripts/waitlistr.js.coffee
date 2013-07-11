window.app =
  pusher: null
  channel: null
  added: []
  ready: ->
    app.pusher = new Pusher("4792ff5d7ea3bfd86bc4")
    app.pusher.subscribe("jane_channel")
    app.bind_events()
    $("#add_myself").on("click", "#add-btn", app.add_to_list)
  bind_events: ->
    channel = app.pusher.channels.channels["jane_channel"]
    channel.bind("add_to", app.add_to)
    channel.bind("remove_from", app.remove_from)
  add_to: (data) ->
    console.log(data)
    li = $("<li>").text(data)
    $("#list").append(li)
    app.added.push(data)
  add_to_list: ->
    settings =
      datatype: "json"
      type: "get"
      url: "/home/add"
    $.ajax(settings)

$(document).ready(app.ready)

# send_chat: ->
#   text = $("#chat_text").val()
#   $("#chat_text").val("")
#   token = $("input[name=authenticity_token]").val()
#   settings =
#     datatype: "json"
#     type: "post"
#     url: "/channels/send_chat"
#     data:
#       authenticity_token:token
#       chat_text:text
#       channel:app.name
#   $.ajax(settings)