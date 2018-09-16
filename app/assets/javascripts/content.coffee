span_maker = (h3, index_at) ->
  span = "<span class=\"location-text\" id=\"location-text-" + index_at + "\"
    style=
      \"
      top:" + (50 * index_at + 168) + "px;
      \"
    >" + h3 + "</span>"
  return $(span)

make_svg = (tag, attributes) ->
  el = document.createElementNS('http://www.w3.org/2000/svg', tag)
  for k, v of attributes
    el.setAttribute(k, v)
  return el

circle_maker = (index_at) ->
  attributes = { class: "location-circle", cy: 50 * index_at, cx: 8, id: "c"+index_at }
  return make_svg("circle", attributes)

color_in_circles = (indexes, index_at) ->
  for i in [0..indexes]
    if i == index_at
      $("#c"+i).css("fill", "#3CA4BA")
    else
      $("#c"+i).css("fill", "#d8d8d8")

# $(document).on "turbolinks:load", ->
$(document).ready ->
  if !$("body").is(".case-study")
    return
  h3_elements = $("h3")
  h3_indexes = h3_elements.length-1
  h3_height = 50 * (h3_indexes)
  svg = $("#location-scroller > svg")
  svg.attr("height", h3_height+10)
  line = $("#location-scroller > svg > line")
  line.attr("y2", h3_height)
  for i in [0..h3_indexes]
    $("#location-scroller").append(span_maker(h3_elements[i].innerHTML, i))
    document.querySelector("#location-scroller > svg").append(circle_maker(i))
  color_in_circles(h3_indexes, 0)

  h3_positions = []
  for h3 in h3_elements
    h3_positions.push($(h3).offset().top)

  current_index = (positions, scroll_at) ->
    index = 0
    for position in positions
      if scroll_at < position
        if index > 0
          index -= 1
          break
      index += 1
    if scroll_at > positions[h3_indexes]
      index = h3_indexes
    return index

  last_position = 0
  window_height = $(window).height()
  $(window).on 'scroll', ->
    scroll_at = $(this).scrollTop()
    index = current_index(h3_positions, scroll_at+50)
    last_position = scroll_at
    if $(document).height() == scroll_at + window_height
      $("#location-marker").attr("cy", $("#c"+h3_indexes).attr("cy"))
      color_in_circles(h3_indexes, h3_indexes)
    else
      $("#location-marker").attr("cy", $("#c"+index).attr("cy"))
      color_in_circles(h3_indexes, index)

  $(".location-text").click ->
    id = $(this).attr("id")
    index = id.slice(id.indexOf("-",13)+1)
    destination = h3_positions[index] - 50
    $('body,html').animate({ scrollTop: destination+1 }, 800)
