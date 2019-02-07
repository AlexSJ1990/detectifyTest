filepath = 'urls.csv'

def parse_csv(filepath)
  CSV.foreach(filepath) do |row|
    "#{row[0]}"
  end
end

parse_csv(filepath)

filepath = 'urls.json'
def parse_json(filepath)
  serialized_urls = File.read(filepath)
  results = JSON.parse(serialized_urls)
  results
end

json_data = parse_json(filepath)
p json_data["urls"].values

