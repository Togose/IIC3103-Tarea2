class CommentsController < ApplicationController
  include CommentsHelper
  before_action :define_header

  def index

    if @entry = Entry.GetWithId(params[:entry_id])
      @comments = Comment.GetWithEntryId(params[:entry_id])
      #output = {:comments => @comments}
      render json: @comments
    else
      output = {:error => "Not Found"}
      render json: output, status: 404
    end

  end

  def show
    if @entry = Entry.GetWithId(params[:news_id])
      if @comment = Comment.GetWithId(params[:id])
        render json: @comment
      else
        output = {:error => "Not Found"}
        render json: output, status: 404
      end
    else
      output = {:error => "Not Found"}
      render json: output, status: 404
    end
  end

  #def new
    #@comment = Comment.new
  #end

  def create
    author = params[:author]
    body = params[:comment]
    @entry = Entry.GetWithId(params[:entry_id])
    if @comment = Comment.create(comment_params)
      #@comment = Comment.GetWithId(@comment.id)
      @comment.entry_id = params[:entry_id]
      render json: @comment, status: 201
    else
      output = {:error => "Creation has failed"}
      render json: output, status: 500
    end
  end

  def destroy
    if @entry = Entry.GetWithId(params[:news_id])
      if @comment = Comment.GetWithId(params[:id])
        @comment.destroy
        render status: 204
      else
        output = {:error => "Not Found"}
        render json: output, status: 404
      end
    else
      output = {:error => "Not Found"}
      render json: output, status: 404
    end
  end

  #def edit
  #  @comment = Comment.find(params[:id])
  #end

  def update
    if request.request_parameters.key?("id")
      output = {:error => "Bad Request: Id it's not editable"}
      render json: output, status: 400
    elsif request.request_parameters.key?("created_at")
      output = {:error => "Bad Request: Creation Time it's not editable"}
      render json: output, status: 400
    else
      id = params[:id]
      news_id = params[:news_id]
      if @entry = Entry.GetWithId(news_id)
        if @comment = Comment.GetWithId(id)
          if @comment.update(comment_params)
            render json: @comment
          else
            output = {:error => "Modification has failed"}
            render json: output, status: 500
          end
        else
          output = {:error => "Not Found"}
          render json: output, status: 404
        end
      else
        output = {:error => "Not Found"}
        render json: output, status: 404
      end
    end
  end

  private

    def define_header
      response.headers["Content-Type"] = "application/json"
    end

    def comment_params
      params.permit(:author, :comment)
    end

end
