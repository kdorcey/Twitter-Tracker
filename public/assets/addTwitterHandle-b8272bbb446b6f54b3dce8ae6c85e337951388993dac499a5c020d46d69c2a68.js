  //Add button after the list

  var addTwitterHandle = function() {
    $('#fieldList').after('<input type="button" id="addHandle" value="Add Twitter User">');


    var twitter_handles_added = 1;

    $(document).on('click', '#addHandle', function () {
      $('#fieldList').append('<li><label for="searches_extra_handle'+ twitter_handles_added +'">Twitter Handle #' + twitter_handles_added + '</label><input type="text" name="searches[extra_handle' + twitter_handles_added + ']" id="searches_extra_handle' + twitter_handles_added + '"><input type = "image" src = "/assets/x-4c544a86a5a23d72c0987d2031fbdd8cd4101a494ca5f47859a20b0be219204e.png" class ="deleteHandle" alt ="button" width="25" height = "25" value = "Working" ></li>');
      twitter_handles_added++;
    });


    $(document).on('click', '.deleteHandle', function () {
      var removeLi = this.parentElement;
      var liParent = removeLi.parentElement;
      liParent.removeChild(removeLi);
    });
  };

$(document).ready(addTwitterHandle);
