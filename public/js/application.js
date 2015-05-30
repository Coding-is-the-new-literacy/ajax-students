function createNewPostForm() {
  var newPostHTML = "<div id='newPost'><form id='addForm' action='/posts' method='post'>";
  newPostHTML += "<p>Title: <input name='title' type='text'/></p>";
  newPostHTML += "<p>Content: <input name='content' type='text'/></p>";
  newPostHTML += "<p><input name='create!' type='submit'/></p></div>";
  return newPostHTML;
}

$(document).ready(function() {

  $('a[href$="posts/new"]').on("click", function(e) {
    e.preventDefault();
    // console.log('hello');
    // debugger
    var html = createNewPostForm();
    console.log(html)
    $("#newPost").remove();
    $("body").append(html);
    $('#addForm').on('submit', function(e){
      e.preventDefault();
      console.log($(this));
      var ajaxRequest = $.ajax({
        url: '/posts',
        type: 'POST', // GET, PUT, DELETE
        data: $(this).serialize()
      });

      ajaxRequest.done(function(response){
        console.log(response);
        var newHTML = "<p>Title: " + response.title + "</p><p>Content: " + response.content + "</p>";
        $('#newPost').remove();
        $('body').append(newHTML);
      });

      ajaxRequest.fail(function(response){
        console.log(response);
      });
    });

  });
});