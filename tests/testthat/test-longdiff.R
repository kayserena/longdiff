test_that("longdiff function works", {
  expect_equal(longdiff(diffdata, record_id, timepoint, test_score, 2002, 0), c(4,7,8))
})
test_that("longdiff function works", {
  expect_equal(longdiff(diffdata, record_id, timepoint, test_score, 2001, 0), c(1,2,3,7,8))
})
test_that("longdiff function works", {
  expect_equal(longdiff(diffdata, record_id, timepoint, test_score, 2002, 2), c(4,7))
})
