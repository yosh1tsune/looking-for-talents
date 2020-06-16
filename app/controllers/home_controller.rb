class HomeController < ApplicationController
  before_action :candidate_have_profile?, only: %i[index]

  def index; end

  private

  def candidate_have_profile?
    return unless candidate_signed_in?

    profile = Profile.find_by(candidate: current_candidate)
    return if profile.present?

    flash[:info] = 'Seu perfil está incompleto! Acesse a aba Perfil '\
                      'para preenche-lo!'
  end
end
