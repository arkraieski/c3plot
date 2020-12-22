HTMLWidgets.widget({

  name: 'c3barplot',

  type: 'output',

  factory: function(el, width, height) {

    // TODO: define shared variables for this instance

    return {

      renderValue: function(x) {

      var height = x.height;
      height.unshift("height");

      console.log(height);
       var chart = c3.generate({
         bindto: el,
         data: {
           columns:[ height
           ],
           type: "bar"
         },

       });




      },

      resize: function(width, height) {

        // TODO: code to re-render the widget with a new size

      }

    };
  }
});
