# C3 Pie Charts

Draw an interactive pie chart using 'C3.js'

## Usage

``` r
c3pie(
  x,
  labels = names(x),
  col = NULL,
  slice.text = "pct",
  legend.position = "right",
  main = NULL,
  width = NULL,
  height = NULL,
  elementId = NULL
)
```

## Arguments

- x:

  a vector of non-negative numerical quantities. The values in x are
  displayed as the areas of pie slices.

- labels:

  character vector giving names for the slices.

- col:

  character vector of colors to be used in filling the slices. Can be a
  hex value or an R built-in color name.

- slice.text:

  `"pct"` to display percentage-formatted values inside pie slices
  (default c3.js behavior) or `"id"` to display the slice's name from
  `labels` (note that this does not change labels' positioning within
  their slices, so using `slize.text = "id"` may result in poorly-placed
  or cut-off slice labels)

- legend.position:

  Position of the legend. Possible values are `"right"`, `"bottom"`,
  `"inset"`, and `"hide"`.

- main:

  a main title for the plot.

- width:

  width of the widget to create for the plot. The default is NULL, which
  results in automatic resizing based on the plot's container.

- height:

  height of the widget to create for the plot. The default is NULL,
  which results in automatic resizing based on the plot's container.

- elementId:

  Use an explicit element ID for the widget, rather than an
  automatically generated one.

## Examples

``` r
pie.sales <- c(0.12, 0.3, 0.26, 0.16, 0.04, 0.12)
names(pie.sales) <- c("Blueberry", "Cherry",
                    "Apple", "Boston Cream", "Other", "Vanilla Cream")
c3pie(pie.sales)

{"x":{"labels":["Blueberry","Cherry","Apple","Boston Cream","Other","Vanilla Cream"],"values":[0.12,0.3,0.26,0.16,0.04,0.12],"colors":null,"main":null,"label_function":null,"legend":{"position":"right","hide":false}},"evals":[],"jsHooks":[]}c3pie(pie.sales, col = c("purple", "violetred1", "green3",
                      "cornsilk", "cyan", "white"))

{"x":{"labels":["Blueberry","Cherry","Apple","Boston Cream","Other","Vanilla Cream"],"values":[0.12,0.3,0.26,0.16,0.04,0.12],"colors":["#A020F0","#FF3E96","#00CD00","#FFF8DC","#00FFFF","#FFFFFF"],"main":null,"label_function":null,"legend":{"position":"right","hide":false}},"evals":[],"jsHooks":[]}
```
