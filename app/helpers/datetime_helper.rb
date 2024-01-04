# frozen_string_literal: true

module DatetimeHelper
  def format_date(date, type)
    date.presence || Date.current

    case type
    when type == 'dmy'
      date.strftime('%d-%m-%Y')
    when type == 'mdy'
      date.strftime('%m-%d-%Y')
    when type == 'ymd'
      date.strftime('%Y-%m-%d')
    when type == 'dby'
      date.strftime('%d-%B-%Y')
    end
  end

  def format_time(time)
    time.strftime('%H:%M')
  end

  def total_hours(start_time, end_time)
    end_time - start_time
  end
end
