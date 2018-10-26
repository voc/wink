class ProductsController < ApplicationController

  before_action :find_product, except: [:index, :create, :new]

  def show
    respond_to do |format|
      format.html
      format.json { render :json => @product.to_json }
    end
  end

  def index
    respond_to do |format|
      format.html do
        @products = Product.all
      end

      format.json do
        @products = Product.all

        render json: @products
      end
    end
  end


  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)

    if @product.save
      redirect_to product_path(@product), notice: "Created product #{@product.name}"
    else
      render action: 'new'
    end
  end

  def edit
  end

  def update
    if @product.update_attributes(product_params)
      redirect_to product_path(@product), notice: "Updated '#{@product.name}'"
    else
      render action: 'edit'
    end
  end

  def delete
  end

  def destroy
    if @product.destroy!
      redirect_to case_path(@product.case), notice: "Deleted '#{@product.name}'"
    else
     render action: 'edit'
    end
  end


  private

  def find_product
    @product = Product.unscoped.find(params[:id])
  end

  def product_params
    params.require(:product).permit(:name, :description, :product_number,
                                    :product_link)
  end

end
