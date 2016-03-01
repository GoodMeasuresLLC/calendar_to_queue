# encoding: utf-8

class CalendarToQueue::Configuration

  # Module that will handle authentication to access queue-admin area
  attr_accessor :admin_auth

  # Module that will handle authorization against admin queue resources
  attr_accessor :admin_authorization

  # AWS access_key for sending pushes to AWS SQS
  # defaults to ENV['AWS_ACCESS_KEY_ID']
  attr_accessor :aws_access_key_id

  # AWS secret access key for sending pushes to AWS SQS
  # defaults to ENV['AWS_SECRET_ACCESS_KEY']
  attr_accessor :aws_secret_access_key

  # AWS Region
  #
  # Note: if you create an Amazon EC2 instance or an Amazon SQS queue in one region, the instance
  # or queue is independent from instances or queues in another region.
  #
  # https://docs.aws.amazon.com/general/latest/gr/rande.html
  #
  # defaults to us-east-1
  attr_accessor :aws_region

  # Configuration defaults
  def initialize
    @admin_auth            = 'CalendarToQueue::AccessControl::AdminAuthentication'
    @admin_authorization   = 'CalendarToQueue::AccessControl::AdminAuthorization'
    @aws_access_key_id     = ENV['AWS_ACCESS_KEY_ID']
    @aws_secret_access_key = ENV['AWS_SECRET_ACCESS_KEY']
    @aws_region            = 'us-east-1'
  end

end
