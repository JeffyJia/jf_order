class MenusController < ApplicationController
  load_and_authorize_resource

  def index
    if current_user.admin?
      @q = @menus.page(params[:page]).ransack(params[:q])
      @menus = @q.result
    else
      @q = current_user.menus.page(params[:page]).ransack(params[:q])
      @menus = @q.result
    end
  end

  def show
  end

  def new
    store = Store.find params[:store_id]
    if store
      @menu = store.menus.new
    end
    @menu.pictures.build
  end

  def list
    @menu = Menu.find params[:id]
    pictures = []
    @menu.pictures.all.each do |pic|
      new_picture = {
          id: pic.id,
          name: pic.picture_identifier,
          size: pic.picture.size,
          src: pic.picture.url(:thumb)
      }
      pictures << new_picture
    end

    render json: { images: pictures }
  end

  def upload
    @menu = Menu.find params[:id]
    @picture = @menu.pictures.new picture_params
    if @picture.save
      render json: { message: "success", pictureID: @picture.id }, status: 200
    else
      render json: { error: @picture.erros.full_message.join(', ') }, status: 400
    end
  end

  def remove
    @menu = Menu.find params[:id]
    @picture = @menu.pictures.find(params[:picture_id])
    if @picture.destroy
      render json: { message: "file deleted from server" }
    else
      render json: { message: @picture.errors.full_messages.join(", ") }
    end
  end

  def edit
  end

  def create
    @menu = Menu.new(menu_params)
    respond_to do |format|
      if @menu.save
        format.html {redirect_to @menu, notice: 'Menu was successfully created.'}
        format.json {render :show, status: :created, location: @menu}
      else
        format.html {render :new}
        format.json {render json: @menu.errors, status: :unprocessable_entity}
      end
    end
  end

  def update
    respond_to do |format|
      if @menu.update(menu_params)
        format.html {redirect_to @menu, notice: 'Menu was successfully updated.'}
        format.json {render :show, status: :ok, location: @menu}
      else
        format.html {render :edit}
        format.json {render json: @menu.errors, status: :unprocessable_entity}
      end
    end
  end

  def destroy
    @menu.destroy
    respond_to do |format|
      format.html {redirect_to menus_url, notice: 'Menu was successfully destroyed.'}
      format.json {head :no_content}
    end
  end

  def publish
    @menu = Menu.find params[:id]
    if @menu && !@menu.publish?
      @menu.publish!
      redirect_to @menu, notice: '菜品已上线!' and return
    end
    redirect_to @menu
  end

  def unpublish
    @menu = Menu.find params[:id]
    if @menu && @menu.publish?
      @menu.unpublish!
      redirect_to @menu, notice: '菜品已下线!' and return
    end
    redirect_to @menu
  end

  private

  def menu_params
    params.require(:menu).permit(:name, :intro, :price, :store_id)
  end

  def picture_params
    params.require(:menu).permit(:picture)
  end
end
