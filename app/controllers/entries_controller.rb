class EntriesController < ApplicationController
  before_action :define_header
  include EntriesHelper

  def index
    @entries = Entry.GetAll
    @entries.each do |entry|
      entry.cut
    end
    output = @entries
    render json: output
  end

  def show
    begin
      @entry = Entry.find(params[:id])
      render json: @entry
    rescue ActiveRecord::RecordNotFound
      output = {:error => "Not found"}
      render json: output, status: 404
    end
  end

  def create

    id = params[:id]

    if id
      output = {:error => "Can't create an entry with that id"}
    else
      if @entry = Entry.create(entry_params)
        response.headers["Location"] = "news/#{@entry.id}"
        render json: @entry, status: 201
      else
        output = {:error => "Creation has failed"}
        render json: output, status: 500
      end
    end
  end

  def destroy
    begin
      @entry = Entry.find(params[:id])
      @entry.destroy
      render json: @entry, status: 200
    rescue ActiveRecord::RecordNotFound
      output = {:error => "Not found"}
      render json: output, status: 404
    end
  end

  def update
    begin
      @entry = Entry.find(params[:id])
      if @entry.update(entry_params)
        render json: @entry
      else
        output = {:error => "Modification has failed"}
        render json: output, status: 500
      end
    rescue ActiveRecord::RecordNotFound
      output = {:error => "Not found"}
      render json: output, status: 404
    end
    #end
  end

  private

    def define_header
      response.headers["Content-Type"] = "application/json"
    end

    def entry_params
      params.permit(:title, :subtitle, :body)
    end

end
