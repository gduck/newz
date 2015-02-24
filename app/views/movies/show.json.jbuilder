json.movie [@movieEntry] do |movie| 
  json.bestMovie movie.bestMovie
  json.producers movie.producers
  json.nominees movie.nominees
end