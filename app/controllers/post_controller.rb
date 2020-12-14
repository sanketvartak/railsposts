class PostController < ApplicationController
  #http_basic_authenticate_with name:"sanket", password:"1234", except: [:index, :show]
  before_action :authenticate_user!, except: [:index, :show]
  before_action :correct_user, only: [:edit, :update, :destroy]
  
  def index
    @posts = Post.all
    #render json:@posts 
  end
  def new
    #@post = Post.new
    @post = current_user.Post.build
  end
  def show
    @post = Post.find(params[:id])
  end
  def edit
    @post = Post.find(params[:id])
  end
  def update
    @post = Post.find(params[:id])
    if(@post.update(post_params))
      redirect_to @post
    else
      render 'edit'
    end
  end
  def create
      #render plain: params[:post].inspect 
      #@post =Post.new(post_params)
      @post =current_user.Post.build(post_params)
      if(@post.save)
        redirect_to @post
      else
        render 'new'
      end
  end
  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to post_index_path
  end
  private def post_params
    params.require(:post).permit(:title, :body, :user_id)
  end

  def about
    @title = "About Us";
    @content = "This is para";
  end
  def correct_user
    @user = current_user.Post.find_by(id: params[:id])
    redirect_to post_index_path, notice: "Not authorized to edit this post" if @user.nil?
  end

end
