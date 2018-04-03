class EntriesController < ApplicationController
  #before_action :authenticate_user!
  before_action :define_entry
  before_action :define_header
  rescue_from ActiveRecord::RecordNotFound, :with => :not_found
  include EntriesHelper

  def index
    @entries = Entry.GetAll

    @entries.each do |entry|
      if entry.body.length >= 500
        last_space = entry.body[0..500].rindex(' ') - 1
        entry.body = entry.body[0..last_space]
      end
    end
    output = {:entries => @entries}
    render json: output
  end

  def show
    if @entry
      render json: @entry
    else
      output = {:error => "Not Found"}
      render json: output, status: 404
    end
  end

  def create

    id = params[:id]

    if id
      output = {:error => "Can't create an entry with that id"}
    else
      if @entry = Entry.create(entry_params)
        #@entry = Entry.GetWithId(@entry.id)
        #@comment = Comment.new(entry_id: @entry.id)
        render json: @entry, status: 201
      else
        output = {:error => "Creation has failed"}
        render json: output, status: 500
      end
    end
  end

  def destroy
    if @entry
      @entry.destroy
      render status: 200
    else
      output = {:error => "Not Found"}
      render json: output, status: 404
    end
  end

  def update
    if request.request_parameters.key?("id")
      output = {:error => "Bad Request: Id it's not editable"}
      render json: output, status: 400
    else
      if @entry
        if @entry.update(entry_params)
          render json: @entry
        else
          output = {:error => "Modification has failed"}
          render json: output, status: 500
        end
      else
        output = {:error => "Not Found"}
        render json: output, status: 404
      end
    end
  end

  private

    def define_entry
      @entry = Entry.find(params[:id])
    end

    def not_found(error)
      render json: {:error => "/^not found$/gi"}.to_json, :status => 404
    end

    def define_header
      response.headers["Content-Type"] = "application/json"
    end

    def entry_params
      params.permit(:title, :subtitle, :body, :created_at, :updated_at)
    end

end
