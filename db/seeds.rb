require 'rexml/document'
SEEDS_ROOT = Rails.root / 'db' / 'seeds'

# Currencies list source: http://www.currency-iso.org/en/home/tables/table-a1.html

ids = Currency.ids
doc = REXML::Document.new SEEDS_ROOT.join('currencies.xml').read

REXML::XPath.match(doc, '/*/*/CcyNtry[Ccy]').each do |entry|
  id = entry.elements['Ccy'].text
  name_element = entry.elements['CcyNm']
  next if ids.include? id or name_element.attributes['IsFund']
  Currency.create! id: id, name: name_element.text
  ids << id
end
