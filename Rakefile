require 'bundler/gem_tasks'
require 'rake/testtask'

namespace :spec do
  Rake::TestTask.new(:unit) do |t|
    t.libs << 'spec'
    t.libs << 'lib'
    t.test_files = FileList['spec/unit/*_spec.rb']
  end

  Rake::TestTask.new(:bench) do |t|
    t.libs << 'spec'
    t.libs << 'lib'
    t.test_files = FileList['spec/bench/*_bench.rb']
  end
end

task :default => :'spec:unit'
