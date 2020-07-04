class CompaniesController < ApplicationController
  before_action :authenticate_headhunter!

  def index
    @companies = Company.all
  end

  def show
    @company = Company.find(params[:id])
  end

  def new
    @company = Company.new
    @company.addresses.build
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

  def link_headhunters
    @company = Company.find(params[:id])
    headhunter = Headhunter.find_by(email: params[:email])
    @servicing_headhunter = ServicingHeadhunter.new(company: @company,
                                                    headhunter: headhunter)
    if @servicing_headhunter.save
      flash[:notice] = 'Headhunter vinculado com sucesso!'
    else
      flash[:alert] = 'Insira um headhunter com email válido.'
    end
    redirect_to @company
  end

  private

  def company_params
    params.require(:company).permit(:name, :document, :description, :phone,
                                    :email, :logo,
                                    addresses_attributes:
                                      %i[id street neighborhood state city
                                         country zipcode])
  end
end
