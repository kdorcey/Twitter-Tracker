//Add button after the list
$('#fieldList').after('<input type="button" id="addHandle" value="Add Twitter User">');


var twitter_handles_added = 1;

$(document).on('click', '#addHandle', function () {
  $('#fieldList').append('<li><label for="searches_extra_handle">Twitter Handle #' + twitter_handles_added + '</label><input type="text" name="searches[extra_handle]" id="searches_extra_handle"><input type = "image" src = "../images/x.png" class ="deleteHandle" alt ="button" width="25" height = "25" value = "Working" ></li>');
  twitter_handles_added++;
});


$(document).on('click', '.deleteHandle', function () {
  var removeLi = this.parentElement;
  var liParent = removeLi.parentElement;
  liParent.removeChild(removeLi);
});
