# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

totalPrice = ->
  adultCount = $('#ticket_adults').val()
  concessCount = $('#ticket_concessions').val()

  if adultCount < 0
    $('#ticket_adults').val(0)
    adultCount = 0

  if concessCount < 0
    $('#ticket_concessions').val(0)
    concessCount = 0

  adultPrice = $('#adult_price').text().substring(1)
  concessPrice = $('#concession_price').text().substring(1)

  total = (adultCount * adultPrice) + (concessCount * concessPrice)

  $('#total_price').text('£' + total.toFixed(2))

$(document).ready ->
  totalPrice()

  $('#ticket_adults').change(totalPrice)
  $('#ticket_concessions').change(totalPrice)

