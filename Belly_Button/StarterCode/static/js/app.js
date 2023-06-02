// Function to fetch data and create plots
function createPlots(id) {
    fetch("https://2u-data-curriculum-team.s3.amazonaws.com/dataviz-classroom/v1.1/14-Interactive-Web-Visualizations/02-Homework/samples.json")
      .then(function(response) {
        if (response.ok) {
          return response.json();
        } else {
          throw new Error("Error loading samples.json");
        }
      })
      .then(function(data) {
        let sampleData = data;
        let samples = sampleData.samples;
        let identifier = samples.filter(sample => sample.id === id);
        let filtered = identifier[0];
        let OTUvalues = filtered.sample_values.slice(0, 10).reverse();
        let OTUids = filtered.otu_ids.slice(0, 10).reverse();
        let labels = filtered.otu_labels.slice(0, 10).reverse();
        let barTrace = {
          x: OTUvalues,
          y: OTUids.map(object => 'OTU ' + object),
          name: labels,
          type: 'bar',
          orientation: 'h'
        };
        let barLayout = {
          title: `Top 10 OTUs for Subject ${id}`,
          xaxis: { title: 'Sample Values' },
          yaxis: { title: 'OTU ID' }
        };
        let barData = [barTrace];
        Plotly.newPlot('bar', barData, barLayout);
        let bubbleTrace = {
          x: filtered.otu_ids,
          y: filtered.sample_values,
          mode: 'markers',
          marker: {
            size: filtered.sample_values,
            color: filtered.otu_ids,
            colorscale: 'Portland'
          },
          text: filtered.otu_labels,
        };
        let bubbleData = [bubbleTrace];
        let bubbleLayout = {
          title: `OTUs for Subject ${id}`,
          xaxis: { title: 'OTU ID' },
          yaxis: { title: 'Sample Values' }
        };
        Plotly.newPlot('bubble', bubbleData, bubbleLayout);
      })
      .catch(function(error) {
        console.log(error);
      });
  }
  
  // Function to handle ID change event
  function handleIdChange() {
    var dropdown = document.getElementById('selDataset');
    var id = dropdown.value;
    createPlots(id);
  }
  
  // Function to initialize the dropdown and plots
  function initialize() {
    var dropdown = document.getElementById('selDataset');
    fetch("https://2u-data-curriculum-team.s3.amazonaws.com/dataviz-classroom/v1.1/14-Interactive-Web-Visualizations/02-Homework/samples.json")
      .then(function(response) {
        if (response.ok) {
          return response.json();
        } else {
          throw new Error("Error loading samples.json");
        }
      })
      .then(function(data) {
        var sampleData = data;
        var names = sampleData.names;
        names.forEach(function(value) {
          var option = document.createElement('option');
          option.text = value;
          dropdown.add(option);
        });
        createPlots(names[0]);
        dropdown.addEventListener('change', handleIdChange);
      })
      .catch(function(error) {
        console.log(error);
      });
  }
  
  // Call the initialize function
  initialize();
  