class OpportunitiesController < ApplicationController
  before_action :authenticate_headhunter!, only: %i[new create]

  def index
    @opportunities = policy_scope(Opportunity)
    authorize Opportunity
  end

  def show
    @opportunity = policy_scope(Opportunity).find(params[:id])
    authorize @opportunity
    @subscription = Subscription.new
  end

  def new
    @opportunity = Opportunity.new
    authorize @opportunity
  end

  def create
    @opportunity = Opportunities::CreatorService.new(user: current_headhunter, attributes: opportunity_params).execute
    flash[:notice] = 'Vaga publicada com sucesso!'
    redirect_to @opportunity
  rescue ActiveRecord::RecordInvalid => e
    @opportunity = e.record
    render :new
  end

  def close
    @opportunity = Opportunities::CloserService.new(user: current_headhunter, opportunity_id: params[:id]).execute
    flash[:notice] = 'Inscrições encerradas com sucesso.'
    redirect_to @opportunity
  end

  def search
    query = 'lower(title) LIKE ? OR lower(required_abilities) LIKE ?',
            "%#{params[:query].downcase}%", "%#{params[:query].downcase}%"

    @opportunities = policy_scope(Opportunity).where(query)

    render :index
  end

  private

  def opportunity_params
    params.require(:opportunity).permit(:title, :work_description, :required_abilities, :salary, :grade,
                                        :submit_end_date, :company_id)
  end
end
