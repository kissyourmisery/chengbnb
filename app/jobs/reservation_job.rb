class ReservationJob < ActiveJob::Base
  queue_as :default

  def perform(*args)
    # Do something later
    # this file is redundant as of now since action mailer is now linked to active job, so in the reservation_mailer.rb, just need to write '.deliver_later'

    # https://github.com/mperham/sidekiq/wiki/Active-Job how to configure to integrate action mailer and active job

    # but I need files under the 'job' folder when I need to perform non-urgent tasks in the background other than emails

    # https://learn.nextacademy.com/topics/32/challenges/pairbnb-advance-background-jobs-for-emails shows the non-integrative method when action mailer is not integrated with active job
  end
end
