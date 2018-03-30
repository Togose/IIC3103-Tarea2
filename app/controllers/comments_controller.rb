class CommentsController < ApplicationController
  include CommentsHelper

  def index
    @comments = Comment.all
  end

  def show
    @comment = Comment.find(params[:id])
  end

  def new
    @comment = Comment.new
  end

  def create
    @comment = Comment.new(comment_params)
    @comment.entry_id = params[:entry_id]
    @comment.save
    redirect_to entry_path(@comment.entry_id)
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    redirect_to comments_path
  end

  def edit
    @comment = Comment.find(params[:id])
  end

  def update
    @comment = Comment.find(params[:id])
    @comment.update(comment_params)

    redirect_to comments_path(@comment)
    flash.notice = "Noticia '#{@comment.titulo}' fue actualizada con exito!"
  end
end
