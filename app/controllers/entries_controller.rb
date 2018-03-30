class EntriesController < ApplicationController
  before_action :authenticate_user!
  include EntriesHelper

  def index
    @entries = Entry.order(created_at: :desc).limit(10)
    @entries.each do |entry|
      if entry.body.length >= 500
        #find last space
        last_space = entry.body[0..500].rindex(' ') - 1
        entry.body = entry.body[0..last_space] + '...'
      end

  end
  end

  def show
    @entry = Entry.find(params[:id])
    @comment = Comment.new
    @comment.entry_id = @entry.id
  end

  def new
    @entry = Entry.new
  end

  def create
    @entry = Entry.new(entry_params)
    if @entry.save
      redirect_to entry_path(@entry)
    else
      render 'new'
    end
  end

  def destroy
    @entry = Entry.find(params[:id])
    @entry.destroy
    redirect_to entries_path
  end

  def edit
    @entry = Entry.find(params[:id])
  end

  def update
    @entry = Entry.find(params[:id])
    if @entry.update(entry_params)
      redirect_to entries_path(@entry)
      flash.notice = "Noticia '#{@entry.title}' fue actualizada con exito!"
    else
      render 'edit'
    end
  end

end
