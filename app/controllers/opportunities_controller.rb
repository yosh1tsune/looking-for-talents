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
    @opportunity = current_headhunter.opportunities.new(opportunity_params)
    authorize @opportunity
    if @opportunity.save
      flash[:notice] = 'Vaga publicada com sucesso!'

      redirect_to @opportunity
    else
      render :new
    end
  end

  def close
    @opportunity = Opportunity.find(params[:id])
    authorize @opportunity
    @opportunity.closed!

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
