# frozen_string_literal: true

class TimesheetsController < ApplicationController
  before_action :set_timesheet, only: %i[show edit update destroy]

  def index
    @timesheets = Timesheet.all
  end

  def show; end

  def new
    @timesheet = Timesheet.new
  end

  def edit; end

  def create
    @timesheet = Timesheet.new(timesheet_params)

    if @timesheet.save
      respond_to do |format|
        # format.html { redirect_to timesheet_path, notice: 'timesheet was successfully created.' }
        format.turbo_stream { flash.now[:notice] = 'timesheet was successfully created.' }
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @timesheet.update(timesheet_params)
      respond_to do |format|
        # format.html { redirect_to timesheet_path, notice: 'timesheet was successfully updated.' }
        format.turbo_stream { flash.now[:notice] = 'timesheet was successfully updated.' }
      end
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @timesheet.destroy

    respond_to do |format|
      format.html { redirect_to timesheet_path, notice: 'timesheet was successfully destroyed.' }
      format.turbo_stream { flash.now[:notice] = 'timesheet was successfully destroyed.' }
    end
  end

  private

  def set_timesheet
    @timesheet = Timesheet.find(params[:id])
  end

  def timesheet_params
    params.require(:timesheet).permit(:start_time, :end_time)
  end

  def turbo_create
    flash.now[:notice] = t('common.create.success')
    turbo_stream.prepend(
      :timesheets, partial: 'timesheets/timesheet', locals: { timesheet: @timesheet }
    )
    render_turbo_stream_flash_messages
  end
end
