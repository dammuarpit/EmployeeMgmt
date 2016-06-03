class DepartmentsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :validate_authorization!

  def index
    @departments = Department.order_by_asc.all
  end

  def show
    @department = Department.find(params[:id])
  end

  def new
    authorize! :create, Department
    @department = Department.new
  end

  def edit
    authorize! :update, Department
    @department = Department.find(params[:id])
  end

  def create
    authorize! :create, Department
    @department = Department.new(department_params)
    if @department.save
        redirect_to @department, notice: 'Department was successfully created.'
      else
        render :new
    end
  end

  def update
    authorize! :update, Department
    @department = Department.find(params[:id])
    if @department.update(department_params)
      redirect_to @department, notice: 'Department was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    authorize! :destroy, Department
    @department = Department.find(params[:id])
    @department.destroy
      redirect_to departments_url, notice: 'Department was successfully destroyed.'
  end

  private
  def department_params
    params.require(:department).permit(:name, :description)
  end

  def validate_authorization!
    authorize! :read, Department
  end

end
