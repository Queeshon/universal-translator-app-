``


createRecording = ->
  recorder and recorder.exportWAV(blob) ->
    data = new FormData();
    data.append("audio", blob);
    $.ajax
      url: '/messages/recorded'
      type: 'POST'
      data: data
      contentType: false
      processData: false
      success: ->
        if confirm "Successfully uploaded recording."
          window.location.href = 'Redirect path after successful ajax call.'
