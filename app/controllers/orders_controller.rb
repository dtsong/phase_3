class OrdersController < ApplicationController
	# A callback to setup an @order object to work with
	before_action :set_orders, only: [:show, :edit, :update, :destroy]

	def index 
		@orders = Order.chronological.paginate(page: params[:page]).per_page(10)
	end

	def show
	end

	def new
		@order = Order.new
	end

	def edit
	end

	def create
		@order = Order.new(order_params)
		if @order.save
			flash[:notice] = "Successfully created an order."
			redirect_to @order
		else
			render action: 'new'
		end
	end

	def update
		if @order.update_attributes(order_params)
			flash[:notice] = "Successfully updated the order."
			redirect_to @order
		else
			render action: 'edit'
		end
	end

	def destroy
		@order.destroy
		flash[:notice] = "Successfully destroyed the order."
		redirect_to orders_url
	end

	private
	# Use callbacks to share common setup or constraints between actions.
	def set_order
		@order = Order.find(params[:id])
	end

	# Never trust parameters from the scary interwebz, white list params only pls
	def order_params
		params.require(:order).permit(:date, :customer_id, :address_id, :grand_total, :payment_receipt)
	end
end