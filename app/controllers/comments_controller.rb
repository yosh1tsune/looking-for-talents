class CommentsController < ApplicationController
  def create
    pp params
    @profile = Profile.find(params[:profile_id])
    @comment = @profile.comments.new(headhunter: current_headhunter,
                                     comment: comment_params[:comment])

    if @comment.save
      flash[:notice] = 'Comentário enviado!'
      redirect_to @profile
    else
      flash[:alert] = 'Comentário não pode ser nulo!'
      redirect_to @profile
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:headhunter_id, :profile_id,
                                     :comment)
  end
end