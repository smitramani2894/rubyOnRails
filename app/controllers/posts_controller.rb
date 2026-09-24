class PostsController < ApplicationController
  # include Authenticatable # makes this methods available inside this controller.

  # skip_forgery_protection only: [ :create, :update, :destroy ]
  # before_action : call :method before action
  # this can come from controller itself like :set_post etc,
  # include module/concern
  # an inherited conroller
  # before_action :authenticate_user, only: [ :create, :update, :destroy ]

  include SessionAuthenticatable
  before_action :authenticate_user, only: [ :new, :create, :edit, :update, :destroy ]
  before_action :set_post, only: [ :show, :edit, :update, :destroy ]
  before_action :authorize_post, only: [ :edit, :update, :destroy ]

  def index
    page = params[:page].to_i
    limit = params[:limit].to_i

    page = 1 if page < 1
    limit = 10 if limit < 1
    limit = 50 if limit > 50

    posts = Post.includes(:user)

    if params[:user_id].present?
        posts = posts.where(user_id: params[:user_id])
    end

    if params[:search].present?
      posts = posts.where(
        "title ILIKE :search OR content ILIKE :search",
        search: "%#{params[:search]}%"
      )
    end

    if params[:sort].present?
      allowed_column = %w[title created_at]

      sort_column = params[:sort]
      sort_column = "created_at" unless allowed_column.include?(sort_column)

      direction = params[:direction] == "asc" ? "asc" : "desc"

      posts = posts.order(sort_column => direction)
    end

    total = posts.count

    @posts = posts.offset((page-1) * limit).limit(limit)

    @pagination = {
    current_page: page,
    per_page: limit,
    total: total,
    total_pages: (total.to_f / limit).ceil
  }
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.build(post_params)

    if @post.save
      redirect_to post_path(@post), notice: "Post created successfully"

    else
       render :new, status: :unprocessable_entity
    end
  end

  def show
  end

  def edit
  end

  def update
    if @post.update(post_params)
      redirect_to post_path(@post), notice: "Post Updated successfully"

    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @post.destroy

      redirect_to posts_path, notice: "Post deleted successfully"

    else
      redirect_to posts_path, notice: "Post couldn't be deleted"
    end
  end

  private

    def set_post
    @post = Post.find(params[:id])
    end

  def authorize_post
    unless @post.user_id == current_user.id
     redirect_to posts_path, alert: "You are not allowed to modify this post."
    end
  end

  def post_params
    params.require(:post).permit(:title, :content)
  end
end
