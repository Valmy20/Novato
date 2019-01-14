class ContributorController < ApplicationController
  before_action :authenticate_collaborator
end
