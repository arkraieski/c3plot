HTMLWidgets.widget({

  name: 'c3barplot',

  type: 'output',

  factory: function(el, width, height) {

    // TODO: define shared variables for this instance

    return {

      renderValue: function(x) {

      var height = x.height;
      var dataLabel = {};
      if(x.ylab === null){
      height.unshift("height");
      dataLabel = "height";
      } else{
        var ylab = x.ylab;
        height.unshift(x.ylab);
        dataLabel = ylab;
        }

      var mycols = {};
      mycols[dataLabel] = x.col;

      if(!(x.categories === null)){
        var xaxis = {
          type: "category",
          categories: x.categories
        };
      }



      console.log(height);
       var chart = c3.generate({
         bindto: el,
         data: {
           columns:[ height
           ],
           type: "bar",
           colors: mycols
         },
         axis: {
           x: xaxis,
           y: {
             label: {
                text: ylab,
                position:  "outer-middle"
             }
           }
         },
         title: {
           text: x.main
         },
         legend: {
           show: false
         }

       });




      },

      resize: function(width, height) {

        // TODO: code to re-render the widget with a new size

      }

    };
  }
});
