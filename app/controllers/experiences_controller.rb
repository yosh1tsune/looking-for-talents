class ExperiencesController < ApplicationController
  def create
    @profile = Profile.find(params[:profile_id])
    @experience = @profile.experiences.new(experience_params)
    respond_to do |format|
      if @experience.save
        format.html { redirect_to @profile }
        format.js { flash[:notice] = 'Experiência salva com sucesso!' }
        format.json do
          render json: @experience, status: :created,
                 location: @experience
        end
      else
        format.html { render 'profiles/show' }
        format.js { flash[:alert] = 'Corrija os erros!' }
        format.json do
          render json: @experience.errors,
                 status: :unprocessable_entity
        end
      end
    end
  end

  def experience_params
    params.require(:experience).permit(:company, :role, :start_date, :end_date,
                                       :currently_working, :resume)
  end
end
