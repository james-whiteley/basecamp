class Api::V1::TasksController < ApplicationController
	#before_action :find_task, only: [:show, :update, :destroy]

	# GET /tasks
	def index
		@tasks = Task.where(:project_id => params[:project_id])
		paginate json: @tasks
	end

	# GET /tasks/:id
	def show
		@task = Task.where(:project_id => params[:project_id], :id => params[:id]).first
		if @task.present?
			render json: @task
		else
			render json: { error: 'Unable to find Task' }, status: 404
		end
	end

	# POST /tasks
	def create
		@params = task_params

		#Add project_id to new Task hash
		@params[:project_id] = params[:project_id]

		@task = Task.new(@params)
		if @task.save
			render json: @task
		else
			render error: { error: 'Unable to create task' }, status: 400
		end
	end

	# PUT /tasks/:id
	def update
		@task = Task.where(:project_id => params[:project_id], :id => params[:id]).first
		if @task
			@task.update(task_params)
			render json: { message: 'Task successfully updated' }, status: 200
		else
			render json: { error: 'Unable to update Task' }, status: 400
		end
	end

	# DELETE /tasks/:id
	def destroy
		@task = Task.where(:project_id => params[:project_id], :id => params[:id]).first

		if @task
			@task.destroy
			render json: { message: 'Task successfully deleted' }, status: 200
		else
			render json: { error: 'Unable to delete task' }, status: 400
		end
	end

	private

	def task_params
		params.require(:task).permit(:title, :project_id, :author, :to_be_completed, :completed, :description)
	end

	def find_task
		@task = Task.find(params[:id])
	end
end
