#!/usr/bin/env ruby

require 'optparse'

action = nil
type = nil
number = nil
pharo_image = './Pharo.image'
docker_image = 'pharo-vnc-supervisor'
server_port = 8080
server_host = 'localhost'

OptionParser.new do |opt|
    opt.on('--create-server VALUE',   'Create a Vert.x server on the given port.')           { |v| action = :create_server; server_port = v }
    opt.on('--remove-server VALUE',   'Removes the server on the given port.')           { |v| action = :remove_server; server_port = v }
    opt.on('--create-consumer',       'Create a consumer.')                  { |v| action = :create; type = :consumer }
    opt.on('--create-producer',       'Create a producer.')                  { |v| action = :create; type = :producer }
    opt.on('--remove-consumer VALUE', 'Remove a consumer.')                  { |v| action = :remove; type = :consumer; number = v }
    opt.on('--remove-producer VALUE', 'Remove a producer.')                  { |v| action = :remove; type = :producer; number = v }
    opt.on('--remove-all',            'Remove all consumers and producers.') { |v| action = :remove_all }
    opt.on('--list-all',              'List all consumers and producers.')   { |v| action = :list_all }
    opt.on('--pharo-image VALUE',     'Specify Pharo image.')                { |v| pharo_image = v }
    opt.on('--server-port VALUE', Integer, 'Specify Vert.x server port.')    { |v| server_port = v }
    opt.on('--server-host VALUE',     'Specify Vert.x server host.')         { |v| server_host = v }
    opt.on('-h', '--help',            'Show help message.')                  { |v| puts opt; abort }
    begin
        opt.parse(ARGV)
    rescue OptionParser::InvalidOption
        puts opt
        abort
    end
end

def execute(command)
    #puts command
    system command
end

images_prefixes = "teamtalk"
type_prefix = type.to_s
pharo_image = File.absolute_path(pharo_image)
pharo_changes = pharo_image.gsub(".image", ".changes")

pharo_temp_images_directory = File.absolute_path(".")

case action

when :list_all
    execute "docker ps --format '{{.Names}}' | grep '#{images_prefixes}'"

when :remove_all
    execute "docker rm -f $(docker ps --format '{{.Names}}' | grep '#{images_prefixes}')"

when :create_server
    server_image_name = "teamtalk-server-#{server_port}"
    execute "(docker rm -f #{server_image_name} || true) && docker run -d -p #{server_port}:8080 --name #{server_image_name} plequen/teamtalk-server"

when :remove_server
    server_image_name = "teamtalk-server-#{server_port}"
    execute "docker rm -f #{server_image_name}"

when :remove
    execute "docker rm -f $(docker ps --format '{{.Names}}' | grep '#{images_prefixes}-#{type_prefix}-#{number}')"

when :create

    current_containers = (`docker ps --format '{{.Names}}' | grep '#{images_prefixes}-#{type_prefix}-'`).strip.split('\n')
    highest_number = 0
    current_containers.each do |container_name|
        container_number = (container_name.gsub("#{images_prefixes}-#{type_prefix}-", "")).to_i
        highest_number = [ container_number, highest_number ].max
    end
    number = highest_number + 1

    vnc_port = 5900 + (type == :consumer ? 200 : 100) + number
    vnc_browser_port = 6900 + (type == :consumer ? 200 : 100) + number
    image_name = "#{images_prefixes}-#{type_prefix}-#{number}"

    pharo_image_name = "#{image_name}.image"
    pharo_changes_name = "#{image_name}.changes"

    execute "(rm -rf #{pharo_image_name} || true) && (rm -rf #{pharo_changes_name} || true) && cp #{pharo_image} ./#{pharo_image_name} && cp #{pharo_changes} ./#{pharo_changes_name}"

    command = [
        "(docker rm -f #{image_name} || true) &&",
        "docker run --name #{image_name}",
        "-d",
        "-p #{vnc_port}:5901",
        "-p #{vnc_browser_port}:6901",
        "-v #{pharo_temp_images_directory}:/root/data",
        "-e PHARO_IMAGE=#{pharo_image_name}",
        (type == :consumer ? "-e PHARO_START_SCRIPT=\"TTWorker host: '#{server_host}' port: #{server_port}\"" : ""),
        docker_image
    ].join(" ")

    execute command

    puts "Started #{type} number #{number} (VNC: #{vnc_port}, VNC browser: #{vnc_browser_port})"

end