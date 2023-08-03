class CalendarsController < ApplicationController

  # １週間のカレンダーと予定が表示されるページ
  def index

    @week_days = get_week

    

    @plan = Plan.new
  end

  # 予定の保存
  def create
    Plan.create(plan_params)
    redirect_to action: :index
  end

  private

  def plan_params
    params.require(:plan).permit(:date, :plan)
  end


  require 'date'  # 追加

  def get_week
    wdays = ['(日)','(月)','(火)','(水)','(木)','(金)','(土)']

  
    @todays_date = Date.today
    @week_days = []
  
    plans = Plan.where(date: @todays_date..@todays_date + 6)
  
    7.times do |x|
      today_plans = []
      plans.each do |plan|
        today_plans.push(plan.plan) if plan.date == @todays_date + x
      end
  
      # 曜日の添字を計算し、7以上になる場合は7を引いてループさせる
      wday_index = (@todays_date.wday + x) % 7
  
      days = { month: (@todays_date + x).month, date: (@todays_date + x).day, wday: wdays[wday_index], plans: today_plans }

      @week_days.push(days)
    end
  
    @week_days
  end
  


end
