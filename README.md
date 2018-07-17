
<!-- README.md is generated from README.Rmd. Please edit that file -->

# Find the best locations for facilities using `maxcovr`

A talk presented by [Nick Tierney](http://www.njtierney.com/), presented
at [UseR\!2018](https://user2018.r-project.org/)

Twitter: [@nj\_tierney](https://twitter.com/nj_tierney)

GitHub: [@njtierney](https://github.com/njtierney)

maxcovr R package: [maxcovr](https://github.com/njtierney/maxcovr)

### Abstract

> Want better wifi at the office? Improved access to healthcare? The
> maximal covering location problem (MCLP) can help\! The MCLP finds
> optimal locations of facilities to improve their coverage on a set of
> targets. This means better placed wifi routers and healthcare
> facilities. Although the MCLP was described in the 1970s, it can be
> daunting to actually implement as you need to know how to:

> 1)  Formulate an optimisation problem
> 2)  Make it talk to a solver engine
> 3)  Get the data into the appropriate format for the solver to
>     recognise
> 4)  Translate the model output into a usable format

> It is challenging, particularly if you are not familiar with
> optimisation, or techniques such as linear programming. It is,
> however, a great use case for an R package to abstract away detail you
> don’t need to worry about. The R package maxcovr provides a set of
> tools to perform, summarise, and visualise the MCLP, so that you can
> move on with your analysis, place better cellphone towers, and create
> better access to health facilities.In this talk, I describe why the
> MCLP is useful, where it can be applied, and demonstrate of the use of
> maxcovr, before finally discussing future directions.

# Slides

The source code for the slides can be found in
`UseR2018-maxcovr-talk.Rmd`, and you can view the slides as they were
presented as UseR,
[here](https://talks.updog.co/user2018-maxcovr/user2018-maxcovr-talk.html#1).

# Video

Thanks to the [R Consortium](https://www.r-consortium.org/), you can
view the video of my talk
[here](https://www.youtube.com/watch?v=sA8ItKmdwjM&t=2s).

# Data

This talk drew upon publicly available datasets from the Brisbane
government - from <https://www.data.brisbane.qld.gov.au/>. The datasets
were initially suggested by friendly folks from the Stories with Data
Slack channel, Alex Sadleir, and Dave A.

The data comes from the following repositories:

  - [Property Address
    Locations](https://www.data.brisbane.qld.gov.au/data/dataset/property-address-data)
  - [Wireless hotspot
    locations](https://www.data.brisbane.qld.gov.au/data/dataset/wireless-hotspot-sites-libraries-and-parks)
  - [Bus stop
    locations](https://www.data.brisbane.qld.gov.au/data/dataset/brisbane-bus-stops)
  - [Public art
    locations](https://www.data.brisbane.qld.gov.au/data/dataset/public-art/resource/3c972b8e-9340-4b6d-8c7b-2ed988aa3343?view_id=ee54f886-717b-4cc1-b012-944d48ac597e)

Each of the datasets, along with code for cleaning them up for their use
in the talk, and a README description of the data can be found in the
[`data-raw/`](https://github.com/njtierney/user-2018-maxcovr-talk/tree/master/data-raw)
folder
