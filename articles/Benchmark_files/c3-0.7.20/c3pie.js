HTMLWidgets.widget({

  name: 'c3pie',

  type: 'output',

  factory: function(el, width, height) {

    // TODO: define shared variables for this instance

    return {

      renderValue: function(x) {

        var pieJSON = {};
        x.labels.forEach(function (labels, index) {
          pieJSON[labels] = x.values[index];
        });

        var plotColors = {};
        if(!(x.colors === null)){
        x.labels.forEach(function (labels, index){
          plotColors[labels] = x.colors[index];
        });
        }
        console.log(pieJSON);

        var chart = c3.generate({
          bindto: el,
          data: {
            json: pieJSON,
            type : 'pie',
            colors: plotColors
        },
          pie: {
            label: {
              format: x.label_function

            }
          },
          title: {
           text: x.main
         }
      });

      },

      resize: function(width, height) {

        // TODO: code to re-render the widget with a new size

      }

    };
  }
});
