class ReviewsController < ApplicationController

  before_action :verify_user, only :create

   def create
    @product = Product.find(params[:product_id])
    @review = @product.reviews.new(rating: params[:review][:rating], description: params[:review][:description])
    @review.user = current_user
     if @review.save
      redirect_to product_path product_id
    else
      redirect_to root_path
    end
   end

   private

  def product_id
    params[:product_id]
  end

   def verify_user
    # binding.pry
    if !current_user
      redirect_to login_path
    end
  end

end
