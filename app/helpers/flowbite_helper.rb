# frozen_string_literal: true

module FlowbiteHelper
  def alert_variant_class(type)
    {
      success: 'text-green-800 bg-green-200 rounded-lg dark:bg-green-800 dark:text-green-200',
      notice: 'text-orange-500 bg-orange-100 rounded-lg dark:bg-orange-700 dark:text-orange-200',
      danger: 'text-red-500 bg-red-100 rounded-lg dark:bg-red-800 dark:text-red-200'
    }[type.to_sym] || type.to_s
  end

  def border_variant_class(type)
    {
      success: 'border-green-500',
      notice: 'border-orange-500',
      danger: 'border-red-500'
    }[type.to_sym] || type.to_s
  end

  def choose_image_variant(type)
    {
      success: 'images/icons/success.svg',
      notice: 'images/icons/notice.svg',
      danger: 'images/icons/danger.svg'
    }[type.to_sym] || type.to_s
  end
end
