class StoresController < ApplicationController
  load_and_authorize_resource

  def index
    @q = @stores.page(params[:page]).ransack(params[:q])
    @stores = @q.result
  end

  def show
  end

  def new
  end

  def edit
  end

  def create
    respond_to do |format|
      if @store.save
        format.html { redirect_to @store, notice: 'Store was successfully created.' }
        format.json { render :show, status: :created, location: @store }
      else
        format.html { render :new }
        format.json { render json: @store.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @store.update(store_params)
        format.html { redirect_to @store, notice: 'Store was successfully updated.' }
        format.json { render :show, status: :ok, location: @store }
      else
        format.html { render :edit }
        format.json { render json: @store.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @store.destroy
    respond_to do |format|
      format.html { redirect_to stores_url, notice: 'Store was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

    def store_params
      params.require(:store).permit(:name, :intro, :user_id, :location_id,
                                    picture_attributes: [:id, :picture, :imageable_type, :imageable_id],
                                    business_hours_attributes: [:id, :open_at, :close_at, :_destroy])
    end
end
