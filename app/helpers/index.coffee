# Capitalize a string
# word => Word
# string => String
String::capitalize = () ->
    this.replace /(?:^|\s)\S/g, (a) -> a.toUpperCase()

# Classify a string
# model => Model
# some_name => SomeName
String::classify = (str) ->
  classified = []
  words = str.split('_')
  for word in words
    classified.push word.capitalize()

  classified.join('')
