# A sample Guardfile
# More info at https://github.com/guard/guard#readme

# Uncomment and set this to only include directories you want to watch
directories %w(spec spec/features lib bin)

# Uncomment to clear the screen before every task
clearing :on

## Guard internally checks for changes in the Guardfile and exits.
## If you want Guard to automatically start up again, run guard in a
## shell loop, e.g.:
##
##  $ while bundle exec guard; do echo 'Restarting Guard...'; done
##

group :red_green_refactor do
  guard :rspec, cmd: 'bundle exec rspec' do
    require 'guard/rspec/dsl'
    dsl = Guard::RSpec::Dsl.new(self)

    # RSpec files
    rspec = dsl.rspec
    watch(rspec.spec_helper) { rspec.spec_dir }
    watch(rspec.spec_support) { rspec.spec_dir }
    watch(rspec.spec_files)

    # Ruby files
    ruby = dsl.ruby
    dsl.watch_spec_files_for(ruby.lib_files)

    ## Turnip features and steps
    # watch(%r{^spec/acceptance/(.+)\.feature$})
    # watch(%r{^spec/acceptance/steps/(.+)_steps\.rb$}) do |m|
    #   Dir[File.join('**/#{m[1]}.feature')][0] || "spec/acceptance"
    # end
  end

  guard :rubocop do
    watch(/.+\.rb$/)
    watch(%r{(?:.+/)?\.rubocop\.yml$}) { |m| File.dirname(m[0]) }
  end
end
