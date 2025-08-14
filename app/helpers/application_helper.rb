module ApplicationHelper
  def truncate_key(key, length = 8)
    
    return "N/A" if key.nil?

    start = key[0..length]
    ending = key[-length..-1]

    "#{start}...#{ending}"
  end
end