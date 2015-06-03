class JournalsController < ApplicationController

  def index
    if params[:sort].present?
      @journals = Journal.unscoped.order(params[:sort]).all
    else
      # default_scope set to title
      @journals = Journal.all
    end
  end
end
