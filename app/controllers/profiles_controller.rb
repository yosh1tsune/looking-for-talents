class ProfilesController < ApplicationController
    def new
        @profile = Profile.new
    end

    def create

    end

    def show
        @profile = Profile.find_by candidate_id: params[:id]
    end
end