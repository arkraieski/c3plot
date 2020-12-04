HTMLWidgets.widget({

    name: 'c3Scatter',

    type: 'output',

    factory: function(el, width, height) {

        // TODO: define shared variables for this instance

        return {

            renderValue: function(x) {
                if (x.data.grouped_data === null) {

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
                    var color = {};
                    color[x.data.ylab] = x.data.col_hex;

                    var chart = c3.generate({
                        bindto: el,
                        data: {
                            x: "xCol",
                            columns: [
                                xCol,
                                yCol
                            ],
                            type: plotType,
                            colors: color
                        },
                        point: {
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

                } else {

                    var yCols = Object.values(x.data.grouped_data.y);
                    console.log(yCols);

                    yCols.forEach(function(yCols, index) {
                        yCols.unshift(x.data.group_names[index]);
                    });

                    // yCols.forEach(function(yCols, index) {
                    //   yCols.unshift(x.data.group_names[index]);
                    //});
                    //for(var i = 0, l = x.data.grouped_data.y.length; i < 1; i++){
                    //   x.data.grouped_data.y[i].unshift(x.data.group_names[i]);
                    // }


                    // Object.keys(x.data.grouped_data.y).forEach(function (key, index){
                    //    x.data.grouped_data.y[key].unshift(x.data.group_names[index]);
                    // });
                    var xCols = Object.values(x.data.grouped_data.x);
                    var myXs = {};
                    x.data.group_names.forEach(function(group_names, index) {
                        let xstring = "x";
                        xstring = xstring.concat(index);
                        xCols[index].unshift(xstring);
                        //xCols[index][0] = xstring;
                        myXs[group_names] = xstring;
                    });

                    console.log(myXs);

                    var color = {};
                    if (!(x.data.col_hex === null)) {

                        x.data.group_names.forEach(function(group_names, index) {
                            color[group_names] = x.data.col_hex[index];
                        });
                    }

                    var allCols = xCols.concat(yCols);


                    var chart = c3.generate({
                        bindto: el,
                        data: {
                            xs: myXs,
                            columns: allCols,
                            type: x.data.plot_type,
                            colors: color
                        },
                        point: {
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
                            show: true,
                            position: "right"
                        },
                        zoom: {
                            enabled: x.data.zoom

                        },
                        title: {
                            text: x.data.title
                        }

                    });
                    var firstLegend = d3.select(".c3-legend-item");
                    var legendCon = d3.select(firstLegend.node().parentNode);
                    var legendY = parseInt(firstLegend.select('text').attr('y'));
                    legendCon
                        .append('text')
                        .text('Legend Title')
                        .attr('y', legendY - 20)
                        .attr("font-size", "12px")
                }

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
