class RecordingsController < ApplicationController
  before_action :set_recording, only: [:show, :edit, :update, :destroy]

  # GET /recordings
  # GET /recordings.json
  def index
    @recordings = Recording.all.order(:name)
  end

  # GET /recordings/1
  # GET /recordings/1.json
  def show
  end

  # GET /recordings/new
  def new
    @recording = Recording.new
  end

  # GET /recordings/1/edit
  def edit
  end

  # POST /recordings
  # POST /recordings.json
  def create
    file = params[:recording][:file]
    bucket_object = S3_BUCKET.object('recordings/' + file.original_filename)
    bucket_object.upload_file(file.tempfile.path)

    @recording = Recording.new(recording_params.merge( { url: bucket_object.public_url }))

    respond_to do |format|
      if @recording.save
        format.html { redirect_to @recording.song, notice: 'Recording was successfully created.' }
        format.json { render :show, status: :created, location: @recording }
      else
        format.html { render :new }
        format.json { render json: @recording.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /recordings/1
  # PATCH/PUT /recordings/1.json
  def update
    respond_to do |format|
      if @recording.update(recording_params)
        format.html { redirect_to @recording.song, notice: 'Recording was successfully updated.' }
        format.json { render :show, status: :ok, location: @recording }
      else
        format.html { render :edit }
        format.json { render json: @recording.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /recordings/1
  # DELETE /recordings/1.json
  def destroy
    @recording.destroy
    respond_to do |format|
      format.html { redirect_to recordings_url, notice: 'Recording was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_recording
      @recording = Recording.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def recording_params
      params.require(:recording).permit(:name, :url, :description, :song_id, :file)
    end
end
