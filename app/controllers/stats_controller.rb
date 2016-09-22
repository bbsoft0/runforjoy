class StatsController < ApplicationController
  before_action :set_stat, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  require 'csv'
  require 'database_cleaner'

  def index
    @stats = Stat.all
  end


  def show
    @stats = Stat.where(segment_id: params[:id])
    @segment=Segment.find_by(id: @stat.segment_id)
  end

  def import
    filename ||= "#{Rails.root}/tmp/cn1.csv"
    csv_text = File.read(filename)
    csv = CSV.parse(csv_text, :headers => true)

    DatabaseCleaner.clean_with(:truncation, :only => %w[stats])
    # DatabaseCleaner.strategy = :truncation, { :except => %w[segment,user] }

    csv.each do |row|
      stat_row=Stat.new
      stat_row.place=row["place"]
      stat_row.segment_id=1
      stat_row.name=row["name"]
      stat_row.time=row["time"]
      stat_row.minkm=row["minkm"]
      stat_row.save!
    end

    respond_to do |format|
        format.html { redirect_to stat_path(1), notice: 'Stat was successfully created.' }
        format.json { render :show, status: :created, location: @stat }
    end

#redirect_to @stat, notice: 'File was successfully imported.'
#     uploaded_io = params[:filename]
# File.open(Rails.root.join('public', 'uploads', uploaded_io.original_filename), 'wb') do |file|
#   file.write(uploaded_io.read)
# end

    # filename = '../tmp/cn1.csv'
    # options = {:chunk_size => 100, :key_mapping => {:unwanted_row => nil, :old_row_name => :new_name}}
    # n = SmarterCSV.process(filename, options) do |chunk|
    #       # we're passing a block in, to process each resulting hash / row (block takes array of hashes)
    #       # when chunking is enabled, there are up to :chunk_size hashes in each chunk
    #       MyModel.collection.insert( chunk )   # insert up to 100 records at a time
    #end

    # redirect_to :action => "new"
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
        @stat = Stat.find_by(segment_id: params[:id])
        if @stat.nil?
          @stat=Stat.new
          @stat.segment_id=params[:id]
          @stat.save
        end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def stat_params
      params.require(:stat).permit(:segment_id, :place, :name, :company, :time, :minkm, :kmh, :stars)
    end
end
