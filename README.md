spoccutils
==========



[![Build Status](https://api.travis-ci.org/ropensci/spoccutils.png)](https://travis-ci.org/ropensci/spoccutils)
[![Build status](https://ci.appveyor.com/api/projects/status/jfgg6p111mynxrdc?svg=true)](https://ci.appveyor.com/project/sckott/spoccutils)
[![Coverage Status](https://coveralls.io/repos/ropensci/spoccutils/badge.svg)](https://coveralls.io/r/ropensci/spoccutils)

Helper for [spocc](https://github.com/ropensci/spocc) - a client for getting species occurrence data from many sources.

This package has utilities for:

* Making maps, with:
    * base R
    * ggplot2
    * Shiny
    * Leaflet
    * GitHub Gists
    * ...
    
We split this package off from `spocc` to make `spocc` lighter weight so that users that just want data don't have to install a bunch of other dependencies for mapping, etc. 

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md)

## Installation

Install `spoccutils`


```r
install.packages("spoccutils", dependencies = TRUE)
```

Or the development version


```r
install.packages("devtools")
devtools::install_github("ropensci/spoccutils")
```


```r
library("spoccutils")
```

## Get data

Get data from GBIF


```r
library("spocc")
(out <- occ(query='Accipiter striatus', from='gbif', limit=100))
#> Searched: gbif
#> Occurrences - Found: 447,905, Returned: 100
#> Search type: Scientific
#>   gbif: Accipiter striatus (100)
```


```r
out$gbif
#> Species [Accipiter striatus (100)] 
#> First 10 rows of [Accipiter_striatus]
#> 
#>                  name  longitude latitude prov
#> 1  Accipiter striatus    0.00000  0.00000 gbif
#> 2  Accipiter striatus         NA       NA gbif
#> 3  Accipiter striatus -104.88120 21.46585 gbif
#> 4  Accipiter striatus  -71.19554 42.31845 gbif
#> 5  Accipiter striatus  -78.15051 37.95521 gbif
#> 6  Accipiter striatus  -97.80459 30.41678 gbif
#> 7  Accipiter striatus  -75.17209 40.34000 gbif
#> 8  Accipiter striatus -122.20175 37.88370 gbif
#> 9  Accipiter striatus  -99.47894 27.44924 gbif
#> 10 Accipiter striatus -135.32701 57.05420 gbif
#> ..                ...        ...      ...  ...
#> Variables not shown: issues (chr), key (int), datasetKey (chr),
#>      publishingOrgKey (chr), publishingCountry (chr), protocol (chr),
#>      lastCrawled (chr), lastParsed (chr), extensions (chr), basisOfRecord
#>      (chr), sex (chr), establishmentMeans (chr), taxonKey (int),
#>      kingdomKey (int), phylumKey (int), classKey (int), orderKey (int),
#>      familyKey (int), genusKey (int), speciesKey (int), scientificName
#>      (chr), kingdom (chr), phylum (chr), order (chr), family (chr), genus
#>      (chr), species (chr), genericName (chr), specificEpithet (chr),
#>      taxonRank (chr), continent (chr), stateProvince (chr), year (int),
#>      month (int), day (int), eventDate (time), modified (chr),
#>      lastInterpreted (chr), references (chr), identifiers (chr), facts
#>      (chr), relations (chr), geodeticDatum (chr), class (chr), countryCode
#>      (chr), country (chr), startDayOfYear (chr), verbatimEventDate (chr),
#>      preparations (chr), institutionID (chr), verbatimLocality (chr),
#>      nomenclaturalCode (chr), higherClassification (chr), rights (chr),
#>      higherGeography (chr), occurrenceID (chr), type (chr), collectionCode
#>      (chr), occurrenceRemarks (chr), gbifID (chr), accessRights (chr),
#>      institutionCode (chr), endDayOfYear (chr), county (chr),
#>      catalogNumber (chr), otherCatalogNumbers (chr), occurrenceStatus
#>      (chr), locality (chr), language (chr), identifier (chr), disposition
#>      (chr), dateIdentified (chr), informationWithheld (chr),
#>      http...unknown.org.occurrenceDetails (chr), rightsHolder (chr),
#>      taxonID (chr), datasetName (chr), recordedBy (chr), identificationID
#>      (chr), eventTime (chr), georeferencedDate (chr), georeferenceSources
#>      (chr), identifiedBy (chr), identificationVerificationStatus (chr),
#>      samplingProtocol (chr), georeferenceVerificationStatus (chr),
#>      individualID (chr), locationAccordingTo (chr),
#>      verbatimCoordinateSystem (chr), previousIdentifications (chr),
#>      georeferenceProtocol (chr), identificationQualifier (chr),
#>      dynamicProperties (chr), georeferencedBy (chr), lifeStage (chr),
#>      elevation (dbl), elevationAccuracy (dbl), waterBody (chr),
#>      recordNumber (chr), samplingEffort (chr), locationRemarks (chr),
#>      infraspecificEpithet (chr), collectionID (chr), ownerInstitutionCode
#>      (chr), datasetID (chr), verbatimElevation (chr), vernacularName (chr)
```

## Make maps

### Leaflet


```r
spp <- c('Danaus plexippus','Accipiter striatus','Pinus contorta')
dat <- occ(query = spp, from = 'gbif', gbifopts = list(hasCoordinate=TRUE))
data <- occ2df(dat)
mapleaflet(data = data, dest = ".")
```

![leafletmap](http://f.cl.ly/items/3w2Y1E3Z0T2T2z40310K/Screen%20Shot%202014-02-09%20at%2010.38.10%20PM.png)


### Github gist


```r
spp <- c('Danaus plexippus','Accipiter striatus','Pinus contorta')
dat <- occ(query=spp, from='gbif', gbifopts=list(hasCoordinate=TRUE))
dat <- fixnames(dat)
dat <- occ2df(dat)
mapgist(data=dat, color=c("#976AAE","#6B944D","#BD5945"))
```

![gistmap](http://f.cl.ly/items/343l2G0A2J3T0n2t433W/Screen%20Shot%202014-02-09%20at%2010.40.57%20PM.png)


### ggplot2


```r
ecoengine_data <- occ(query = 'Lynx rufus californicus', from = 'ecoengine')
mapggplot(ecoengine_data)
```

![ggplot2map](http://f.cl.ly/items/1U1R0E0G392l2q362V33/Screen%20Shot%202014-02-09%20at%2010.44.59%20PM.png)


### Base R plots


```r
spnames <- c('Accipiter striatus', 'Setophaga caerulescens', 'Spinus tristis')
out <- occ(query=spnames, from='gbif', gbifopts=list(hasCoordinate=TRUE))
plot(out, cex=1, pch=10)
```

![basremap](http://f.cl.ly/items/3O13330W3w3Z0H3u1X0s/Screen%20Shot%202014-02-09%20at%2010.46.25%20PM.png)

## Meta

* Please [report any issues or bugs](https://github.com/ropensci/spoccutils/issues).
* License: MIT
* Get citation information for `spoccutils` in R doing `citation(package = 'spoccutils')`

[![ropensci_footer](http://ropensci.org/public_images/github_footer.png)](http://ropensci.org)

[gbif]: https://github.com/ropensci/rgbif
[vertnet]: https://github.com/ropensci/rvertnet
[bison]: https://github.com/ropensci/rbison
[inat]: https://github.com/ropensci/rinat
[taxize]: https://github.com/ropensci/taxize
[ecoengine]: https://github.com/ropensci/ecoengine
[antweb]: http://antweb.org/