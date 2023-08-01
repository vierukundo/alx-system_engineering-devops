#!/usr/bin/env ruby
puts ARGV[0].scan(/(?<=from:|to:|flags:)(\+?-?\d{1}:?-?\d{1}:?-?\d{1}:?-?\d{1}:?-?\d+|[a-zA-Z]+)/).join(",")
