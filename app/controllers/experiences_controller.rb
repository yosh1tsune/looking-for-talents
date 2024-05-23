class ExperiencesController < ApplicationController
  def create
    @profile = Profile.find(params[:profile_id])
    @experience = @profile.experiences.new(experience_params)
    if @experience.save
      success_render
    else
      failure_render
    end
  end

  private

  def success_render
    respond_to do |format|
      format.html { redirect_to @profile }
      format.js { flash[:notice] = 'Experiência salva com sucesso!' }
      format.json do
        render json: @experience, status: :created, location: @experience
      end
    end
  end

  def failure_render
    respond_to do |format|
      format.html { render 'profiles/show' }
      format.js { flash[:alert] = 'Corrija os erros!' }
      format.json do
        render json: @experience.errors, status: :unprocessable_entity
      end
    end
  end

  def experience_params
    params.require(:experience).permit(:company, :role, :start_date, :end_date, :currently_working, :resume)
  end
end
