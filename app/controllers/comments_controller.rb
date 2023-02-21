class CommentsController < ApplicationController
  before_action :comment, only: %i[ show edit update destroy ]
  before_action :project, except: %i[ destroy ]

  def index
    @comments = @project.activities
  end

  # GET /comments/new
  def new
    @comment = Comment.new
  end

  def edit
  end

  def create
    @comment = @project.comments.new(comment_params)
    @comment.user = current_user

    respond_to do |format|
      if @comment.save
        format.html { redirect_to project_comment_url(@project, @comment), notice: "Comment was successfully created." }
        format.turbo_stream do
          render(turbo_stream: turbo_stream.append(:comments, partial: 'comments/comment', locals: { comment: @comment }))
        end
      else
        render :new, status: :unprocessable_entity
      end
    end
  end

  def update
    respond_to do |format|
      if @comment.update(comment_params)
        redirect_to project_comment_url(@project, @comment), notice: "Comment was successfully updated."
      else
        render :edit, status: :unprocessable_entity
      end
    end
  end

  def destroy
    @comment.destroy

    respond_to do |format|
      redirect_to comments_url, notice: "Comment was successfully destroyed."
    end
  end

private

  def comment
    @comment = Comment.find(params[:id])
  end

  def project
    @project = Project.find(params[:project_id])
  end

  def comment_params
    params.require(:comment).permit(:body)
  end
end
