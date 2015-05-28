require 'spreadsheet'

# Example: "vUq-aV-kvy.title" = "Cancel"; Return "vUq-aV-kvy.title", Cancel
def extract_key_value_from_line(line)
  line.gsub!(/;/, '')
  line_hash = line.split('=').map!{|x| x.strip.gsub!(/\"/, '')}
  return line_hash[0], line_hash[1]
end

def compress_formatted_key_value(key, value)
  '"' + key + '" = "' + value + '";'
end

# Read English words from excel sheet
words = Hash.new
sheet = Spreadsheet.open('translations.xls').worksheet('iOS')
sheet.each do |row|
  next if row.size < 2
  words[row[0]] = row[1]
end

# Read English resource file and convert to chinese version
chinese_resource_file = File.new('Main.strings(Chinese)', 'w')
strings = File.open('Main.strings').read
strings.each_line do |line|
  line.gsub!(/\n/, '') if line
  if !line || line.strip.length == 0 || line.start_with?('/*') && line.end_with?('*/')
    chinese_resource_file.puts line
    next
  end
  string_key, string_value = extract_key_value_from_line line
  chinese_resource_file.puts compress_formatted_key_value(string_key, words[string_value] || string_value)
end
chinese_resource_file.close

