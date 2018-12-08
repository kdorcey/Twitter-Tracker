var displaySearch = function () {
//Grab the graph div and the data from the data div
  graph = document.getElementById('graph');
  data = $('#data').data('key1');

  console.log(data);

  //Kyle's playzone///////////////////////////////////

  var search_term = data[0];
  var all_handles = new Array();
  var date_arrays = new Array();
  var value_arrays = new Array();
  var sentiment_arrays = new Array();

  //data[i] is {handle_obj: "twitter_handle", search_obj: search_hash}
  for (var i = 1; i < data.length; i++) {
    all_handles.push(data[i]['handle_obj']);
    graph_data_obj = JSON.parse(data[i]['search_obj']['graph_data']);
    date_arrays.push(graph_data_obj['dates']);
    value_arrays.push(graph_data_obj['values']);
    sentiment_arrays.push(graph_data_obj['sentiment']);
  }


  /////////////////////////////////////////////////////

  graph_title = "'" + search_term + "'";

  var data_arr = new Array();

  for (var i = 0; i < all_handles.length; i++) {

    var traceCount = {
      x: date_arrays[i],
      y: value_arrays[i],
      mode: 'lines+markers',
      name: '# of tweets made by @' + all_handles[i]
    };

    var traceSentiment = {
      x: date_arrays[i],
      y: sentiment_arrays[i],
      mode: 'lines+markers',
      name: 'Sentiment of tweets made by @' + all_handles[i]

    };

    data_arr.push(traceCount);
    data_arr.push(traceSentiment);
  }


//Place the data into a trace



  var layout = {
    title: graph_title,
    xaxis: {
      title: 'Dates of Tweets'
    }
  };



  Plotly.plot(graph, data_arr, layout);
};
jQuery(document).ready(displaySearch);
jQuery(document).on('page:change', displaySearch);
