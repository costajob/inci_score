require_relative '../../lib/inci_score'

namespace :inci do
  task :compute do
    src = ENV.fetch('src') { fail ArgumentError, 'please specify the "src" argument'}
    @res = InciScore::Computer::new(src: src).call
  end

  desc 'compute the inci score by reading an img: rake inci_score:compute src=sample/01.jpg'
  task :score => :compute do
    puts @res.score
  end

  desc 'fetch the inci components by reading an img: rake inci_score:compute src=sample/01.jpg'
  task :components => :compute do
    catalog = InciScore::Config::catalog
    puts @res.components.map { |component| "#{catalog[component]} - #{component}" }
  end
end
