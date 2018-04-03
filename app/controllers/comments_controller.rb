class CommentsController < ApplicationController
  include CommentsHelper
  before_action :define_header
  rescue_from ActiveRecord::RecordNotFound, :with => :not_found

  def index
    @entry = Entry.find(params[:entry_id])
    if @entry
      @comments = Comment.GetWithEntryId(params[:entry_id])
      render json: @comments
    else
      output = {:error => "Not Found Entry"}
      render json: output, status: 404
    end
  end

  def show
    @entry = Entry.find(params[:entry_id])
    if @entry
      @comment = Comment.find(params[:id])
      if @comment
        render json: @comment
      else
        output = {:error => "Not Found Comment"}
        render json: output, status: 404
      end
    else
      output = {:error => "Not Found Entry"}
      render json: output, status: 404
    end
  end

  def create
    author = params[:author]
    body = params[:comment]
    @entry = Entry.find(params[:entry_id])
    if @comment = @entry.comments.create(comment_params)
      render json: @comment, status: 201
    else
      output = {:error => "Creation has failed"}
      render json: output, status: 500
    end
  end

  def destroy
    @entry = Entry.find(params[:entry_id])
    if @entry
      @comment = Comment.find(params[:id])
      if @comment
        @comment.destroy
        render status: 204
      else
        output = {:error => "Not Found Comment"}
        render json: output, status: 404
      end
    else
      output = {:error => "Not Found Entry"}
      render json: output, status: 404
    end
  end

  def update
    if request.request_parameters.key?("id")
      output = {:error => "Bad Request: Id it's not editable"}
      render json: output, status: 400
    elsif request.request_parameters.key?("created_at")
      output = {:error => "Bad Request: Creation Time it's not editable"}
      render json: output, status: 400
    else
      @entry = Entry.find(params[:entry_id])
      if @entry
        @comment = Comment.find(params[:id])
        if @comment
          if @comment.update(comment_params)
            render json: @comment
          else
            output = {:error => "Modification has failed"}
            render json: output, status: 500
          end
        else
          output = {:error => "Not Found Comment"}
          render json: output, status: 404
        end
      else
        output = {:error => "Not Found Entry"}
        render json: output, status: 404
      end
    end
  end

  private

    def not_found(error)
      render json: {:error => "Not Found"}.to_json, :status => 404
    end

    def define_header
      response.headers["Content-Type"] = "application/json"
    end

    def comment_params
      params.permit(:author, :comment)
    end

end
