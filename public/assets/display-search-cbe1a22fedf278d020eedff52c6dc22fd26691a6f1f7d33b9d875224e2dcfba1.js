//Grab the graph div and the data from the data div
graph = document.getElementById('graph');
data = jQuery('#data').data('key1');
//Create an array for the x and y values
var dates = new Array();
var y_vals = new Array();

//Array of all traces


//Iterate over the JSON and push the elements into appropriate arrays
var i;
for (i = 0; i < data.length; i++){
  dates.push(data[i]['date']);
  y_vals.push(data[i]['value']);
}

//Place the data into a trace
var trace = {
  x: dates,
  y: y_vals,
  mode: 'lines+markers'};

var data_arr = new Array();
data_arr.push(trace);


var div = document.createElement('div');
document.getElementById('graph').appendChild(div)
Plotly.plot(div, data_arr);
