HTMLWidgets.widget({

    name: 'c3Scatter',

    type: 'output',

    factory: function(el, width, height) {

        // TODO: define shared variables for this instance

        return {

            renderValue: function(x) {

                var chart = {};
                var color = {};

                var xpadding = {};
                var xMax = undefined;
                var xMin = undefined;
                if(x.data.xlim !== null){
                    xpadding = {left: 0, right: 0 };
                    xMax = x.data.xlim[1];
                    xMin = x.data.xlim[0];
                }

                var ypadding = {};
                var yMax = null;
                var yMin = null;
                if(x.data.ylim !== null){
                    ypadding = {top: 0, bottom: 0};
                    yMax = x.data.ylim[1];
                    yMin = x.data.ylim[0];

                }


                var xTickFormat = {};
                if(x.data.sci_x){
                    xTickFormat = {format: function(x) {return x.toExponential();},
                        fit: false
                    };
                } else{
                   xTickFormat = {
                    fit: false

                   };
                }

                var yTickFormat = {};
                if(x.data.sci_y) {
                    yTickFormat = {format: function(x) {return x.toExponential();}};
                } else {
                    yTickFormat = null ;
                }

                if (x.data.grouped_data === null) {

                    var xCol = x.data.x;
                    xCol.unshift("xCol");

                    var yCol = x.data.y;
                    yCol.unshift(x.data.ylab);

                    var plotType = x.data.plot_type;


                    color[x.data.ylab] = x.data.col_hex;

                    chart = c3.generate({
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
                                max: xMax,
                                min: xMin,
                                padding: xpadding,
                                label: {
                                    text: x.data.xlab,
                                    position: "outer-center"

                                },
                                tick: xTickFormat
                            },
                            y: {

                                max: yMax,
                                min: yMin,
                                padding: ypadding,
                                label: {
                                    text: x.data.ylab,
                                    position: "outer-middle"

                                },
                                tick: yTickFormat
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
                        },
                        tooltip: {
                            grouped: false
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


                    if (!(x.data.col_hex === null)) {

                        x.data.group_names.forEach(function(group_names, index) {
                            color[group_names] = x.data.col_hex[index];
                        });
                    }

                    var allCols = xCols.concat(yCols);


                    chart = c3.generate({
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
                                max: xMax,
                                min: xMin,
                                padding: xpadding,

                                label: {
                                    text: x.data.xlab,
                                    position: "outer-center"

                                },
                                tick: xTickFormat
                            },
                            y: {
                                max: yMax,
                                min: yMin,
                                padding: ypadding,
                                label: {
                                    text: x.data.ylab,
                                    position: "outer-middle"

                                },
                                tick: yTickFormat
                            }
                        },
                        legend: {
                            hide: x.data.legend.hide,
                            position: x.data.legend.position
                        },
                        zoom: {
                            enabled: x.data.zoom

                        },
                        title: {
                            text: x.data.title
                        },
                        tooltip: {
                            grouped: false
                        }


                    });
                    var firstLegend = d3.select(".c3-legend-item");
                    var legendCon = d3.select(firstLegend.node().parentNode);
                    var legendY = parseInt(firstLegend.select('text').attr('y'));
                    legendCon
                        .append('text')
                        .text(x.data.legend.text)
                        .attr('y', legendY - 20)
                        .attr("font-size", "12px");
                }

            },

            resize: function(width, height) {



            }

        };
    }
});
