class CommentsController < ApplicationController
  def create
    @article = Article.find(params[:article_id])
    @comment = @article.comments.build(comment_params)

    respond_to do |format|
      if @comment.save
        format.turbo_stream
        format.html { redirect_to @article, notice: "Comment was successfully added." }
      else
        format.html { redirect_to @article, alert: "Error adding comment." }
      end
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end
end
