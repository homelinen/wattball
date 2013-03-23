$(document).ready(->
  
  if $('#map').length
    centerLong = 55.908887
    centerLat = -3.318558

    url = GMaps.staticMapURL({
      size: [610, 300],
      lat: centerLong,
      lng: centerLat,
      zoom: 13,
      markers: [
        {lat: centerLong, lng: centerLat}
      ]
    })

    $('<img/>').attr('src', url)
      .appendTo('#map')
)
