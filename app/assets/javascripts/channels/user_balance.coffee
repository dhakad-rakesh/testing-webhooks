App.user_balance = App.cable.subscriptions.create "UserBalanceChannel",
  connected: ->
    console.log("ActionCable UserBalance connected!");
    # Called when the subscription is ready for use on the server

  disconnected: ->
    console.log("ActionCable UserBalance disconnected!");
    # Called when the subscription has been terminated by the server

  received: (data) ->
    console.log("ActionCable UserBalance received!, data: " + data);
    # Called when there's incoming data on the websocket for this channel

  # speak: (message) ->
  #  console.log("ActionCable UserBalance speak!");
  #  @perform 'speak', message: message

