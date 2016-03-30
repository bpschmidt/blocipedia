
class WikisController < ApplicationController
  def index
    @wiki = current_user.wikis
  end

  def show
    @wiki = Wiki.find(params[:id])
  end

  def new
    @wiki = Wiki.new
  end

  def create
    @wiki = Wiki.new(wiki_params)
    @wiki.user = current_user
    if @wiki.save
      redirect_to @wiki, notice: "Wiki was saved successfully."
    else
      flash[:error] = "Error creating wiki. Please try again."
      render :new
    end
  end

  def destroy
    @wiki = Wiki.find(params[:id])
    @wiki.delete
    redirect_to current_user
  end

  def edit
    @wiki = Wiki.find(params[:id])
  end

  def update
    @wiki = Wiki.find(params[:id])
    @wiki.title = (params[:wiki][:title])
    @wiki.body =  (params[:wiki][:body])
    @wiki.save
    redirect_to current_user
  end

  private

  def wiki_params
    params.require(:wiki).permit(:title, :body)
  end
end
