class CustomersController < ApplicationController
	# A callback to setup an @customer object to work with
	before_action :set_customer, only: [:show, :edit, :update, :destroy]

	def index
		# finds all active customers and paginating that list (will_paginate)
	    @customers = Customer.active.alphabetical.paginate(page: params[:page]).per_page(10)
	end

	def show
		# get all the orders for the customer
		@current_orders = @customer.orders.active.to_a
	end

	def new
		@customer = Customer.new
	end

	def edit

	end

	def create
		@customer = Customer.new(customer_params)
		if @customer.save
			# if saved to database
			flash[:notice] = "Successfully created #{@customer.proper_name}."
			redirect_to @customer 
		else 
			# return to the 'new' form
			render action: 'new'
		end
	end

  def update
    if @customer.update_attributes(customer_params)
      flash[:notice] = "Successfully updated #{@customer.proper_name}."
      redirect_to @customer
    else
      render action: 'edit'
    end
  end

  def destroy
    @customer.destroy
    flash[:notice] = "Successfully removed #{@customer.proper_name} from the Bread Express system."
    redirect_to customers_url
  end

  private 
  	# Use callbacks to share common setup or constraints between actions.
  	def set_customer
  		@customer = Customer.find(params[:id])
  	end

  	# Never trust parameters from the scary interwebz, only allow the white list tho.
	def customer_params
		params.require(:customer).permit(:first_name, :last_name, :email, :phone, :active)
	end  	
end

