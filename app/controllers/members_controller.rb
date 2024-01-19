# frozen_string_literal: true

class MembersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_member, only: %i[show edit update destroy]

  def index
    @renter = Renter.find(params[:renter_id])
    # @members = Member.find(renter_id: params[:renter_id])
    @members = Member.where(renter_id: params[:renter_id])
  end

  def show_all_member
    @members = Member.all
  end

  def show; end

  def new
    @member = Member.new
  end

  def edit; end

  def create
    @renter = Renter.find(params[:renter_id])
    @member = @renter.members.build(member_params)
    if @member.save
      redirect_to renter_members_path, notice: 'Member was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @member.update(member_params)
      respond_to do |format|
        format.html { redirect_to renter_members_path, notice: 'Member was successfully updated.' }
      end
    else
      render :edit
    end
  end

  def destroy
    @member.destroy
    respond_to do |format|
      format.html { redirect_to renter_members_path, notice: 'Member was successfully deleted.' }
    end
  end

  private

  def set_member
    @member = Member.find(params[:id])
  end

  def member_params
    params.require(:member).permit(:name, :phone_number, :identity, :gender, :relation)
  end
end
