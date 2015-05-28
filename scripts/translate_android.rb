require 'spreadsheet'
require 'rexml/document'

# Read English words from excel sheet
words = Hash.new
sheet = Spreadsheet.open('translations.xls').worksheet('Android')
sheet.each do |row|
  next if row.size < 2
  words[row[0]] = row[1]
end

document = REXML::Document.new File.new('string.xml')
REXML::XPath.each(document, '//string') do |element|
  translated_text = words[element.text] || element.text
  element.text = translated_text.include?('<') ? REXML::CData.new(translated_text) : translated_text
end
REXML::XPath.each(document, '//item') do |element|
  translated_text = words[element.text] || element.text
  element.text = translated_text.include?('<') ? REXML::CData.new(translated_text) : translated_text
end
document.write(File.open('string-ch.xml', 'w'))