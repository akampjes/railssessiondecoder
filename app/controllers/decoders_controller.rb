class DecodersController < ApplicationController
  # GET /decoders
  # GET /decoders.json
  def index
    new
    render
  end

  # GET /decoders/new
  def new
    @decoder = Decoder.new
  end

  # POST /decoders
  # POST /decoders.json
  def create
    @decoder = Decoder.new(decoder_params)

    begin
      @result = @decoder.decode_session
    rescue ActiveSupport::MessageVerifier::InvalidSignature
      flash.now[:error] = 'Invalid Signature'
    end
    p @result

    respond_to do |format|
      format.html { render :index }
      #if @result
      #  #format.html { redirect_to @decoder, notice: 'Decoder was successfully created.' }
      #  format.html { render :index, notice: 'Cookie was successfully created.' }
      #  #format.json { render :show, status: :created, location: @decoder }
      #else
      #  format.html { render :index, notice: 'Sadface' }
      #  #format.json { render json: @decoder.errors, status: :unprocessable_entity }
      #end
    end
  end

  private
  # Never trust parameters from the scary internet, only allow the white list through.
  def decoder_params
    params[:decoder].permit(:secret_key, :cookie)
  end
end
