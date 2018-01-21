class Wechat::AddressesController < Wechat::BaseController
  before_action :set_address, only: %i( edit show update destroy )

  def new
    @address = current_user.addresses.build
  end

  def index
    @addresses = current_user.addresses.all
  end

  def edit
  end

  def show
  end

  def update
    if @address.update(address_params)
      redirect_to wechat_addresses_url
    else
      render :edit
    end
  end

  def create
    @address = current_user.addresses.new(address_params)
    if @address.save
      redirect_to wechat_addresses_url
    else
      render :new
    end
  end

  def destroy
    @address.destroy
    redirect_to wechat_addresses_url
  end

  private

    def set_address
      @address = current_user.addresses.find params[:id]
    end

    def address_params
      params.require(:address).permit(:name, :phone_number, :info)
    end

end