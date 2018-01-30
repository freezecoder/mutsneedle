# Mutsneedle: An R package to generating interactive  lolipop plots


Mutsneedle is an R version of the MutsNeedlePlot package developed by   Michael Schroeder https://github.com/mpschr
In many bioinformatics/genomics task involving mutation inspection it is quite useful to explore the significant of certain alterations to a protein sequence.

Installation
==============

Firstly download and Install the package using devtools

```
library(devtools)
install_github("freezecoder/mutsneedle")
```


Usage
==============


The mutsneedle function expects a data frame of mutation information for a particular gene. It can also accept domain/region information to annotate the lolipop plot.


```
mutsneedle(mutdata=exampleData(),domains=exampleRegionData())
```


The mutdata input is an R data frame with the colums:

* coord - A string coordinate e.g. "11" , "1-10" are both valid
* category - String describing the category of the mutation
* value - numeric value

Other columns may be present in the dataframe but they will be ignored.


You may also insert a gene and transcript ID into the plot using the 'gene' and 'transcript' args to the mutsneedle function.

Usage in a Shiny App
=====================

The app is quite easy to call in Shiny thanks to the wonderful htmlwidgets package

```
library(shiny)
library(mutsneedle)
shinyApp(
   ui = mutsneedleOutput("id",width=800,height=500),
   server = function(input, output) {
     output$id <- renderMutsneedle(
        data <- exampleMutationData()
        regiondata <- exampleRegionData()
       mutsneedle(mutdata=data,domains=regiondata)
     )
   }
 )

```



More info Mutations Needle Plot (muts-needle-plot)
=================================================

A needle-plot (aka stem-plot or lollipop-plot) plots each data point as a big dot and adds a vertical line that makes it appear like a needle. 

![DOI](https://zenodo.org/badge/7688/bbglab/muts-needle-plot.svg)

This software is **citable**! Different citation styles available at *http://dx.doi.org/*+DOI

Availability
-----------------------

   * **Live examples** at the BioJS-registry: <http://biojs.io/d/muts-needle-plot>
   * **Installable JavaScript library** at npm-registry: <https://www.npmjs.org/package/muts-needle-plot>
   * **Source code** at GitHub: <https://github.com/bbglab/muts-needle-plot>

![Image of a Needle-Plot](mutations-needle-plot.png)

Examples (snippets)
----------------------

This library is can be found as npm-library in the BioJS registry.

 Thus examples can bee seen at the biojs.net registry: <http://biojs.net/>


Issues
----------

Please report issues at: <https://github.com/freezecoder/mutsneedle/issues>
Authors
--------

Original credit goes to Michael Schroeder and his group for the javascript version.

The R/HTMLWidgets credit is done by

**Zayed Albertyn**

+ <https://github.com/freezecoder>
