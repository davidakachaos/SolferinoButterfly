class SeriesController < ApplicationController
  before_action :set_series, only: [:show, :edit, :update, :destroy]

  # GET /series
  def index
    @series = Serie.all
  end

  # GET /series/1
  def show
  end

  # GET /series/new
  def new
    @serie = Serie.new
  end

  # GET /series/1/edit
  def edit
  end

  # POST /series
  def create
    @serie = Serie.new(series_params)
    respond_to do |format|
      if @serie.save
        format.html { redirect_to @serie, notice: 'Serie was successfully created.' }
        format.json # { render json:  }
      else
        format.html { render :new }
        format.json { render json: @serie.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /series/1
  def update
    respond_to do |format|
      if @serie.update(series_params)
        format.html{ redirect_to @serie, notice: 'Serie was successfully updated.' }
        format.json
      else
        format.html { render :edit }
        format.json { render json: @serie.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /series/1
  def destroy
    @serie.destroy
    redirect_to series_url, notice: 'Serie was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_series
      @serie = Serie.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def series_params
      params.require(:serie).permit(:name)
    end
end
