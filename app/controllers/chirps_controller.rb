class ChirpsController < ApplicationController
  before_action :set_chirp, only: %i[ show edit update destroy ]

  # GET /chirps or /chirps.json
  def index
    @chirps = if Current.user.for_you_feed_preference?
      # TODO: implement "for you" feed
      Chirp.all.includes(:user, :parent_chirp).page(params[:page])
    else
      Chirp.following_feed_for(Current.user).includes(:user, :parent_chirp).page(params[:page])
    end

    respond_to do |format|
      format.html
      format.turbo_stream
    end
  end

  # GET /chirps/1 or /chirps/1.json
  def show
  end

  # GET /chirps/new
  def new
    @chirp = Chirp.new
  end

  # GET /chirps/1/edit
  def edit
  end

  # POST /chirps or /chirps.json
  def create
    @chirp = Chirp.new(chirp_params)
    @chirp.user = Current.user

    respond_to do |format|
      if @chirp.save
        format.html { redirect_to @chirp, notice: "Chirp was successfully created." }
        format.json { render :show, status: :created, location: @chirp }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @chirp.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /chirps/1 or /chirps/1.json
  def update
    respond_to do |format|
      if @chirp.update(chirp_params)
        format.html { redirect_to @chirp, notice: "Chirp was successfully updated." }
        format.json { render :show, status: :ok, location: @chirp }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @chirp.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /chirps/1 or /chirps/1.json
  def destroy
    @chirp.destroy!

    respond_to do |format|
      format.html { redirect_to chirps_path, status: :see_other, notice: "Chirp was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  def set_chirp
    @chirp = Chirp.find(params.expect(:id))
  end

  def chirp_params
    params.expect(chirp: [ :body, :deleted_at, :in_reply_to_chirp_id ])
  end
end
