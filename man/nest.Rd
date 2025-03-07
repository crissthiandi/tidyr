% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/nest.R
\name{nest}
\alias{nest}
\alias{unnest}
\title{Nest and unnest}
\usage{
nest(.data, ..., .names_sep = NULL, .key = deprecated())

unnest(
  data,
  cols,
  ...,
  keep_empty = FALSE,
  ptype = NULL,
  names_sep = NULL,
  names_repair = "check_unique",
  .drop = deprecated(),
  .id = deprecated(),
  .sep = deprecated(),
  .preserve = deprecated()
)
}
\arguments{
\item{.data}{A data frame.}

\item{...}{<\code{\link[=tidyr_tidy_select]{tidy-select}}> Columns to nest, specified
using name-variable pairs of the form \code{new_col = c(col1, col2, col3)}.
The right hand side can be any valid tidy select expression.

\ifelse{html}{\href{https://lifecycle.r-lib.org/articles/stages.html#deprecated}{\figure{lifecycle-deprecated.svg}{options: alt='[Deprecated]'}}}{\strong{[Deprecated]}}:
previously you could write \code{df \%>\% nest(x, y, z)} and \code{df \%>\% unnest(x, y, z)}. Convert to \code{df \%>\% nest(data = c(x, y, z))}.
and \code{df \%>\% unnest(c(x, y, z))}.

If you previously created new variable in \code{unnest()} you'll now need to
do it explicitly with \code{mutate()}. Convert \code{df \%>\% unnest(y = fun(x, y, z))}
to \code{df \%>\% mutate(y = fun(x, y, z)) \%>\% unnest(y)}.}

\item{.key}{\ifelse{html}{\href{https://lifecycle.r-lib.org/articles/stages.html#deprecated}{\figure{lifecycle-deprecated.svg}{options: alt='[Deprecated]'}}}{\strong{[Deprecated]}}:
No longer needed because of the new \code{new_col = c(col1, col2, col3)} syntax.}

\item{data}{A data frame.}

\item{cols}{<\code{\link[=tidyr_tidy_select]{tidy-select}}> Columns to unnest.

If you \code{unnest()} multiple columns, parallel entries must be of
compatible sizes, i.e. they're either equal or length 1 (following the
standard tidyverse recycling rules).}

\item{keep_empty}{By default, you get one row of output for each element
of the list your unchopping/unnesting. This means that if there's a
size-0 element (like \code{NULL} or an empty data frame), that entire row
will be dropped from the output. If you want to preserve all rows,
use \code{keep_empty = TRUE} to replace size-0 elements with a single row
of missing values.}

\item{ptype}{Optionally, a named list of column name-prototype pairs to
coerce \code{cols} to, overriding the default that will be guessed from
combining the individual values. Alternatively, a single empty ptype
can be supplied, which will be applied to all \code{cols}.}

\item{names_sep, .names_sep}{If \code{NULL}, the default, the names will be left
as is. In \code{nest()}, inner names will come from the former outer names;
in \code{unnest()}, the new outer names will come from the inner names.

If a string, the inner and outer names will be used together. In
\code{unnest()}, the names of the new outer columns will be formed by pasting
together the outer and the inner column names, separated by \code{names_sep}. In
\code{nest()}, the new inner names will have the outer names + \code{names_sep}
automatically stripped. This makes \code{names_sep} roughly symmetric between
nesting and unnesting.}

\item{names_repair}{Used to check that output data frame has valid
names. Must be one of the following options:
\itemize{
\item "minimal": no name repair or checks, beyond basic existence,
\item "unique": make sure names are unique and not empty,
\item "check_unique": (the default), no name repair, but check they are unique,
\item "universal": make the names unique and syntactic
\item a function: apply custom name repair.
\item \link{tidyr_legacy}: use the name repair from tidyr 0.8.
\item a formula: a purrr-style anonymous function (see \code{\link[rlang:as_function]{rlang::as_function()}})
}

See \code{\link[vctrs:vec_as_names]{vctrs::vec_as_names()}} for more details on these terms and the
strategies used to enforce them.}

\item{.drop, .preserve}{\ifelse{html}{\href{https://lifecycle.r-lib.org/articles/stages.html#deprecated}{\figure{lifecycle-deprecated.svg}{options: alt='[Deprecated]'}}}{\strong{[Deprecated]}}:
all list-columns are now preserved; If there are any that you
don't want in the output use \code{select()} to remove them prior to
unnesting.}

\item{.id}{\ifelse{html}{\href{https://lifecycle.r-lib.org/articles/stages.html#deprecated}{\figure{lifecycle-deprecated.svg}{options: alt='[Deprecated]'}}}{\strong{[Deprecated]}}:
convert \code{df \%>\% unnest(x, .id = "id")} to \verb{df \%>\% mutate(id = names(x)) \%>\% unnest(x))}.}

\item{.sep}{\ifelse{html}{\href{https://lifecycle.r-lib.org/articles/stages.html#deprecated}{\figure{lifecycle-deprecated.svg}{options: alt='[Deprecated]'}}}{\strong{[Deprecated]}}:
use \code{names_sep} instead.}
}
\description{
Nesting creates a list-column of data frames; unnesting flattens it back out
into regular columns. Nesting is implicitly a summarising operation: you
get one row for each group defined by the non-nested columns. This is useful
in conjunction with other summaries that work with whole datasets, most
notably models.

Learn more in \code{vignette("nest")}.
}
\section{New syntax}{

tidyr 1.0.0 introduced a new syntax for \code{nest()} and \code{unnest()} that's
designed to be more similar to other functions. Converting to the new syntax
should be straightforward (guided by the message you'll recieve) but if
you just need to run an old analysis, you can easily revert to the previous
behaviour using \code{\link[=nest_legacy]{nest_legacy()}} and \code{\link[=unnest_legacy]{unnest_legacy()}} as follows:

\if{html}{\out{<div class="sourceCode">}}\preformatted{library(tidyr)
nest <- nest_legacy
unnest <- unnest_legacy
}\if{html}{\out{</div>}}
}

\section{Grouped data frames}{

\code{df \%>\% nest(data = c(x, y))} specifies the columns to be nested; i.e. the
columns that will appear in the inner data frame. Alternatively, you can
\code{nest()} a grouped data frame created by \code{\link[dplyr:group_by]{dplyr::group_by()}}. The grouping
variables remain in the outer data frame and the others are nested. The
result preserves the grouping of the input.

Variables supplied to \code{nest()} will override grouping variables so that
\code{df \%>\% group_by(x, y) \%>\% nest(data = !z)} will be equivalent to
\code{df \%>\% nest(data = !z)}.
}

\examples{
df <- tibble(x = c(1, 1, 1, 2, 2, 3), y = 1:6, z = 6:1)
# Note that we get one row of output for each unique combination of
# non-nested variables
df \%>\% nest(data = c(y, z))
# chop does something similar, but retains individual columns
df \%>\% chop(c(y, z))

# use tidyselect syntax and helpers, just like in dplyr::select()
df \%>\% nest(data = any_of(c("y", "z")))

iris \%>\% nest(data = !Species)
nest_vars <- names(iris)[1:4]
iris \%>\% nest(data = any_of(nest_vars))
iris \%>\%
  nest(petal = starts_with("Petal"), sepal = starts_with("Sepal"))
iris \%>\%
  nest(width = contains("Width"), length = contains("Length"))

# Nesting a grouped data frame nests all variables apart from the group vars
library(dplyr)
fish_encounters \%>\%
  group_by(fish) \%>\%
  nest()

# Nesting is often useful for creating per group models
mtcars \%>\%
  group_by(cyl) \%>\%
  nest() \%>\%
  mutate(models = lapply(data, function(df) lm(mpg ~ wt, data = df)))

# unnest() is primarily designed to work with lists of data frames
df <- tibble(
  x = 1:3,
  y = list(
    NULL,
    tibble(a = 1, b = 2),
    tibble(a = 1:3, b = 3:1)
  )
)
df \%>\% unnest(y)
df \%>\% unnest(y, keep_empty = TRUE)

# If you have lists of lists, or lists of atomic vectors, instead
# see hoist(), unnest_wider(), and unnest_longer()

#' # You can unnest multiple columns simultaneously
df <- tibble(
  a = list(c("a", "b"), "c"),
  b = list(1:2, 3),
  c = c(11, 22)
)
df \%>\% unnest(c(a, b))

# Compare with unnesting one column at a time, which generates
# the Cartesian product
df \%>\% unnest(a) \%>\% unnest(b)
}
