lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rmetrics/version'

Gem::Specification.new do |spec|
  spec.name          = 'rmetrics'
  spec.version       = Rmetrics::VERSION
  spec.authors       = ['Guilherme Casimiro']
  spec.email         = ['guircasimiro@gmail.com']
  # rubocop:disable Metrics/LineLength
  spec.summary       = 'Catch and send your rails metrics to your influx database.'
  spec.description   = 'Catch and send your rails metrics to your influx database.'
  # rubocop:enable Metrics/LineLength
  spec.homepage      = 'https://github.com/chiligumdev/rmetrics'
  spec.license       = 'MIT'

  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = 'https://rubygems.org'
  else
    raise 'RubyGems 2.0 or newer is required to protect against ' \
      'public gem pushes.'
  end

  spec.files = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'coveralls', '~> 0.7'
  spec.add_development_dependency 'minitest', '~> 5.11'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_dependency 'activesupport', '~> 5.1'
  spec.add_dependency 'influxdb', '~> 0.6.0'
end
