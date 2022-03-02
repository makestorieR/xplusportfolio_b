class AnticipationCableJob < ApplicationJob
  queue_as :default

  def perform(*args)
    # Do something later

    @anticipation = Anticipation.find_by_id(args.first)

  
  end
end
