class ProfilesController < ApplicationController
  before_action :authenticate_candidate!, only: %i[new create edit update]

  def index
    if candidate_signed_in?
      @profile = Profile.find_by(candidate_id: current_candidate.id)
      if @profile.nil?
        redirect_to new_profile_path
      else
        redirect_to @profile
      end
    elsif headhunter_signed_in?
      @profiles = Profile.all
    end
  end

  def show
    if headhunter_signed_in?
      @profile = Profile.find(params[:id])
    elsif candidate_signed_in?
      @profile = Profile.find_by(candidate_id: current_candidate.id)
    end
    @comment = Comment.new
    @experience = Experience.new
  end

  def new
    @profile = Profile.new
    @profile.addresses.build
  end

  def edit
    @profile = Profile.find(params[:id])
  end

  def create
    @profile = Profile.new(profile_params)
    @profile.candidate = current_candidate
    if @profile.save
      flash[:notice] = 'Perfil atualizado com sucesso!'
      redirect_to @profile
    else
      render :new
    end
  end

  def update
    @profile = Profile.find(params[:id])
    if @profile.update(profile_params)
      flash[:notice] = 'Perfil atualizado com sucesso!'
      redirect_to @profile
    else
      render :edit
    end
  end

  private

  def profile_params
    params.require(:profile).permit(:name, :birth_date, :document,
                                    :professional_resume, :scholarity,
                                    :candidate_id, :avatar,
                                    addresses_attributes:
                                      %i[id street neighborhood state city
                                         country zipcode])
  end
end
