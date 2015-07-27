require 'simplecov'
require 'simplecov-vim/formatter'

SimpleCov.start do
  SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter[
    SimpleCov::Formatter::VimFormatter,
    SimpleCov::Formatter::HTMLFormatter
  ]

  if ENV['CI']=='true'
    require 'codecov'
    SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter[
      SimpleCov::Formatter::Codecov,
      SimpleCov::Formatter::VimFormatter,
      SimpleCov::Formatter::HtmlFormatter
    ]
  end
end

$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'locus'

require 'minitest/autorun'
require 'minitest/reporters'
require 'shoulda-context'
require 'mocha/setup'
require 'faraday'

Minitest::Reporters.use! [Minitest::Reporters::ProgressReporter.new(:color => true)]
