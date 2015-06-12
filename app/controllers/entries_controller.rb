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
    logger.info("EDIT A ENTRY")
     @entry = Entry.find(params[:id]) 
  end

  def update
    @entry = Entry.find(params[:id])
    @entry.assign_attributes(entry_params)
    if @entry.save
      flash.notice = "#{@entry.title} Entry was updated successfully"
      redirect_to journal_entries_path
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
    logger.info("MADE IT INTO THE INDEX CONTROLLER FOR AN ENTRY!!!!!!!!!!!!*********")
    logger.info("PARAMS ARE" + params.to_s)
    @journal = Journal.find(params[:journal_id])
    @entries = @journal.entries.all
  end

  def create
    # Load entry
    logger.info("THE PARAMS CREATE GETS ... " + params.to_s)
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
