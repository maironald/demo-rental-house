# frozen_string_literal: true

module FlowbiteHelper
  def alert_variant_class(type)
    {
      alert: 'text-red-800 rounded-lg bg-red-50 dark:bg-gray-800 dark:text-red-400',
      notice: 'text-blue-800 rounded-lg bg-blue-50 dark:bg-gray-800 dark:text-blue-400'
    }[type.to_sym] || type.to_s
  end
end
