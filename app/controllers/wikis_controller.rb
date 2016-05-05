
class WikisController < ApplicationController

before_filter :authenticate_user!
  #before_action :require_sign_in, except: [:index, :show]
  # before_action :authorize_user, except: [:index, :show]
  def index
    if current_user.admin? || current_user.premium?
      @wikis = Wiki.all
    elsif current_user
      @wikis = current_user.wikis + Wiki.where(private: false)
    else
      @wikis = Wiki.where(private: false)
    end
  end

  def show
     @wiki = Wiki.find(params[:id])


    # if current_user.admin? || current_user.premium?
    #   @wiki = Wiki.visible_to(current_user)
    #   render "wikis/show.html.erb"
    # else
    #   flash[:alert] = "You are not authorized to see this private wiki."
    #   #redirect_to new_user_session_path
    # end

    # unless @wiki.public || current_user
    #   flash[:alert] = "You must be signed in to view private topics."
    #   redirect_to new_user_session_path
    # end
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
    authorize @wiki
    @wiki.delete
    redirect_to current_user
  end

  def edit
    @wiki = Wiki.find(params[:id])
    authorize @wiki
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
