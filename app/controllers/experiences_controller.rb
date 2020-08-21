class ExperiencesController < ApplicationController
  def create
    @profile = Profile.find(params[:profile_id])
    @experience = @profile.experiences.new(experience_params)
    respond_to do |format|
      if @experience.save
        format.html { redirect_to @profile, notice: 'Experiência salva com '\
                                                    'sucesso!' }
        format.js
      else
        format.html { render 'profiles/show', alert: 'Corrija os erros!' }
      end
    end
  end

  def experience_params
    params.require(:experience).permit(:company, :role, :start_date, :end_date,
                                       :currently_working, :resume)
  end
end