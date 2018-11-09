require 'singleton'
require 'yaml'

class EnvConfig
  include Singleton
  attr_reader :config
  attr_reader :environment

  def initialize
    config_yaml = File.join(Dir.pwd, 'config.yml')
    raise "config.yml could not be found" unless File.exist?(config_yaml)
    config_file = YAML.load(File.open(config_yaml))

    # Get the current config setting from the environment. It should be passed in from the command line eg. CONFIG=ci (see rakefile)
    # It will use default_config from config.yaml if nothing is passed in.
    @environment = ENV['CONFIG']

    if @environment.nil?
      @environment = config_file.fetch('defaults').fetch('default_config') # .fetch() will raise an error if the keys aren't found.
      abort "Exiting: No CONFIG supplied from command line, and no default_config found in config.yml" if @environment.nil?
    end

    # Load in data files from /features/support/data/*
    @test_data = {}

    puts "Loading test data YAML from data directory..."
    Dir[File.dirname(__FILE__) + '/../features/support/data/*.yml'].each do |f|
      data = YAML.load(File.open(f))
      @test_data.merge!(data)
      puts "Loaded #{f}"
    end

    # The environment-specific config and the test data are accessible as @config
    @config = config_file[@environment]
    @config['data'] = @test_data
  end

  # Allow calls like EnvConfig['some_key'].
  def self.[](key_name)
    instance.value_for(key_name)
  end

  # Allow calls like EnvConfig.some_key
  def self.method_missing(name, *args, &block)
    instance.config[name.to_s].nil? ? super : instance.config[name.to_s]
  end

  # Allow calls like EnvConfig.some_key
  def self.respond_to?(name)
    instance.config[name.to_s].nil? ? super : true
  end

  def value_for(key_name)
    raise "There is no key '#{key_name}' for the config '#{@environment}' in config.yml" if @config[key_name].nil?
    @config[key_name]
  end
end
