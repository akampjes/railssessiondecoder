json.array!(@decoders) do |decoder|
  json.extract! decoder, :id
  json.url decoder_url(decoder, format: :json)
end
