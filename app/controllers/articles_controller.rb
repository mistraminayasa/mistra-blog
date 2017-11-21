class ArticlesController < ApplicationController
    before_action :set_article, only: [:show, :edit, :update, :destroy]

    def index
        @articles = Article.paginate(page: params[:page], per_page: 5 )
    end
    def new
        @article = Article.new
    end

    def create
        debugger
         @article = Article.new(article_params)
         @article.user = User.first 
        if @article.save
            #do something
            flash[:success] = "Artikel berhasil ditambahkan"
            redirect_to article_path(@article)
        else 
            render 'new'
        end
    end

    def show
    end

    def edit
    end

    def update
        if @article.update(article_params)
            #do something
            flash[:success] = "Artikel berhasil diedit"
            redirect_to article_path(@article)
        else 
            render 'edit'
        end
    end

    def destroy
        @article.destroy
        flash[:danger] = "Artikel berhasil dihapus"
        redirect_to articles_path
    end

    private

    def set_article
        @article = Article.find(params[:id])
    end
    
    def article_params
        params.require(:article).permit(:title, :description)
    end
end