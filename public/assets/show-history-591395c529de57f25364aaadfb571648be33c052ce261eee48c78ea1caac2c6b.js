
var history_graph_show = {

  setup: function() {
    var graph = document.getElementById('graph2');
    var all_data = jQuery('#data').data('key1');
    all_data = all_data.reverse(); //show latest search history first
    var initial;
    for (initial = 0; initial < all_data.length; initial++) {

      var data = all_data[initial];
      //Create an array for the x and y values
      var dates = new Array();
      var y_vals = new Array();
      //Array of all traces
      var data_arr = new Array();
      //Iterate over the JSON and push the elements into appropriate arrays
      var next;
      for (next = 0; next < data.length; next++) {
        dates.push(data[next]['date']);
        y_vals.push(data[next]['value']);

      }

      //Place the data into a trace
      var trace = {
        x: dates,
        y: y_vals,
        mode: 'lines+markers'
      };

      data_arr.push(trace);

      var div = document.createElement('div');
      graph.appendChild(div);
      Plotly.plot(div, data_arr);
      // jQuery('#graph2').load();
    }
  }
};
jQuery(history_graph_show.setup());
