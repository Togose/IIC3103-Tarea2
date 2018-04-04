class CommentsController < ApplicationController
  include CommentsHelper
  before_action :define_header

  def index
    begin
      @entry = Entry.find(params[:entry_id])
      @comments = Comment.GetWithEntryId(params[:entry_id])
      render json: @comments
    rescue ActiveRecord::RecordNotFound
      output = {:error => "Not found"}
      render json: output, status: 404
    end
  end

  def show
    begin
      @entry = Entry.find(params[:entry_id])
        begin
          @comment = Comment.find(params[:id])
          ender json: @comment
        rescue ActiveRecord::RecordNotFound
          output = {:error => "Not found"}
          render json: output, status: 404
        end
    rescue ActiveRecord::RecordNotFound
      output = {:error => "Not found"}
      render json: output, status: 404
    end
  end

  def create
    author = params[:author]
    body = params[:comment]
    begin
      @entry = Entry.find(params[:entry_id])
      if @comment = @entry.comments.create(comment_params)
        response.headers["Location"] = "/news/#{@entry.id}/comments/#{@comment.id}"
        render json: @comment, status: 201
      else
        output = {:error => "Creation has failed"}
        render json: output, status: 500
      end
    rescue ActiveRecord::RecordNotFound
      output = {:error => "Not found"}
      render json: output, status: 404
    end
  end

  def destroy
    begin
      @entry = Entry.find(params[:entry_id])
      begin
        @comment = Comment.find(params[:id])
        @comment.destroy
        render json: @comment, status: 200
      rescue ActiveRecord::RecordNotFound
        output = {:error => "Not found"}
        render json: output, status: 404
      end
    rescue ActiveRecord::RecordNotFound
      output = {:error => "Not found"}
      render json: output, status: 404
    end
  end

  def update
    begin
      @entry = Entry.find(params[:entry_id])
      begin
        @comment = Comment.find(params[:id])
        if @comment.update(comment_params)
          render json: @comment
        else
          output = {:error => "Modification has failed"}
          render json: output, status: 500
        end
      rescue ActiveRecord::RecordNotFound
        output = {:error => "Not found"}
        render json: output, status: 404
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

    def comment_params
      params.permit(:author, :comment)
    end

end
