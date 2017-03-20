class CommentsController < ApplicationController
  before_action :set_comment, only: [:show, :edit, :update, :destroy]

  # GET /comments
  # GET /comments.json
  def index
    ppost = Ppost.find(params[:ppost_id])
    @comments = ppost.comments.order('created_at DESC')
  end

  # GET /comments/1
  # GET /comments/1.json
  def show
    ppost = Ppost.find(params[:ppost_id])
    @comment = ppost.comments.find(params[:id])
  end

  # GET /comments/new
  def new
    ppost = Ppost.find(params[:ppost_id])
    @comment = ppost.comments.new
  end

  # GET /comments/1/edit
  def edit
    ppost = Ppost.find(params[:ppost_id])
    @comment = ppost.comments.find(params[:id])
  end

  # POST /comments
  # POST /comments.json
  def create
    ppost = Ppost.find(params[:ppost_id])
    h = comment_params
    h = h.merge("user_id" => current_user.id)
    @comment = ppost.comments.create(h)

    respond_to do |format|
      if @comment.save
        format.html { redirect_to ppost, notice: 'Comment was successfully created.' }
        format.json { render :show, status: :created, location: @comment }
      else
        format.html { render :new }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /comments/1
  # PATCH/PUT /comments/1.json
  def update
    ppost = Ppost.find(params[:ppost_id])
    @comment = ppost.comments.find(params[:id])
    respond_to do |format|
      if @comment.update(comment_params)
        format.html { redirect_to [@comment.ppost, @comment], notice: 'Comment was successfully updated.' }
        format.json { render :show, status: :ok, location: @comment }
      else
        format.html { render :edit }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /comments/1
  # DELETE /comments/1.json
  def destroy
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to comments_url, notice: 'Comment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def comment_params
      params.require(:comment).permit(:body)
    end
end
