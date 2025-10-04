class CheckListUsersController < ApplicationController
  before_action :set_check_list_user, only: %i[ show edit update destroy ]

  # GET /check_list_users or /check_list_users.json
  def index
    @check_list_users = CheckListUser.all
  end

  # GET /check_list_users/1 or /check_list_users/1.json
  def show
  end

  # GET /check_list_users/new
  def new
    @check_list_user = CheckListUser.new
  end

  # GET /check_list_users/1/edit
  def edit
  end

  # POST /check_list_users or /check_list_users.json
  def create
    @check_list_user = CheckListUser.new(check_list_user_params)

    respond_to do |format|
      if @check_list_user.save
        format.html { redirect_to @check_list_user, notice: "Check list user was successfully created." }
        format.json { render :show, status: :created, location: @check_list_user }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @check_list_user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /check_list_users/1 or /check_list_users/1.json
  def update
    respond_to do |format|
      if @check_list_user.update(check_list_user_params)
        format.html { redirect_to @check_list_user, notice: "Check list user was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @check_list_user }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @check_list_user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /check_list_users/1 or /check_list_users/1.json
  def destroy
    @check_list_user.destroy!

    respond_to do |format|
      format.html { redirect_to check_list_users_path, notice: "Check list user was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_check_list_user
      @check_list_user = CheckListUser.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def check_list_user_params
      params.expect(check_list_user: [ :checklist_id, :user_id ])
    end
end
