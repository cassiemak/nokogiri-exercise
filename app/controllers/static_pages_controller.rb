class StaticPagesController < ApplicationController

  def index
    @companies = Company.all
  end

end
