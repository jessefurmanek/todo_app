class TodosController < ApplicationController

	def index
		@todo = Todo.new
		@todos = Todo.all

		respond_to do |format|
	    format.json { render json: @todos}
	    format.html 
    end
	end

	def show
		@todo = Todo.find_by(id: params[:id])

		if @todo
			respond_to do |format|
	      format.json { render json: @todo}
	      format.html # index.html.erb
	    end
	  else
	  	render :json => "Task does not exist", :status => 404
	  end
	end	

	def new
		@todo = Todo.new
	end

	def create
		@todo = Todo.new(todos_params)		
		@todo.complete = 0

		if @todo.valid?
			@todo.save

			@todos = Todo.all
			
			respond_to do |format|
	      format.json { render json: @todo}
	      format.html { redirect_to(todos_path) }
    	end

		else
			render :json => { :errors => @todo.errors.as_json }, :status => 42
		end
	end

	def edit
		@todo = Todo.where(id: params[:id]).first
	end

	def update
		@todo = Todo.where(id: params[:id]).first

		if @todo.valid?
			@todo.update_attributes(todos_params)
			respond_to do |format|
	    	format.json { render json: @todo}
	    	format.html { redirect_to(todo_path) }
    	end
		else
			render :json => { :errors => @todo.errors.as_json }, :status => 42
		end		
	end

	def destroy
		@todo = Todo.find(params[:id])
		@todo.destroy
		@todos = Todo.all

		respond_to do |format|
      format.json { render json: @todos}
      format.html { redirect_to(:back) }
  	end		

	end

	def mark_complete
		@todo = Todo.find(params[:id])
		@todo.complete = 1
		@todo.save

  	respond_to do |format|
      format.json { render json: @todo}
      format.html { redirect_to(@todo) }
  	end	
	end

	def mark_incomplete
		@todo = Todo.find(params[:id])
		@todo.complete = 0
		@todo.save

  	respond_to do |format|
      format.json { render json: @todo}
      format.html { redirect_to(@todo) }
  	end	
	end	

  private	

  def todos_params
    params.require(:todo).permit(:task, :complete, :due_date, :user_id)
  end	
end
