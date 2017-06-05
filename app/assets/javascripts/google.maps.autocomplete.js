

$(document).ready(function() {
  var address = $('.address-autocomplete').get(0);

  if (address) {
    var autocomplete = new google.maps.places.Autocomplete(address, { types: ['geocode'] });
    google.maps.event.addDomListener(address, 'keydown', function(e) {
      if (e.keyCode == 13) {
        e.preventDefault(); // Do not submit the form on Enter.
      }
    });
  }
});
