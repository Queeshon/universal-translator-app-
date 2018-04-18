App.messages = App.cable.subscriptions.create('ConversationsChannel', {
  received: function(data) {
    $("#content").removeClass('hidden')
    return $('#messages').append(this.renderMessage(data));
  },

  renderMessage: function(data) {
    return "<p> <b>" + data.sender + ": </b>" + data.message + "</p>";
  }
});
