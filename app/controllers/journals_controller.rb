class JournalsController < ApplicationController
  before_action :require_login

  def new
    @journal = Journal.new
  end

  def create
    @journal = Journal.new(journal_params)
    if @journal.save
      redirect_to journals_path, notice: "The #{@journal.title} Journal has been created."
    else
      flash.alert = "Please fix the errors below to continue."
      render :new
    end
  end

  def index
    if params[:sort].present?
      @journals = Journal.unscoped.order(params[:sort]).all
    else
      # default_scope set to title
      @journals = Journal.all
    end
  end

  def edit
    @journal = Journal.find(params[:id])
  end
  
  def update
    @journal = Journal.find(params[:id])
    @journal.assign_attributes(journal_params)
    if @journal.save
      flash.notice = "#{@journal.title} Journal was updated successfully"
      redirect_to journals_path
    else
      flash.alert = "Please fix the errors below to continue."
      render :edit
    end
  end

  protected
  def journal_params
    params.require(:journal).permit(:title)
  end
end
