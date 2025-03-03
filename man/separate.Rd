% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/separate.R
\name{separate}
\alias{separate}
\title{Separate a character column into multiple columns with a regular
expression or numeric locations}
\usage{
separate(
  data,
  col,
  into,
  sep = "[^[:alnum:]]+",
  remove = TRUE,
  convert = FALSE,
  extra = "warn",
  fill = "warn",
  ...
)
}
\arguments{
\item{data}{A data frame.}

\item{col}{Column name or position. This is passed to
\code{\link[tidyselect:vars_pull]{tidyselect::vars_pull()}}.

This argument is passed by expression and supports
\link[rlang:topic-inject]{quasiquotation} (you can unquote column
names or column positions).}

\item{into}{Names of new variables to create as character vector.
Use \code{NA} to omit the variable in the output.}

\item{sep}{Separator between columns.

If character, \code{sep} is interpreted as a regular expression. The default
value is a regular expression that matches any sequence of
non-alphanumeric values.

If numeric, \code{sep} is interpreted as character positions to split at. Positive
values start at 1 at the far-left of the string; negative value start at -1 at
the far-right of the string. The length of \code{sep} should be one less than
\code{into}.}

\item{remove}{If \code{TRUE}, remove input column from output data frame.}

\item{convert}{If \code{TRUE}, will run \code{\link[=type.convert]{type.convert()}} with
\code{as.is = TRUE} on new columns. This is useful if the component
columns are integer, numeric or logical.

NB: this will cause string \code{"NA"}s to be converted to \code{NA}s.}

\item{extra}{If \code{sep} is a character vector, this controls what
happens when there are too many pieces. There are three valid options:
\itemize{
\item "warn" (the default): emit a warning and drop extra values.
\item "drop": drop any extra values without a warning.
\item "merge": only splits at most \code{length(into)} times
}}

\item{fill}{If \code{sep} is a character vector, this controls what
happens when there are not enough pieces. There are three valid options:
\itemize{
\item "warn" (the default): emit a warning and fill from the right
\item "right": fill with missing values on the right
\item "left": fill with missing values on the left
}}

\item{...}{Additional arguments passed on to methods.}
}
\description{
Given either a regular expression or a vector of character positions,
\code{separate()} turns a single character column into multiple columns.
}
\examples{
library(dplyr)
# If you want to split by any non-alphanumeric value (the default):
df <- data.frame(x = c(NA, "x.y", "x.z", "y.z"))
df \%>\% separate(x, c("A", "B"))

# If you just want the second variable:
df \%>\% separate(x, c(NA, "B"))

# If every row doesn't split into the same number of pieces, use
# the extra and fill arguments to control what happens:
df <- data.frame(x = c("x", "x y", "x y z", NA))
df \%>\% separate(x, c("a", "b"))
# The same behaviour as previous, but drops the c without warnings:
df \%>\% separate(x, c("a", "b"), extra = "drop", fill = "right")
# Opposite of previous, keeping the c and filling left:
df \%>\% separate(x, c("a", "b"), extra = "merge", fill = "left")
# Or you can keep all three:
df \%>\% separate(x, c("a", "b", "c"))

# To only split a specified number of times use extra = "merge":
df <- data.frame(x = c("x: 123", "y: error: 7"))
df \%>\% separate(x, c("key", "value"), ": ", extra = "merge")

# Use regular expressions to separate on multiple characters:
df <- data.frame(x = c(NA, "a1b", "c4d", "e9g"))
df \%>\% separate(x, c("A", "B"), sep = "[0-9]")

# convert = TRUE detects column classes:
df <- data.frame(x = c("x:1", "x:2", "y:4", "z", NA))
df \%>\% separate(x, c("key", "value"), ":") \%>\% str()
df \%>\% separate(x, c("key", "value"), ":", convert = TRUE) \%>\% str()
}
\seealso{
\code{\link[=unite]{unite()}}, the complement, \code{\link[=extract]{extract()}} which uses regular
expression capturing groups.
}
