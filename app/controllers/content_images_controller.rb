class ContentImagesController < ApplicationController
  protect_from_forgery except: :create
  
  def create
    @image = Image.new(image_params)
    if @image.save
      respond_to do |format|
        format.json { render :json => { url: @image.url, image_id: @image.id } }
      end
    else
      render js: "toastr.error('#{@image.errors.full_messages.join('\n')}')"
    end
  end
 
  def destroy
    @image = Image.find_by(id: params[:id])
    @image.destroy
    respond_to do |format|
      format.json { render :json => { status: :ok } }
    end
  end
  
  private
 
  def image_params
    params.require(:image).permit(:image)
  end
end