class OpportunitiesController < ApplicationController
  before_action :authenticate_headhunter!, only: %i[new create]
  before_action :registered?, only: %i[show]

  def index
    if headhunter_signed_in?
      headhunter = current_headhunter
      @opportunities = headhunter.opportunities
    else
      @opportunities = Opportunity.all
    end
  end

  def show
    @opportunity = Opportunity.find(params[:id])
    @subscription = Subscription.new
  end

  def new
    @opportunity = Opportunity.new
  end

  def create
    @opportunity = current_headhunter.opportunities.new(opportunity_params)
    if @opportunity.save
      flash[:notice] = 'Vaga publicada com sucesso!'
      redirect_to @opportunity
    else
      render :new
    end
  end

  def close
    @opportunity = Opportunity.find(params[:id])
    @opportunity.closed!

    redirect_to @opportunity

    flash[:notice] = 'Inscrições encerradas com sucesso.'
  end

  def search
    @opportunities = Opportunity.where('title LIKE ? OR '\
                                       'required_abilities LIKE ?',
                                       "%#{params[:q]}%", "%#{params[:q]}%")

    render :index
  end

  private

  def registered?
    return unless candidate_signed_in?

    @registered = Subscription.find_by(candidate_id: current_candidate.id)
  end

  def opportunity_params
    params.require(:opportunity).permit(:title, :work_description,
                                        :required_abilities, :salary, :grade,
                                        :submit_end_date, :company_id)
  end
end
