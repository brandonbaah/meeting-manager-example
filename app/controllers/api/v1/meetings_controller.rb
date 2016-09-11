class Api::V1::MeetingsController < ApplicationController
  def index
    @meetings = Meeting.all
  end
end
