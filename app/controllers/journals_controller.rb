class JournalsController < ApplicationController
  before_action :require_login

  def new
    @journal = Journal.new
  end

  def create
    @journal = Journal.new(title: params[:journal][:title], user_id: params[:user_id].to_i)
    if @journal.save
     redirect_to user_journals_path, notice: "The #{@journal.title} Journal has been created."
    else
      flash.alert = "Please fix the errors below to continue."
      render :new
    end
  end

  def index
    @user = current_user
    if params[:sort].present?
      @journals = @user.journals.unscoped.all.order(params[:sort]).where(user_id: current_user.id)
    else
      ## default_scope set to title
      @journals = @user.journals.all
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
      redirect_to user_journals_path
    else
      flash.alert = "Please fix the errors below to continue."
      render :edit
    end
  end

  def destroy
    @journal = Journal.find(params[:id])
    @journal.destroy
    redirect_to user_journals_path, notice: "#{@journal.title} Journal has been deleted."
  end

  protected
  def journal_params
    params.require(:journal).permit(:title)
  end
end
