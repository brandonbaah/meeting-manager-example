class MeetingsController < ApplicationController
  def index
    if params[:tag]
      @meetings = Tag.find_by(name: params[:tag]).meetings
    else
      @meetings = Meeting.all
    end
    render 'index.html.erb'
  end

  def show
    @meeting = Meeting.find_by(id: params[:id])
    render 'show.html.erb'
  end

  def new
    @meeting = Meeting.new(start_time: DateTime.now, end_time: DateTime.now)
    @tags = Tag.all
    render 'new.html.erb'
  end

  def create
    @meeting = Meeting.new(
      name: params[:name],
      address: params[:address],
      start_time: params[:start_time],
      end_time: params[:end_time],
      notes: params[:notes]
    )
    if @meeting.save
      params[:tag_ids].each do |tag_id|
      MeetingTag.create(meeting_id: @meeting.id, tag_id: tag_id)
    end
      flash[:success] = "Meeting was successfully saved!"
      redirect_to "/meetings"
    else
      @tags = Tag.all
      flash[:error] = "Sorry, the meeting couldn't be saved"
      render 'new.html.erb'
    end
  end

  def edit
    @meeting = Meeting.find_by(id: params[:id])
    @tags = Tag.all
    render 'edit.html.erb'
  end

  def update
    if @meeting = Meeting.update(
      name: params[:name],
      address: params[:address],
      start_time: params[:start_time],
      end_time: params[:end_time],
      notes: params[:notes]
    )
    @meeting.tags.destroy_all
    params[:tag_id].each do |tag_id|
      MeetingTag.create(meeting_id: @meeting.id, tag_id: tag_id)
    end
    flash[:success] = "Message updated"
    redirect_to "/meetings/#{@meeting.id}"
    else
      flash[:error] = "Message not updated"
    end
  end
end
