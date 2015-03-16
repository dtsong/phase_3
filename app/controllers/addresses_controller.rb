class AddressesController < ApplicationController
	# A callback to setup a @address object to work with
	before_action :set_address, only: [:show, :edit, :update, :destroy]

	def index
        # get all the data on addresses in the system, 10 per page
		@addresses = Address.paginate(page: params[:page]).per_page(10)
	end

	def show
	end

	def new
		@address = Address.new
	end

	def edit
	end

	def create
		@address = Address.new(address_params)
		if @address.save
			flash[:notice] = "Successfully created an address in the system."
			redirect_to @address
		else
			render action: 'new'
		end
	end

	def update
		if @address.update_attributes(address_params)
			flash[:notice] = "Successfully updated the address."
			redirect_to @address
		else
			render action: 'edit'
		end
	end

	def destroy 
		@address.destroy
		flash[:notice] = "Successfully destroyed this address."
		redirect_to addresses_url
	end

	private 
	# Use callbacks to share common setup or constraints between actions.
	def set_address
		@address = Address.find(params[:id])
	end

	# Never trust parameters from the scary interwebz, only allow the white list tho.
	def address_params
		params.require(:address).permit(:customer_id, :is_billing, :recipient, :street_1, :street_2, :city, :state, :zip, :active)
	end

end