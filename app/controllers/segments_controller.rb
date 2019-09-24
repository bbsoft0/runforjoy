class SegmentsController < ApplicationController
  before_action :authenticate_user!, :except => [:index]
  before_action :set_segment, only: [:show, :edit, :update, :destroy]

  # GET /segments
  # GET /segments.json
  def index
    @segments = Segment.all.order('id ASC')
  end

  # GET /segments/1
  # GET /segments/1.json
  def show

  end

  # GET /segments/new
  def new
    @segment = Segment.new
  end

  # GET /segments/1/edit
  def edit
  end


  # POST /segments
  # POST /segments.json
  def create
    @segment = Segment.new(segment_params)

    respond_to do |format|
      if @segment.save
        format.html { redirect_to @segment, notice: 'Segment was successfully created.' }
        format.json { render :show, status: :created, location: @segment }
      else
        format.html { render :new }
        format.json { render json: @segment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /segments/1
  # PATCH/PUT /segments/1.json
  def update
    respond_to do |format|
      if @segment.update(segment_params)
        format.html { redirect_to @segment, notice: 'Segment was successfully updated.' }
        format.json { render :show, status: :ok, location: @segment }
      else
        format.html { render :edit }
        format.json { render json: @segment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /segments/1
  # DELETE /segments/1.json
  def destroy
    @segment.destroy
    Stat.where(segment_id: @segment.id).destroy_all
    respond_to do |format|
      format.html { redirect_to segments_url, notice: 'Segment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_segment
      @segment = Segment.find(params[:id])
    end

    def segment_params
        params.require(:segment).permit(:id,:name, :dist, :compdate, :goal)
    end

end
