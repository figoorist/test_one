class SendMessageJob < ActiveJob::Base
  queue_as :default

  # учет вероятности неудачных попыток доставки сообщений конечному получателю; 
  retry_on StandardError

  def perform(*args)
    # Do something later
    puts "Sent " + "#{args[0]}" + " to " + "#{args[1].name}... OK"
  end
end
