class EntriesController < ApplicationController
  before_action :require_login

  def new
    logger.info("INSIDE NEW")
    if params[:id].present?
      @entry = Entry.find(params[:id])
    else
      @entry = Entry.new
    end

    if params[:entry].present?
      @entry.assign_attributes(entry_params)
    end
  end

  def edit
     @entry = Entry.find(params[:id]) 
  end

  def show
    # Issue - when showing a single entry ... we do NOT have access to a journal ...
    @entry = Entry.find(params[:id])
  end

  def update
    @entry = Entry.find(params[:id])
    @entry.assign_attributes(entry_params)
    if @entry.save
      flash.notice = "#{@entry.title} Entry was updated successfully"
      redirect_to journal_entry_path
    else
      flash.alert = "Please fix the errors below to continue."
      render :edit
    end
  end

  def destroy
    @entry = Entry.find(params[:id])
    @entry.destroy
    redirect_to journal_entries_path, notice: "#{@entry.title} Entry has been deleted." 
  end

  def index
    logger.info("THE PARAMS IN INDEX ARE ..." + params.to_s)
    @journal = Journal.find(params[:journal_id])
    @entries = @journal.entries.all.page(params[:page]).per(6) #6 entries per page
    @date = params[:month] ? Date.strptime(params[:month], '%Y-%m') : Date.today  
  end

  def create
    if params[:id].present?
      @entry = Entry.find(params[:id])
    else
      @entry = Entry.new
    end

    if params[:entry].present?
      logger.info("ASSIGNING ATTRIBUTES")
      @entry.assign_attributes(entry_params)
    end
    # Goal create a new entry
    # Need a user, need a journal
    @entry.user = current_user
    @entry.journal = Journal.find(params[:journal_id])

    if @entry.save
      redirect_to journal_entries_path, notice: "Your entry has been published!"
    else
      flash.alert = "Your knowledge could not be published. Please correct the errors below."
      render :new
    end
  end

  private
    def entry_params
      params.require(:entry).permit(:title, :post, :image)
    end
end
