# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on "ajax:success", "form#coments-form", (ev,data)->
	console.log data
	$(this).find("textarea").val("")
	$("#coments-box").append("<li>#{data.body} - #{data.user.email}</li>")
