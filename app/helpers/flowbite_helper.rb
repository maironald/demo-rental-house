# frozen_string_literal: true

module FlowbiteHelper
  def alert_variant_class(type)
    {
      alert: 'text-green-800 bg-green-200 rounded-lg dark:bg-green-800 dark:text-green-200',
      notice: 'text-orange-500 bg-orange-100 rounded-lg dark:bg-orange-700 dark:text-orange-200',
      danger: 'text-red-500 bg-red-100 rounded-lg dark:bg-red-800 dark:text-red-200'
    }[type.to_sym] || type.to_s
  end

  def choose_image_variant(type)
    {
      alert: 'images/icons/check.svg',
      notice: 'images/icons/warning.svg',
      danger: 'images/icons/danger.svg'
    }[type.to_sym] || type.to_s
  end
end
