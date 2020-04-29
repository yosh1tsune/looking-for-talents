class CompaniesController < ApplicationController
  def index
    @companies = Company.all
  end

  def show
    @company = Company.find(params[:id])
  end

  def new
    @company = Company.new
  end

  def create
    @company = current_headhunter.companies.new(company_params)
    if @company.save
      flash[:notice] = 'Empresa cadastrada com sucesso!'
      redirect_to @company
    else
      render :new
    end
  end

  private

  def company_params
    params.require(:company).permit(:name, :document, :description, :phone,
                                    :email)
  end
end