json.movie [@movieEntry] do |movie| 
  json.bestMovie movie.bestMovie
  json.producers movie.producers

  nomineeString = ""
  count = movie.nominees.count
  movie.nominees.each_with_index do |nominee, index|
    if index == count - 2 then
      nomineeString += nominee + ' and '
    elsif index == count - 1 then
      nomineeString += nominee
    else
      nomineeString += nominee + ', '
    end
  end
  json.nominees nomineeString

  producerString = ""
  count = movie.producers.count
  if count > 0 then
    json.producersExist true
  else
    json.producersExist false
  end

  movie.producers.each_with_index do |producer, index|
    if index == count - 2 then
      producerString += producer + ' and '
    elsif index == count - 1 then
      producerString += producer
    else
      producerString += producer + ', '
    end
  end
  json.producers producerString

end