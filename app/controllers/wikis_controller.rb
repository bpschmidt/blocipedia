
class WikisController < ApplicationController
  def new
    @wiki = Wiki.new
  end

  def create
    @wiki = wiki.new(wiki_params)

    if @wiki.save
      @wiki.labels = Label.update_labels(params[:wiki][:labels])
      redirect_to @wiki, notice: "wiki was saved successfully."
    else
      flash[:error] = "Error creating wiki. Please try again."
      render :new
    end
  end
end
