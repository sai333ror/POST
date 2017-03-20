class PpostsController < ApplicationController
  before_action :set_ppost, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]

  # GET /pposts
  # GET /pposts.json
  def index
    @pposts = Ppost.all.order('created_at DESC')
  end

  # GET /pposts/1
  # GET /pposts/1.json
  def show
  end

  # GET /pposts/new
  def new
    @ppost = current_user.pposts.build
  end

  # GET /pposts/1/edit
  def edit
  end

  # POST /pposts
  # POST /pposts.json
  def create
    @ppost = current_user.pposts.build(ppost_params)

    respond_to do |format|
      if @ppost.save
        format.html { redirect_to @ppost, notice: 'Ppost was successfully created.' }
        format.json { render :show, status: :created, location: @ppost }
      else
        format.html { render :new }
        format.json { render json: @ppost.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pposts/1
  # PATCH/PUT /pposts/1.json
  def update
    respond_to do |format|
      if @ppost.update(ppost_params)
        format.html { redirect_to @ppost, notice: 'Ppost was successfully updated.' }
        format.json { render :show, status: :ok, location: @ppost }
      else
        format.html { render :edit }
        format.json { render json: @ppost.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pposts/1
  # DELETE /pposts/1.json
  def destroy
    @ppost.destroy
    respond_to do |format|
      format.html { redirect_to pposts_url, notice: 'Ppost was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ppost
      @ppost = Ppost.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def ppost_params
      params.require(:ppost).permit(:title, :body)
    end
end
