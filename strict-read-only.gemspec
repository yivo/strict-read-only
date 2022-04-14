# encoding: UTF-8
# frozen_string_literal: true

Gem::Specification.new do |s|
  s.name                  = "strict-read-only"
  s.version               = "1.0.1"
  s.author                = "Yaroslav Konoplov"
  s.email                 = "eahome00@gmail.com"
  s.summary               = "A strict replacement for attr_readonly in Rails."
  s.description           = "A strict replacement for attr_readonly in Rails."
  s.homepage              = "https://github.com/yivo/strict-read-only"
  s.license               = "GNU AGPLv3"
  s.files                 = `git ls-files -z`.split("\x0")
  s.test_files            = `git ls-files -z -- {test,spec,features}/*`.split("\x0")
  s.require_paths         = ["lib"]

  s.add_dependency "activesupport", ">= 3.0", "< 6.0"
  s.add_dependency "activerecord",  ">= 3.0", "< 6.0"
end
