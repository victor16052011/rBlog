class ArticlesController < ApplicationController
  before_action :authenticate_user!, except: [:show,:index] 
  before_action :set_article, except: [:index,:new,:create]
  before_action :authenticate_editor!, only: [:new,:create,:update]
  before_action :authenticate_admin!, only: [:destroy,:publicado]
  #get /articles
  def index
  	@articles = Article.paginate(page: params[:page], per_page:8).publicados.ultimos   
  end
  #Get articles:id
  def show
    @article.update_visit_count
    @coment = Coment.new
  end

  #GET /articles/new
  def new
  	@article = Article.new
    @categories = Category.all
  end

  def destroy
  	@article.destroy
  	redirect_to articles_path
  end


  #POST /articles
  def create
  	#@article = Article.new ({titulo: params[:article][:titulo],
  	#						 cuerpo: params[:article][:cuerpo]})
  	@article = current_user.articles.new(article_params);
    @article.categories = params[:categories]
  	if @article.save
  		redirect_to @article
  	else
  		render :new
  	end

  end

  def edit
  end

  def update
  	if @article.update(article_params)
  		redirect_to @article
  	else
  		render :edit
  	end
  end

  def publicado
    @article.publicado!
    redirect_to @article
  end

  def validate_user
    redirect_to new_user_session_path, notice: "Necesitas Iniciar Session"
  end
  def set_article
      @article = Article.find(params[:id])
  end
  def article_params
  	params.require(:article).permit(:titulo,:cuerpo,:cover,:categories)
  end

end
