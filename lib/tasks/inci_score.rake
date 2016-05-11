require_relative '../../lib/inci_score'

namespace :inci_score do
  task :compute do
    src = ENV.fetch('src') { fail ArgumentError, 'please specify the "src" argument'}
    puts InciScore::Computer::new(src: src).call
  end
end
