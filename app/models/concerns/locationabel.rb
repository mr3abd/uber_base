module Locationabel
  extend ActiveSupport::Concern

  def distance_to(instance)
    x1 = location.x
    y1 = location.y
    x2 = instance.location.x
    y2 = instance.location.y

    Math.sqrt((x1 - x2)**2 + (y1 - y2)**2)
  end
end
