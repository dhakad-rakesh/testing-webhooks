App.messages = App.cable.subscriptions.create('MatchUpdatesChannel', {  
  received: function(data) {
    console.log(data)
  }
});