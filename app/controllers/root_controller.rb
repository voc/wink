# frozen_string_literal: true

class RootController < ApplicationController
  def show
    redirect_to dashboard_path
  end
end
