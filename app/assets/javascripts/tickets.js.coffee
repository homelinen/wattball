# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

totalPrice = ->
  adultCount = $('#ticket_adults').val()
  adultPrice = $('#adult_price').text().substring(1)

  concessCount = $('#ticket_concessions').val()
  concessPrice = $('#concession_price').text().substring(1)

  total = (adultCount * adultPrice) + (concessCount * concessPrice)

  $('#total_price').text('£' + total.toFixed(2))

$(document).ready ->
  totalPrice()

  $('#ticket_adults').change(totalPrice)
  $('#ticket_concessions').change(totalPrice)

