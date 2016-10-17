require './station'
require 'wombat'
require 'active_support/core_ext'
# documents
class Luncher
  include Celluloid
  trap_exit :recover

  def start
    Dir['./parser/**/*.rb'].each { |p| require p }
    schedule = Engine::Schedule.new
    cache = Engine::Cache.new
    # schedule.push Engine::ParseStruct.new(parser: 'organization_list', link: 'https://www.itjuzi.com/investfirm', namespace: 'itjuzi')
    parse = Engine::ParseStruct.new(parser: 'tech', link: 'http://t66y.com/thread0806.php?fid=7', namespace: 't66y')
    schedule.push parse
    10.times do |_index|
      supervisor = Engine::Producer.pool args: [schedule, cache]
      supervisor.async.start
    end
    sleep(1_000_000_000)
  end

  def recover(actor, reason)
    puts "#{actor}\n#{reason}"
  end
end

Luncher.new.start
