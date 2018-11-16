graph = document.getElementById('graph2');
all_data = $('#data').data('key1');
console.log("ow")
var initial;
for(initial = 0; initial<all_data.length; initial++)  {

  var data = all_data[initial];
  //Create an array for the x and y values
  var dates = new Array();
  var y_vals = new Array();
  //Array of all traces
  var data_arr = new Array();
  console.log("heres the message" + data.toString());
  //Iterate over the JSON and push the elements into appropriate arrays
  var next;
  for (next = 0; next < data.length; next++){
    dates.push(data[next]['date']);
    y_vals.push(data[next]['value']);

  }

  //Place the data into a trace
  var trace = {
    x: dates,
    y: y_vals,
    mode: 'lines+markers'};

  data_arr.push(trace);

  var div = document.createElement('div');
  document.getElementById('graph2').appendChild(div)
  Plotly.plot(div, data_arr);
}
