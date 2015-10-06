class UsersController < ApplicationController

	def index
		@user = User.new
		@users = User.all

		respond_to do |format|
      format.json { render json: @users}
      format.html # index.html.erb
    end

	end

	def new
		@user = User.new
	end

	def create
		@user = User.new(user_params)
		@user.name.downcase!

		if @user.valid?
			@user.save
			redirect_to @user
		else
			render :json => { :errors => @user.errors.as_json }, :status => 42
		end
	end

	def incomplete
		@user = User.where(id: params[:id]).first
		@incomplete_todos = @user.todos.select{|todo| todo.complete ==false}

		respond_to do |format|
      format.json { render json: @incomplete_todos}
      format.html 
    end
	end

	def complete
		@user = User.where(id: params[:id]).first
		@complete_todos = @user.todos.select{|todo| todo.complete == true}

		respond_to do |format|
      format.json { render json: @complete_todos}
      format.html 
    end
	end

	def show
		@user = User.where(id: params[:id]).first
		if @user
			respond_to do |format|
	      format.json { render json: @user.todos}
	      format.html # index.html.erb
	    end
	  else
	  	render :json => "User does not exist", :status => 404
	  end
	end 

	def edit
    @user = User.find(params[:id])
  end

  def update
  	@user = User.find(params[:id])
    if @user.update_attributes(user_params)
     redirect_to @user
    else
    	render 'home'
    end
  end

	private 
		def user_params
			params.require(:user).permit(:name)
		end	
end
