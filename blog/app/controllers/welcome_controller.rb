class WelcomeController < ApplicationController
  def index
  end

  def pares
    @numero = params[:numero].to_i
  end
end
