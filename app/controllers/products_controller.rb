class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :update]

  def index
    render json: Product.all
  end

  def update
    if @product.update(product_params)
      render json: @product, status: :ok
    else
      render json: { errors: @product.errors.full_messages }, status: :unprocessable_entity
    end
  end
  
  def create
    @product = Product.new(product_params)
   
    if @product.save
      render json: @product, status: :created
    else
      render json: { errors: @product.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def show
    render json: @product
  end

  private
    def set_product
      @product = Product.find(params[:id])
    end

    def product_params
      params.require(:product).permit(:image, :name, :price, :quantity, :description)
    end
end
