class BlogsController < ApplicationController
    before_action :set_blog ,only: [:show, :edit,:update, :destroy]
    before_action :require_user, except: [:show, :index]
    before_action :require_same_user, only: [:edit, :update, :destroy]
  
    def show
    end
  
    def index
      @pagy, @blogs = pagy(Blog.includes(:user), items: 4)
    end
    
    def new
      @blog = Blog.new
    end
  
    def edit
    end
  
    def create
      @blog = Blog.new(blog_params)
      @blog.user = current_user
      if @blog.save
        redirect_to @blog, :notice => "Blog was successfully created."
      else
        render :new
      end
    end
  
    def update
      if @blog.update(blog_params)
        redirect_to @blog, :notice=>"Blog was successfully updated."
      else
        render :edit
      end
    end
  
    def destroy
      @blog.destroy
      redirect_to blogs_url, :notice => "Blog was successfully destroyed."
    end
    
    private
  
    def blog_params
      params.require(:blog).permit(:title, :description, :category_id)
    end
  
    def set_blog
      @blog = Blog.find(params[:id])
    end

    def require_same_user
      if current_user != @blog.user && !current_user.admin?
        redirect_to @blog , :notice => "You Can Only Edit or Delete Your Own Blogs"
      end
    end
  
  end
  