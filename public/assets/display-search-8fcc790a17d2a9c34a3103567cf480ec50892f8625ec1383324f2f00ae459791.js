
jQuery(document).ready(function() {
//Grab the graph div and the data from the data div
  graph = document.getElementById('graph');
  data = jQuery('#data').data('key1');
  search_term = $('#data').data('key2');
  twitter_handle = $('#data').data('key3');

  graph_title = "'" + search_term + "' tweeted by @" + twitter_handle;
//Create an array for the x and y values
  var dates = new Array();
  var y_vals = new Array();

//Array of all traces


//Iterate over the JSON and push the elements into appropriate arrays
  var i;
  for (i = 0; i < data.length; i++) {
    dates.push(data[i]['date']);
    y_vals.push(data[i]['value']);
  }

//Place the data into a trace
  var trace = {
    x: dates,
    y: y_vals,
    mode: 'lines+markers'
  };


  var layout = {
    title: graph_title,
    xaxis: {
      title: 'Dates of Tweets'
    },
    yaxis: {
      title: '# of Tweets'
    }
  };

  var data_arr = new Array();
  data_arr.push(trace);

  Plotly.plot(graph, data_arr, layout);
});
