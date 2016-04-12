class Myaccount::AddressesController < ApplicationController
	def index
		@addresses = current_user.shipping_addresses	
	end

	def show
		 @address = current_user.addresses.find(params[:id])
	end
	
  def new
  	@address = Address.new
  end

  def create
    @address = current_user.addresses.new(allowed_params)
    @address.default = true          if current_user.default_shipping_address.nil?
    @address.billing_default = true  if current_user.default_billing_address.nil?

    respond_to do |format|
      if @address.save
        format.html { redirect_to(myaccount_address_url(@address), :notice => 'Address was successfully created.') }
      else
        @form_address = @address
        form_info
        format.html { render :action => "new" }
      end
    end  		
  end
private
	def allowed_params
		 params.require(:address).permit(:first_name, :last_name, :address1, :address2, :city, :state_id, :state_name, :zip_code, :default, :billing_default, :country_id)
	end
end