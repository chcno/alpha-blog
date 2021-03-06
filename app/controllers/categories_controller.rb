class CategoriesController < ApplicationController
before_action :set_category, only: [:show, :edit, :update, :destroy]
before_action :require_admin, except: [:index, :show]




  def new
      @category = Category.new
  end

  def index
    @category = Category.all
    @category = Category.paginate(page: params[:page], per_page: 5)

  end

  def show
    @category = Category.find(params[:id])
    @articles = @category.articles.paginate(page: params[:page], per_page: 5)
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:notice] = "La categoria fue creada exitosamente"
      redirect_to @category

    else
      render 'new'
    end

  end

  def edit
  end

  def update


          if @category.update(category_params)

            flash[:notice] = "Categoria editada exitosamente"
            redirect_to @category
          else
            render 'edit'
          end

  end


  private

  def require_admin
    if !(logged_in? && current_user.admin?)
      flash[:alert] = "only admins can create categories"
      redirect_to categories_path

    end
  end
  def set_category
    @category = Category.find(params[:id])


  end
  def category_params
    params.require(:category).permit(:name)
  end
end
