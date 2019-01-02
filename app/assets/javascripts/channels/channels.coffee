# Application CSS
$(document).ready ->
  App.personal_chat = App.cable.subscriptions.create {
    channel: "AppearancesChannel"
  },
  connected: ->
  disconnected: ->
  received: (data) ->
    user = $(".user-#{data['user_id']}")
    user.toggleClass 'online', data['online']

# GROUP CHAT

$(document).ready ->
  group_messages = $('#group_messages')
  if $('#group_messages').length > 0
    messages_to_bottom = -> group_messages.scrollTop(group_messages.prop("scrollHeight"))
    messages_to_bottom()

    App.group_chat = App.cable.subscriptions.create {
        channel: "GroupChatsChannel"
        group_id: group_messages.data('group-id')
      },
      connected: ->
        # Called when the subscription is ready for use on the server

      disconnected: ->
        # Called when the subscription has been terminated by the server

      received: (data) ->
        group_messages.append data['message']
        messages_to_bottom()

      send_message: (message, group_id) ->
        @perform 'send_message', message: message, group_id: group_id

    $('#new_group_message').submit (e) ->
      $this = $(this)
      textarea = $this.find('#group_message_body')
      if $.trim(textarea.val()).length >= 1
        App.group_chat.send_message textarea.val(), group_messages.data('group-id')
        textarea.val('')
      e.preventDefault()
      return false
    $('#new_group_message').keypress (e) ->
       if e && e.keyCode == 13
         e.preventDefault()
         $(this).submit()
# ROOMS

$(document).ready ->
  messages = $('#messages')
  if $('#messages').length > 0
    messages_to_bottom = -> messages.scrollTop(messages.prop("scrollHeight"))
    messages_to_bottom()

    App.global_chat = App.cable.subscriptions.create {
        channel: "ChatRoomsChannel"
        chat_room_id: messages.data('chat-room-id')
      },
      connected: ->
        # Called when the subscription is ready for use on the server

      disconnected: ->
        # Called when the subscription has been terminated by the server

      received: (data) ->
        messages.append data['message']
        messages_to_bottom()

      send_message: (message, chat_room_id) ->
        @perform 'send_message', message: message, chat_room_id: chat_room_id


    $('#new_message').submit (e) ->
      $this = $(this)
      textarea = $this.find('#message_body')
      if $.trim(textarea.val()).length >= 1
        App.global_chat.send_message textarea.val(), messages.data('chat-room-id')
        textarea.val('')
      e.preventDefault()
      return false
   $('#message_body').keypress (e) ->
      if e && e.keyCode == 13
        e.preventDefault()
        $(this).submit()

# APPEARANCE

$(document).ready ->
  App.personal_chat = App.cable.subscriptions.create {
    channel: "AppearancesChannel"
  },
  connected: ->
  disconnected: ->
  received: (data) ->
    user = $(".user-#{data['user_id']}")
    user.toggleClass 'online', data['online']