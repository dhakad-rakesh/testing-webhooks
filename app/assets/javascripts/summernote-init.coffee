$ ->
  sendFile = (that, file) ->
    data = new FormData
    data.append 'image[image]', file
    $.ajax
      data: data
      type: 'POST'
      url: '/content_images'
      cache: false
      contentType: false
      processData: false
      beforeSend: () ->
        $('.ibox-content').toggleClass('sk-loading');
      success: (data) ->
        img = document.createElement('IMG')
        img.src = data.url
        img.setAttribute('id', data.image_id)
        $(that).summernote 'insertNode', img
        $('.ibox-content').toggleClass('sk-loading');
      
  deleteFile = (file_id) ->
    $.ajax
      type: 'DELETE'
      url: "/content_images/#{file_id}"
      cache: false
      contentType: false
      processData: false  

  ready = ->
    $('[data-provider="summernote"]').each ->
      $(this).summernote
        height: 300
        maximumImageFileSize: 1024000
        callbacks:
          onImageUpload: (files) ->
            if (files[0].size >= 1024000)
              toastr.error('Please upload image size less than 1MB')
            else
              img = sendFile(this, files[0])
          onMediaDelete: (target, editor, editable) ->
            image_id = target[0].id
            if !!image_id
              deleteFile image_id
            target.remove()

  $(document).ready(ready)
  $(document).on('page:load', ready)