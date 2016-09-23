class StatsController < ApplicationController
  before_action :set_stat, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!


  def index
    @stats = Stat.where(segment_id: params[:segment_id]).order('place ASC')
    @segment=Segment.find_by(id: params[:segment_id])
  end

  def show
    @stats = Stat.where(segment_id: params[:segment_id])
    @segment=Segment.find_by(id: params[:segment_id])
  end

  def import
    @segment=Segment.find_by(id: params[:segment_id])
    if Stat.import(params[:file], @segment.dist, params[:segment_id])
        redirect_to segment_stats_path(params[:segment_id]), notice: "File #{params[:file].original_filename} imported into current segment "
    else
        redirect_to segment_stats_path(params[:segment_id]), alert: "File #{params[:file].original_filename} import did not succeed. "
    end
  end

  # GET /stats/new
  def new
    @stat = Stat.new
  end

  # GET /stats/1/edit
  def edit
  end

  # POST /stats
  # POST /stats.json
  def create
    @stat = Stat.new(stat_params)

    respond_to do |format|
      if @stat.save
        format.html { redirect_to @stat, notice: 'Stat was successfully created.' }
        format.json { render :show, status: :created, location: @stat }
      else
        format.html { render :new }
        format.json { render json: @stat.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /stats/1
  # PATCH/PUT /stats/1.json
  def update
    respond_to do |format|
      if @stat.update(stat_params)
        format.html { redirect_to @stat, notice: 'Stat was successfully updated.' }
        format.json { render :show, status: :ok, location: @stat }
      else
        format.html { render :edit }
        format.json { render json: @stat.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /stats/1
  # DELETE /stats/1.json
  def destroy
    @stat.destroy
    respond_to do |format|
      format.html { redirect_to stats_url, notice: 'Stat was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_stat
        @stat = Stat.find_by(segment_id: params[:segment_id])
        # if @stat.nil?
        #   @stat=Stat.new
        #   @stat.segment_id=params[:segment_id]
        #   @stat.save
        # end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def stat_params
      params.require(:stat).permit(:segment_id, :place, :name, :company, :time, :minkm, :kmh, :stars)
    end
end
