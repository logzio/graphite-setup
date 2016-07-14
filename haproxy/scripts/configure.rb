#!/usr/bin/env ruby

require 'ostruct'
require 'optparse'
require 'fileutils'
require 'pathname'
require 'time'
require 'json'
require 'erb'

# Load and .erb file
def load_template(template_path)
    if ! File.exist?(template_path)
        return nil
    end

    return File.read(template_path)
end

# Write the config 
def create_conf(output_file, template_file, options)
    File.open("#{output_file}", 'w+') do |f|
		f.write(ERB.new(template_file).result(OpenStruct.new(options).instance_eval { binding }))
    end
end

def main(options)
    template_path = "/root/templates/haproxy.cfg.erb"

    # Load the .erb file
    template = load_template(template_path)

    # Create the .conf file
    create_conf('/usr/local/etc/haproxy/haproxy.cfg', template, options)
end

options = {}

options['pickle_relay_listeners'] = ENV['PICKLE_RELAY_LISTENERS'].split(',')
options['line_relay_listeners'] = ENV['LINE_RELAY_LISTENERS'].split(',')

main(options)

