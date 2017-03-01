
graphite_version = File.read("./carbon-base/Dockerfile").scan(/ENV GRAPHITE_VERSION ([0-9\.]+)/m)[0][0]

## Builders
desc "Builds all docker images"
task :build => ["build:base", "build:cache", "build:web", "build:relay", "build:haproxy", "build:whisper"]

namespace :build do
  desc "Build the base image"
  task :base do
    sh "docker build -t registry.internal.logz.io:5000/carbon-base:#{graphite_version} carbon-base"
    sh "docker tag  registry.internal.logz.io:5000/carbon-base:#{graphite_version} registry.internal.logz.io:5000/carbon-base:latest"
  end

  desc "Build the cache image"
  task :cache do
    sh "docker build -t registry.internal.logz.io:5000/carbon-cache:#{graphite_version} carbon-cache"
    sh "docker tag  registry.internal.logz.io:5000/carbon-cache:#{graphite_version} registry.internal.logz.io:5000/carbon-cache:latest"
  end

  desc "Build the web image"
  task :web do
    sh "docker build -t registry.internal.logz.io:5000/graphite-web:#{graphite_version} web"
    sh "docker tag  registry.internal.logz.io:5000/graphite-web:#{graphite_version} registry.internal.logz.io:5000/graphite-web:latest"
  end

  desc "Build the relay image"
  task :relay do
    sh "docker build -t registry.internal.logz.io:5000/carbon-relay:#{graphite_version} carbon-relay"
    sh "docker tag  registry.internal.logz.io:5000/carbon-relay:#{graphite_version} registry.internal.logz.io:5000/carbon-relay:latest"
  end

  desc "Build haproxy proxy"
  task :haproxy do
    sh "docker build -t registry.internal.logz.io:5000/graphite-haproxy:#{graphite_version} haproxy"
    sh "docker tag  registry.internal.logz.io:5000/graphite-haproxy:#{graphite_version} registry.internal.logz.io:5000/graphite-haproxy:latest"
  end

  desc "Build the whisper image"
  task :whisper do
    sh "docker build -t registry.internal.logz.io:5000/whisper:#{graphite_version} whisper"
    sh "docker tag  registry.internal.logz.io:5000/whisper:#{graphite_version} registry.internal.logz.io:5000/whisper:latest"
  end

end

desc "Push all images to registry"
task :push do
  sh "docker push registry.internal.logz.io:5000/carbon-base:latest"
  sh "docker push registry.internal.logz.io:5000/carbon-cache:latest"
  sh "docker push registry.internal.logz.io:5000/carbon-relay:latest"
  sh "docker push registry.internal.logz.io:5000/graphite-web:latest"
  sh "docker push registry.internal.logz.io:5000/graphite-haproxy:latest"
  sh "docker push registry.internal.logz.io:5000/whisper:latest"
end

## testing

desc "Start up the containers, daemonized"
task :up do
  sh "docker-compose up -d"
end

desc "Kill the containers"
task :kill do
  sh "docker-compose kill"
  sh "docker-compose rm --force"
end

desc "Roll the containers"
task :roll do
  sh "docker-compose kill"
  sh "docker-compose rm --force"
  sh "docker-compose up -d"
end

desc "Write line data to carbon"
task :write_line_data do
  now = Time.now.to_i
  (1..1000000).step(50).each do |offset|
    stamp = now - offset
    sh %<echo "STAGING.local.test-1.value #{Random.rand(8)} #{stamp}" | nc -c graphite-staging.internal.logz.io 2003>
  end
end
