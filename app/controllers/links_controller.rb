class LinksController < ApplicationController
  before_action do
    @campaign = Campaign.find(params[:campaign_id])
  end
  before_action :set_link, only: [:show, :edit, :update, :destroy]

  # GET /links
  # GET /links.json
  def index
    @links = @campaign.links.all.paginate(page:params[:page],per_page: 10)
  end


  def import
    @campaign.links.import(params[:file])
    redirect_to campaign_links_path, notice: 'Link was successfully imported.'
  end

  def take_screenshot
    @campaign.take_screenshot
    redirect_to campaign_links_path,notice: 'Screenshots successfully taken.'
  end

  def create_zip    
    send_file "#{Rails.root}/public/images/#{@campaign.name}/#{@campaign.name}"+".zip", type: "application/zip", x_sendfile: true,disposition: "attachment", filename: "file.zip"
  end

  # GET /links/1
  # GET /links/1.json
  def show
    @link = @campaign.links.find(params[:id])
  end

  # GET /links/new
  def new
    @link = @campaign.links.new
  end

  # GET /links/1/edit
  def edit
    @link=@campaign.links.find(params[:id])
  end

  # POST /links
  # POST /links.json
  def create
    @link =  @campaign.links.new(link_params)

    respond_to do |format|
      if @link.save
        format.html { redirect_to campaign_links_path, notice: 'Link was successfully created.' }
        format.json { render :show, status: :created, location: campaign_links_path }
      else
        format.html { render :new }
        format.json { render json: @link.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /links/1
  # PATCH/PUT /links/1.json
  def update
    respond_to do |format|
      if @link.update(link_params)
        format.html { redirect_to campaign_links_path, notice: 'Link was successfully updated.' }
        format.json { render :show, status: :ok, location: campaign_links_path }
      else
        format.html { render :edit }
        format.json { render json: @link.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /links/1
  # DELETE /links/1.json
  def destroy
    @link.destroy
    respond_to do |format|
      format.html { redirect_to campaign_links_path, notice: 'Link was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_link
      @link =  @campaign.links.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def link_params
      params.permit(:url)
    end
end
