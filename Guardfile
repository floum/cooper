#!/usr/bin/env ruby

group :red_green_refactor, halt_on_fail: true do
  guard :rake, task: :default do
    watch %r{.+\.rb}
  end

  guard :rubocop, cli: ['-D'] do
    watch(%r{.+\.rb$})
    watch(%r{(?:.+/)?\.rubocop\.yml$}) { |m| File.dirname(m[0]) }
  end
end
