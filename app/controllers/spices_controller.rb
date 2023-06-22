class SpicesController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found_response

    def index
        render json: Spice.all, status: :ok
    end

    def create
        spice = Spice.create(spice_params)
        render json: spice, status: :created
    end

    def destroy
        spice = find_spice
        spice.destroy
        head :no_content
    end

    def update
        spice = find_spice
        spice.update!(spice_params)
        render json: spice, status: :accepted
    end
    
    private

    def spice_params
        params.permit(:title, :image, :description, :notes, :rating)
    end

    def find_spice
        Spice.find_by(id: params['id'])
    end

    def record_not_found_response
        render json: {error: "Spice not found!"}
    end
end
