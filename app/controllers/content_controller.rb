class ContentController < ApplicationController
  before_action do
    allowed?(request.remote_ip)
  end

  def index
  end

  def pedalpal
  end

  def biovirtua
  end

  def epic
  end

  def massage
  end
end
