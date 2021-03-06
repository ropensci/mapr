context("map_gist works correctly")

test_that("map_gist works as expected", {
  skip_on_cran()
  skip_if_not_installed("scrubr")

  library("spocc")
  library("scrubr")

  spp <- c('Danaus plexippus','Accipiter striatus','Pinus contorta')
  dat <- occ(spp, from = 'gbif', limit = 30, has_coords = TRUE)
  df <- occ2df(dat)
  dat <- suppressWarnings(fix_names(df, "shortest"))

  # Define colors
  g <- suppressMessages(
    map_gist(dat, color = c('#976AAE','#6B944D','#BD5945'),
      browse = FALSE))

  expect_is(g, "gist")
  expect_is(g$url, "character")
  expect_equal(g$description, "")
})
