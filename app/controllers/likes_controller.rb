class LikesController < ApplicationController
  before_action :set_like, only: %i[show edit update destroy]

  # GET /likes or /likes.json
  def index
    @likes = Like.all
  end

  # GET /likes/1 or /likes/1.json
  def show; end

  # GET /likes/new
  def new
    @like = Like.new
  end

  # GET /likes/1/edit
  def edit; end

  # POST /likes or /likes.json
  def create
      @post = Post.includes(:user).find(params[:post_id])
    @post_author = @post.user

    @the_user = current_user

    @liked_posts_by_this_user = Like.where(user: @the_user, post: @post)

    destroy && return if @liked_posts_by_this_user.present?

    new_like = Like.create(user: @the_user, post: @post)

    return unless new_like.save

    flash[:notice] = 'You liked this post.'
    redirect_back_or_to user_post_url(@post_author, @post)
  end

  # PATCH/PUT /likes/1 or /likes/1.json
  def update
    respond_to do |format|
      if @like.update(like_params)
        format.html { redirect_to like_url(@like), notice: 'Like was successfully updated.' }
        format.json { render :show, status: :ok, location: @like }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @like.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /likes/1 or /likes/1.json
 def destroy
    @liked_posts_by_this_user.destroy_all
    flash[:notice] = 'You removed your like from this post.'
    redirect_back_or_to user_post_url(@post_author, @post)
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_like
    @like = Like.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def like_params
    params.fetch(:like, {})
  end
end
