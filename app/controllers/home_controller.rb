class HomeController < ApplicationController
  before_action :candidate_have_profile?, only: %i[index]

  def index; end

  private

  def candidate_have_profile?
    if candidate_signed_in?
      profile = Profile.find_by(candidate: current_candidate)
      if profile.blank?
        if flash[:notice].blank?
          flash[:notice] = "Seu perfil está incompleto! Acesse a aba 'Perfil' "\
                          'para preenche-lo!'
        else
          flash[:notice] << "Seu perfil está incompleto! Acesse a aba 'Perfil' "\
                          'para preenche-lo!'          
        end
      end
    end
  end
end
