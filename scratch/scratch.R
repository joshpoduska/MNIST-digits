install.packages('imager')
# library(imager)

install.packages('https://cran.r-project.org/src/contrib/Archive/magick/magick_2.1.tar.gz')
library(magick++)

install.packages("reticulate") 
library(reticulate)
source_python('pred_for_r.py')
get_list('out.png')

library(httr)
library(jsonlite)

url <- "https://vip.domino.tech:443/models/5da9d5f546e0fb00078ede96/latest/model"
response <- POST(
  url,
  authenticate("YdjGQYtt8jBp2k4xhItQg7AP1xLRQssMxtts3MluiBIxlTtg84ytFB1yFbSsUncv", "YdjGQYtt8jBp2k4xhItQg7AP1xLRQssMxtts3MluiBIxlTtg84ytFB1yFbSsUncv", type = "basic"),
  body=toJSON(list(data=list(input_array = get_list('out.png'))), auto_unbox = TRUE),
  content_type("application/json")
)

preds <- paste(content(response)$result[[1]][[1]], round(content(response)$result[[1]][[2]], 9), sep=': ')
preds

round(content(response)$result[[1]][[1]],4)
round(content(response)$result[[1]][[2]],4)
round(content(response)$result[[2]][[1]],4)
round(content(response)$result[[2]][[2]],4)
round(content(response)$result[[3]][[1]],4)
round(content(response)$result[[3]][[2]],4)
round(content(response)$result[[4]][[1]],4)
round(content(response)$result[[4]][[2]],4)
round(content(response)$result[[5]][[1]],4)
round(content(response)$result[[5]][[2]],4)
round(content(response)$result[[6]][[1]],4)
round(content(response)$result[[6]][[2]],4)
round(content(response)$result[[7]][[1]],4)
round(content(response)$result[[7]][[2]],4)
round(content(response)$result[[8]][[1]],4)
round(content(response)$result[[8]][[2]],4)
round(content(response)$result[[9]][[1]],4)
round(content(response)$result[[9]][[2]],4)




# NOT RUN {
p <- ggplot(mtcars, aes(mpg, wt)) +
  geom_point()
p

# Use theme_set() to completely override the current theme.
# Here we have the old theme so we can later restore it.
# Note that the theme is applied when the plot is drawn, not
# when it is created.
old <- theme_set(theme_bw())
p
theme_set(old)
p


# Modifying theme objects -----------------------------------------
# You can use + and %+replace% to modify a theme object.
# They differ in how they deal with missing arguments in
# the theme elements.

add_el <- theme_grey() +
  theme(text = element_text(family = "Times"))
add_el$text

rep_el <- theme_grey() %+replace%
  theme(text = element_text(family = "Times"))
rep_el$text

# theme_update() and theme_replace() are similar except they
# apply directly to the current/active theme.
# }

theme()

