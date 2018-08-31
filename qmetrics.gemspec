lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'qmetrics/version'

Gem::Specification.new do |spec|
  spec.name          = 'qmetrics'
  spec.version       = Qmetrics::VERSION
  spec.authors       = ['Guilherme Casimiro']
  spec.email         = ['guircasimiro@gmail.com']
  # rubocop:disable Metrics/LineLength
  spec.summary       = 'Catch and send your rails metrics to your influx database.'
  spec.description   = 'Catch and send your rails metrics to your influx database.'
  # rubocop:enable Metrics/LineLength
  spec.homepage      = 'https://github.com/chiligumdev/qmetrics'
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
end
