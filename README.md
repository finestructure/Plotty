# Plotty

Plotty is a command line tool to quickly plot comparisons for data series, typically from performance measurements.

It does not require structured input but instead will parse floating point numbers from input lines. Lines without floating point numbers signal the end of a series and start a new one.

This allows you to read unstructured data from standard input, the clipboard, or an input file to quickly get a view of the data.

## Example

See the included [example input file](/misc/sample-input.txt) for the type of input you can provide and the generated plot for the output from the command:

```
plotty --input misc/sample-input.txt \
  --header Plotty \
  --title "Performance comparison" \
  --output misc/sample-output.pdf
```

![Example output image](/misc/sample-output.png)

See `plotty --help` for more details.

## Output format

Plotty renders its output to resolution independent PDF. It does not currently support any other output formats and relies on other tools to be used to convert to other graphics formats.

## Installation instructions

The easiest way to install Plott is via [`mint`](https://swiftpackageindex.com/yonaskolb/Mint):

```
mint install finestructure/Plotty
```
