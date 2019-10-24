require(dplyr)
require(RCurl)
require(elastic)
require(plumber)
require(jsonlite)

handle <- function(res){
  datas <- list()
  for (i in strsplit(res, "&")[[1]]) {
    j <- strsplit(i, "=")
    datas[j[[1]][1]] <- j[[1]][2]
  }
  
  return(data.frame(datas))
}

conn <- connect(host = "127.0.0.1", port = 9200)

#* @apiTitle Simple API

#* Echo provided text
#* @post /
function(req) {
  res <- req$postBody
  res <- fromJSON(res)
  res <- data.frame(res)
  docs_bulk(conn, res, index="enquete", type="test")
  
  list( raw = res )
}
