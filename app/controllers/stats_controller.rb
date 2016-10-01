class StatsController < ApplicationController
require 'Utils'
require "spark_pr"
include Spark

  before_action :set_stat, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  def index
    if params[:segment_id]=="0"
      #Agregate Mode
          #@stats = Stat.all.sort {|a,b| a.kmh.to_f <=> b.kmh.to_f}.reverse
          @stats = Stat.group("LOWER(name)").having("count(*) > 0").select("min(id),  max(name) as name,
            max(company) as company, min(time) as time, max(kmh) as kmh,
            min(minkm) as minkm, max(stars) as stars").sort {|a,b| a.kmh.to_f <=> b.kmh.to_f}.reverse
          i=0
          @stats.each do |stat|
            i=i+1
            stat.place=i
          end

          @segment=Segment.first
          if (@segment.nil?)
              @segment=Segment.new
          end
              @segment.name="Full Agregate"
       else
          @stats = Stat.where(segment_id: params[:segment_id]).order('place ASC')
          @segment=Segment.find_by(id: params[:segment_id])
    end
  end

  def graph
    @statsgraph = Stat.connection.select_all("SELECT  kmh
              FROM stats
            WHERE LOWER(name)=LOWER('#{params[:segment_id]}')
            ORDER BY segment_id ASC  ")
         @arraybig=[]
         @statsgraph.each do |stat|
              arraysmall=0.to_d
              stat.each do |key,value|
                arraysmall=value.to_d*10.to_i
              end
              3.times { @arraybig.push(arraysmall)}
          end
      if @statsgraph.size<=0
        0
      end

    respond_to do |format|
      format.xml  { render :xml => @arraybig.to_xml }
      format.json { render :json => @arraybig.to_json }
      format.png { send_data(Spark.plot( @arraybig, :has_min => true, :has_max => true, 'has_last' => 'true', 'height' => '15', :step => 8 ), :type => 'image/png',
                    :filename => "#{params[:segment_id]}.png",
                    :disposition => 'inline') }
    end
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

  def new
    @stat = Stat.new
  end

  def edit
  end

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

