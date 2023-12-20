module FinancialPlanners
  class TimeSlotsController < ApplicationController
    before_action :authenticate_financial_planner!

    def create
      date = params[:date].to_date
      financial_planner_id = current_financial_planner.id

      times = current_financial_planner.time_slots.where(date: date).pluck(:start_time)
      available_times = date.saturday ? TimeSlot::SATURDAY_TIMES - times : TimeSlot::SLOT_TIMES - times

      time_slots_to_insert = available_times.map do |time|
        TimeSlot.new(date:, financial_planner_id:, start_time: time)
      end

      TimeSlot.import! time_slots_to_insert
      redirect_to financial_planners_url, flash: { success: '登録完了' }
    rescue ActiveRecord::RecordInvalid => e
      redirect_to financial_planners_url, flash: { warning: e.record.errors[:date][0] }
    end
    def destroy
      date = params[:date]
      time_slots = current_financial_planner.time_slots.where(date: date.to_date)
      time_slots.each do |slot|
        slot.destroy!
      end
      redirect_to financial_planners_url, flash: { success: '削除完了' }
    rescue ActiveRecord::RecordInvalid => e
      redirect_to financial_planners_url, flash: { warning: e.record.errors[:date][0] }
    end

    private

    def time_slot_params
      params.require(:time_slot).permit(:date, :start_time)
    end
  end
end
