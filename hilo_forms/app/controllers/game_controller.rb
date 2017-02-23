class GameController < ApplicationController

  def try

    # If a secret number is not already assigned
    if (cookies[:secret] == nil) || (cookies[:secret] == 0)
      # assign a random number between 1 and 100 inclusive
      r = Random.new
      cookies[:secret] = r.rand(1..100)
      cookies[:attempts] = 0
    end

    @attempts = cookies[:attempts].to_i
    # @attempts += 1

  # Checking secret number against the guess parameter
    if params[:guess].nil? || params[:guess] == "" || params[:guess].to_i <= 0 || params[:guess].to_i > 100
      @result = "Please enter a number between 1 and 100"
    elsif (params[:guess].to_i > cookies[:secret].to_i) && (cookies[:attempts].to_i < 8)
      @result = "Too High"
      @attempts = @attempts + 1
      cookies[:attempts] = @attempts
    elsif (params[:guess].to_i < cookies[:secret].to_i) && (cookies[:attempts].to_i < 8)
      @result = "Too Low"
      @attempts = @attempts + 1
      cookies[:attempts] = @attempts
    elsif (params[:guess].to_i == cookies[:secret].to_i) && (cookies[:attempts].to_i < 8)
      @result = "Correct! You Win!"
    else
      @result = "Game Over. You Lose."
    end
  end

  def reset
    cookies.delete :secret
    cookies.delete :attempts
    params.delete (:guess)
    redirect_to "/game"
  end

end
