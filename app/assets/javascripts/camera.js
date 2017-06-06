var localstream;
  var canvas   = document.getElementById("canvas");
  var context  = canvas.getContext("2d");
  var video    = document.getElementById("video");
  var videoObj = { "video": true };

  // for checking of camera and getting the stream.
  var loadChecking = function(){
    if(navigator.getUserMedia) {
      navigator.getUserMedia(videoObj, function(stream) {
        stream.getTracks()[0].stop();
      }, errBack);
    } else if(navigator.webkitGetUserMedia) {
      navigator.webkitGetUserMedia(videoObj, function(stream){
        stream.getTracks()[0].stop();
      }, errBack);
    }
    else if(navigator.mozGetUserMedia) {
      navigator.mozGetUserMedia(videoObj, function(stream){
        stream.getTracks()[0].stop();
      }, errBack);
    }
  };

  // error handling.
  var errBack  = function(error) {
    $('.camBtn').hide(); // in case camera does not exists. hide the button.
    console.log("Video capture error: ", error.code);
  };

  // initiate function to detect.
  loadChecking();



$('#camMod').on('show.bs.modal', function (e) {
  var button = $(e.relatedTarget);
  $("#snap").data('type', button.data('type'));
  // Put video listeners into place
  if(navigator.getUserMedia) { // Standard
    console.log("test")
    navigator.getUserMedia(videoObj, function(stream) {
      console.log(stream)
      var vendorURL = window.URL || window.webkitURL;
      video.src   = vendorURL.createObjectURL(stream);
      // localstream = stream;
      // video.play();
    }, errBack);
  } else if(navigator.webkitGetUserMedia) { // WebKit-prefixed
    navigator.webkitGetUserMedia(videoObj, function(stream){
      video.src   = window.webkitURL.createObjectURL(stream);
      // localstream = stream;
      // video.play();
    }, errBack);
  }
  else if(navigator.mozGetUserMedia) { // Firefox-prefixed
    navigator.mozGetUserMedia(videoObj, function(stream){
      video.src   = window.URL.createObjectURL(stream);
      // localstream = stream;
      // video.play();
    }, errBack);
  }
  console.log("camera on");
}).on('hide.bs.modal', function(e){
  video.pause();
  video.src = '';
  if(localstream)
    localstream.getTracks()[0].stop();
  console.log('camera off');
});

// Draw the image based on the streaming to a canvas.
$("#snap").click(function(){
  context.drawImage(video, 0, 0, 640, 480);

  // convert the content of the canvas to Data URI
  $datauri = $("#canvas")[0].toDataURL();

  // From here you can place it on your hidden field
 $("#avatar_datafile").val($datauri);

 // [Optional] I prefer to close the modal once this is done.
  $('#camMod').modal('toggle')
});
