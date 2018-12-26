class CompanyController < ApplicationController
  before_action :authenticate_employer
end
