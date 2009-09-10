module BuysHelper
  def add_placement_path(buy, *args)
    if buy.new_record?
      add_placement_new_buy_path(*args)
    else
      add_placement_buy_path(buy, *args)
    end
  end
end
