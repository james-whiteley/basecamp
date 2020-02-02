class Api::V1::ProjectsController < ApplicationController
	before_action :find_project, only: [:show, :update, :destroy]

	# GET /projects
	def index
		@projects = Project.all
		paginate json: @projects
	end

	# GET /projects/:id
	def show
		render json: @project
	end

	# POST /projects
	def create
		@project = Project.new(project_params)
		if @project.save
			render json: @project
		else
			render error: { error: 'Unable to create project' }, status: 400
		end
	end

	# PUT /projects/:id
	def update
		if @project
			@project.update(project_params)
			render json: { message: 'Project successfully updated' }, status: 200
		else
			render json: { error: 'Unable to update Project' }, status: 400
		end
	end

	# DELETE /projects/:id
	def destroy
		if @project
			@project.destroy
			render json: { message: 'Project successfully deleted' }, status: 200
		else
			render json: { error: 'Unable to delete project' }, status: 400
		end
	end

	private

	def project_params
		params.require(:project).permit(:title, :project, :author, :to_be_completed, :completed, :description)
	end

	def find_project
		@project = Project.find(params[:id])
	end
end
