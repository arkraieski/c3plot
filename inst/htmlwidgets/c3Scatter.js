HTMLWidgets.widget({

    name: 'c3Scatter',

    type: 'output',

    factory: function(el, width, height) {

        // TODO: define shared variables for this instance

        return {

            renderValue: function(x) {

                var xCol = x.data.x;
                xCol.unshift("xCol");

                var yCol = x.data.y;
                yCol.unshift(x.data.ylab);

                var plotType = x.data.plot_type;
                console.log(x);
                console.log(xCol);

                // when tab hidden el.get... returns 0
                //var w = el.getBoundingClientRect().width;
                //var h = el.getBoundingClientRect().height;


                var chart = c3.generate({
                    bindto: el,
                    data: {
                        x: "xCol",
                        columns: [
                            xCol,
                            yCol
                        ],
                        type: plotType
                    },
                    point : {
                      show: x.data.show_points
                    },
                    axis: {
                        x: {
                            label: {
                              text: x.data.xlab,
                              position: "outer-center"

                            },
                            tick: {
                                fit: false
                            }
                        },
                        y: {
                            label: {
                              text: x.data.ylab,
                              position: "outer-middle"

                            }
                        }
                    },
                    legend: {
                        show: false
                    },
                    zoom: {
                        enabled: x.data.zoom

                    },
                    title: {
                        text: x.data.title
                    }

                });

            },

            resize: function(width, height) {

               //var w = el.getBoundingClientRect().width;
               //var h = el.getBoundingClientRect().height;

                 // code to re-render the widget with a new size
                  //chart.resize({
                   //height: h,
                  // width: w
                  //});

            }

        };
    }
});
